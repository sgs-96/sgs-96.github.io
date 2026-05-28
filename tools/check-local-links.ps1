param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$allowListPath = Join-Path $PSScriptRoot 'known-missing-links.txt'
$allowed = @{}

if (Test-Path -LiteralPath $allowListPath) {
  Get-Content -Encoding UTF8 -Path $allowListPath | ForEach-Object {
    $line = $_.Trim()
    if ($line -eq '' -or $line.StartsWith('#')) {
      return
    }
    $allowed[$line] = $true
  }
}

$missing = @()

Get-ChildItem -LiteralPath $Root -Recurse -File -Filter '*.html' |
  Where-Object { $_.FullName -notmatch '\\.git\\' } |
  ForEach-Object {
    $file = $_.FullName
    $dir = Split-Path -Path $file
    $relativeFile = (Resolve-Path -Relative -Path $file).TrimStart('.\').Replace('\', '/')
    $content = Get-Content -Encoding UTF8 -Raw -Path $file

    [regex]::Matches($content, '(?:href|src)="([^"]+)"') | ForEach-Object {
      $url = $_.Groups[1].Value

      if ($url -eq '' -or $url -match '^(https?:|mailto:|tel:|#|javascript:)') {
        return
      }

      $clean = (($url -split '#')[0] -split '\?')[0]
      if ($clean -eq '') {
        return
      }

      $key = "$relativeFile|$clean"
      if ($allowed.ContainsKey($key)) {
        return
      }

      $target = Join-Path -Path $dir -ChildPath $clean
      if (-not (Test-Path -LiteralPath $target)) {
        $missing += [PSCustomObject]@{
          File = $relativeFile
          Link = $url
        }
      }
    }
  }

if ($missing.Count -gt 0) {
  $missing | Sort-Object File, Link | Format-Table -AutoSize
  exit 1
}

Write-Output 'All checked local links resolve.'
