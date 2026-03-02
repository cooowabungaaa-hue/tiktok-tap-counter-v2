# TikTok Live Tap Dashboard v2

TikTokライブの「いいね（タップ）」ランキングと配信画面を1つのブラウザで管理できる統合モニターツールです。
OBSなどの複雑なツールを使わずに、ブラウザだけで熱心なファンの活動をリアルタイムに追跡できます。

![Dashboard Interface](https://api.dicebear.com/7.x/identicon/svg?seed=dashboard)

## 特徴

- **統合ダッシュボード**: 左側に配信（別窓連携）、右側にリアルタイムランキングを配置。
- **ブラウザ完結**: 複雑な設定は不要。TikTok IDを入力するだけですぐに開始可能。
- **自動データ集計**: 配信終了時に上位100名の実績をGoogleスプレッドシートへ自動保存。
- **プレミアムデザイン**: ダークモード対応の使いやすいインターフェース。

## インストールと実行

### 1. リポジトリをダウンロード
```bash
git clone https://github.com/cooowabungaaa-hue/tiktok-tap-counter-v2.git
cd tiktok-tap-counter-v2
```

### 2. セットアップ
```bash
npm install
```

### 3. 実行
```bash
npm start
```
※ Node.jsがインストールされている必要があります。

### 4. ブラウザで開く
`http://localhost:8081` を開きます。

## 使い方

1. 画面右上の **⚙ 設定** をクリック。
2. あなたの **TikTok ID**（@なし）を入力し、保存。
3. 画面中央の **「TikTok配信を別窓で開く」** をクリックして配信画面を横に並べます。
4. 視聴者がタップすると、右側のランキングがリアルタイムに更新されます。

## Googleスプレッドシート連携

1. Googleスプレッドシートを作成。
2. **拡張機能 > Apps Script** を開き、リポジトリ内の `google-script.gs` を貼り付けてデプロイ。
3. 発行されたURLを、本ツールの設定画面に入力してください。

## ライセンス

MIT License
