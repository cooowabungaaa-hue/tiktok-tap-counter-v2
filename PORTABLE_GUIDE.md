# TikTok Live Tap Dashboard - Portable Setup Guide

会社や学校のPCなど、プログラムのインストールが禁止されている環境でも動かせるようにするための手順です。

## 解決策：ポータブル版 Node.js を使う

インストールが不要な「ポータブル版」を使えば、インストールなしで動かせます。

### 【一番早い方法】他のフォルダからコピーする
デスクトップにある「tiktok-rose-counter-main」などのフォルダ内に `node-bin` というフォルダがあれば、それをそのままこのプロジェクトのフォルダの中にコピーしてください。それだけで動くようになります。

### 【新しく準備する方法】ポータブル版のダウンロード
1. [Node.js 公式ダウンロードページ](https://nodejs.org/ja/download/prebuilt-binaries) へ行きます。
2. **Windows (x64)** の **ZIP** ファイルをダウンロードします。
3. ダウンロードした ZIP を解凍し、中身をすべてこのプロジェクト内の `node-bin` という名前のフォルダに入れてください。

### 2. フォルダ構成のイメージ
```
tiktok-tap-counter-v2/
  ├── node-bin/          <-- ここに解凍した中身を入れる
  │     └── node.exe     <-- これが入っていればOK
  ├── public/
  ├── server.js
  ├── setup.bat
  └── start.bat
```

### 3. あとはいつも通り
`node-bin` フォルダさえ準備できれば、`setup.bat` や `start.bat` をダブルクリックするだけで、自動的にその中のプログラムを使って起動するようになっています。
