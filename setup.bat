@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 初回セットアップ
echo ======================================================
echo.

:: Node.js のチェック
set NODE_EXE=node
where %NODE_EXE% >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    :: ポータブル版のパスをチェック
    if exist "..\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=%~dp0..\tiktok-rose-counter-main\node-bin;%PATH%"
        set NODE_EXE=node
    ) else if exist "C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin;%PATH%"
        set NODE_EXE=node
    ) else (
        echo [!] Node.js が見つかりませんでした。
        echo.
        echo 【解決方法】
        echo 以下のサイトから Node.js をインストールして、再起動してください。
        echo https://nodejs.org/ (推奨版/LTS を選択)
        echo.
        pause
        exit /b 1
    )
)

echo [✓] Node.js を確認しました。
echo.
echo [1/2] 必要なプログラムの準備中...
echo (これには数分かかる場合があります。そのままお待ちください)
echo.

call npm install

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ------------------------------------------------------
    echo エラーが発生しました。
    echo ------------------------------------------------------
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [2/2] 準備が完了しました！
echo 今後は start.bat をダブルクリックするだけでツールを起動できます。
echo.
pause
