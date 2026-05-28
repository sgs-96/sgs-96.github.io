# sgs-96.github.io

私のポートフォリオサイトです。GitHub Pages で公開する前提の静的サイトで、HTML / CSS と一部のインライン JavaScript だけで構成されています。

## 構成

- `index.html` - ポートフォリオのトップページ
- `assets/styles/` - 共通スタイルと個別ページ用スタイル
- `assets/images/` - トップページ、スライド、分析ページで使う画像
- `works/` - 作品ページ
- `hobbies/` - 趣味ページ
- `diagrams/` - システム構成図などの補助ページ
- `tools/` - メンテナンス用スクリプト

### 作品ページ

- `works/graduation-presentation/` - 卒業制作に係る発表
- `works/industry-academia/` - 産学連携プロジェクト
- `works/industry-academia/simulator.html` - カーリース × 地方活性化の試算シミュレーター
- `works/sf6-analysis/` - Street Fighter 6 のデータ取得・分析
- `works/claude-code/` - Claude Code による HP まとめ
- `works/bonomisaki-battle/` - 坊ノ岬沖海戦の戦況推移
- `works/eighty-six/` - 86 -EIGHTY SIX- のページ
- `works/video-clipper/` - MP4 クリッパー
- `works/training-calendar/` - 錬成カレンダー
- `works/spi-vocabulary/` - SPI 語句問題

## ローカル確認

静的サイトなので、そのまま HTML ファイルをブラウザで開けます。ルートから簡易サーバーを立てる場合は以下を使えます。

```powershell
python -m http.server 8000
```

その後、`http://localhost:8000/` を開きます。

## メンテナンス

ローカルリンクや画像参照の確認には以下を使います。

```powershell
powershell -ExecutionPolicy Bypass -File tools/check-local-links.ps1
```

未作成ページへのリンクは `tools/known-missing-links.txt` に記録しています。
