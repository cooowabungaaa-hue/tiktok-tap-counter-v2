# TikTok Live Tap Ranking Monitor v2

TikTokライブのタップ（いいね）数をリアルタイムで計測し、ランキング形式で表示する外部ツールです。
ブラウザから誰のライブを計測するかを簡単に設定でき、配信終了後には自動的にGoogleスプレッドシートへ実績を保存できます。

![UI Mockup](https://api.dicebear.com/7.x/identicon/svg?seed=tiktok-tap)

## 特徴

- **リアルタイムランキング**: 視聴者のタップ（いいね）を秒速で反映。
- **ブラウザ完結の設定**: ツール上の「設定」ボタンからTikTok IDやスプレッドシートURLをいつでも変更可能。
- **データ自動蓄積**: ライブ終了時に、上位100名のデータをGoogleスプレッドシートへ自動送信。
- **プレミアムデザイン**: ダークモード対応の洗練されたUI。

## インストールと実行

### 1. リポジトリをクローン
```bash
git clone https://github.com/cooowabungaaa-hue/tiktok-tap-counter-v2.git
cd tiktok-tap-counter-v2
```

### 2. 依存関係のインストール
```bash
npm install
```

### 3. サーバー起動
```bash
npm start
```

### 4. ブラウザで開く
`http://localhost:8081` を開き、画面右上の「⚙ 設定」から計測したいTikTok IDを設定してください。

## Googleスプレッドシート連携の設定

1. Googleスプレッドシートを作成。
2. **拡張機能 > Apps Script** を開く。
3. `google-script.gs` の内容をコピー＆ペースト。
4. **デプロイ > 新しいデプロイ** を選択。
5. 種類を「ウェブアプリ」、アクセスできるユーザーを「全員」にしてデプロイ。
6. 発行されたURLを、本ツールの設定画面に入力。

## ライセンス

MIT License
