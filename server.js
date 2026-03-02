const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const { WebcastPushConnection } = require('tiktok-live-connector');
const fetch = require('node-fetch');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const app = express();
const server = http.createServer(app);
const io = new Server(server);

const PORT = process.env.PORT || 8081;
const CONFIG_PATH = path.join(__dirname, 'config.json');

app.use(express.static('public'));
app.use(express.json());

// 設定の初期化
let config = {
    tiktokUsername: process.env.TIKTOK_USERNAME || '',
    googleSheetUrl: process.env.GOOGLE_SHEET_APP_SCRIPT_URL || ''
};

if (fs.existsSync(CONFIG_PATH)) {
    try {
        const savedConfig = JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf-8'));
        config = { ...config, ...savedConfig };
    } catch (e) {
        console.error('Failed to load config.json', e);
    }
}

// 視聴者データ保持用 (userId: { id, name, taps, avatar })
let viewers = {};
let tiktokConnection = null;

// API: 設定の取得
app.get('/api/config', (req, res) => {
    res.json(config);
});

// API: 設定の更新
app.post('/api/config', (req, res) => {
    const { tiktokUsername, googleSheetUrl } = req.body;
    config.tiktokUsername = tiktokUsername;
    config.googleSheetUrl = googleSheetUrl;

    fs.writeFileSync(CONFIG_PATH, JSON.stringify(config, null, 2));

    // TikTok接続を再起動
    reconnectTikTok();

    res.json({ success: true, config });
});

// API: 停止（サーバー終了）
app.post('/api/stop', (req, res) => {
    res.json({ success: true, message: 'Shutting down...' });
    console.log('Shutdown requested from UI. Executing stop.bat...');

    // 自信を終了させるために stop.bat を呼び出す
    // (stop.bat は node.exe を kill するので、ここが最後の処理になる)
    setTimeout(() => {
        const { exec } = require('child_process');
        exec('cmd /c stop.bat');
    }, 500);
});

let lastConnectedUsername = '';

// TikTok Live接続管理
function reconnectTikTok() {
    if (tiktokConnection) {
        tiktokConnection.disconnect();
    }

    // IDが新しく設定された場合のみデータをリセットする
    if (config.tiktokUsername !== lastConnectedUsername) {
        console.log(`New TikTok ID detected: ${config.tiktokUsername}. Resetting data.`);
        viewers = {};
        io.emit('rankingUpdate', []);
        lastConnectedUsername = config.tiktokUsername;
    }

    if (!config.tiktokUsername) {
        io.emit('statusUpdate', { connected: false, msg: 'TikTok ID未設定' });
        return;
    }

    tiktokConnection = new WebcastPushConnection(config.tiktokUsername);

    tiktokConnection.connect().then(state => {
        console.log(`Connected to TikTok Room ID: ${state.roomId}`);
        io.emit('statusUpdate', { connected: true, msg: `Connected: ${config.tiktokUsername}` });
    }).catch(err => {
        console.error('TikTok Connection Error:', err.message);
        io.emit('statusUpdate', { connected: false, msg: `Connection Error: ${err.message}` });

        // Retry logic
        setTimeout(reconnectTikTok, 10000);
    });

    tiktokConnection.on('disconnected', () => {
        console.log('TikTok Connection Disconnected');
        io.emit('statusUpdate', { connected: false, msg: 'Disconnected. Retrying...' });
        setTimeout(reconnectTikTok, 5000);
    });

    tiktokConnection.on('like', (data) => {
        const { userId, uniqueId, nickname, profilePictureUrl, likeCount } = data;

        if (!viewers[userId]) {
            viewers[userId] = {
                id: `@${uniqueId}`,
                name: nickname,
                taps: 0,
                avatar: profilePictureUrl
            };
        }

        viewers[userId].taps += likeCount;
        broadcastRanking();
    });

    tiktokConnection.on('disconnected', () => {
        console.log('TikTok connection disconnected');
        io.emit('statusUpdate', { connected: false, msg: 'Disconnected' });
        saveDataToGoogleSheet();
    });

    tiktokConnection.on('streamEnd', () => {
        console.log('Stream ended');
        saveDataToGoogleSheet();
    });
}

function broadcastRanking() {
    const sortedRanking = Object.values(viewers)
        .sort((a, b) => b.taps - a.taps)
        .slice(0, 100);

    io.emit('rankingUpdate', sortedRanking);
}

async function saveDataToGoogleSheet() {
    if (!config.googleSheetUrl) {
        console.warn('Google Sheet URL not configured, skipping save.');
        return;
    }

    const dataToSave = Object.values(viewers).sort((a, b) => b.taps - a.taps);
    if (dataToSave.length === 0) return;

    try {
        const response = await fetch(config.googleSheetUrl, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                timestamp: new Date().toLocaleString('ja-JP', { timeZone: 'Asia/Tokyo' }),
                username: config.tiktokUsername,
                ranking: dataToSave
            })
        });
        console.log('Data saved to Google Sheet');
    } catch (error) {
        console.error('Failed to save data to Google Sheet:', error);
    }
}

const { exec } = require('child_process');

server.listen(PORT, () => {
    const url = `http://localhost:${PORT}`;
    console.log(`Server is running on ${url}`);

    // サーバーが起動したら自動的にブラウザを開く
    const startCommand = process.platform === 'darwin' ? 'open' : process.platform === 'win32' ? 'start' : 'xdg-open';
    exec(`${startCommand} ${url}`);

    reconnectTikTok();
}).on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error('\n' + '='.repeat(50));
        console.error('[!] エラー: サーバーを起動できませんでした。');
        console.error(`原因: ポート ${PORT} は既に他のプログラムで使用されています。`);
        console.error('解決策: すでにツールが起動している可能性があります。');
        console.error('一度すべての「黒い画面」を閉じるか、PCを再起動してください。');
        console.error('='.repeat(50) + '\n');
        process.exit(1);
    } else {
        console.error('Server Error:', err);
    }
});
