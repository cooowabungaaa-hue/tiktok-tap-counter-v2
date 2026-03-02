@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 起動
echo ======================================================
echo.

:: Node.js のチェック
set NODE_EXE=node
where %NODE_EXE% >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    :: ポータブル版のパスをチェック
    if exist "..\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=%~dp0..\tiktok-rose-counter-main\node-bin;%PATH%"
    ) else if exist "C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin;%PATH%"
    ) else (
        echo [!] Node.js が見つかりません。
        echo 先に Node.js をインストールするか、setup.bat を確認してください。
        echo.
        pause
        exit /b 1
    )
)

echo ツールを起動しています...
echo.
echo ------------------------------------------------------
echo 💡 起動したら、ブラウザで以下を開いてください：
echo http://localhost:8081
echo ------------------------------------------------------
echo.

call npm start

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ------------------------------------------------------
    echo 起動に失敗しました。
    echo 先に setup.bat を実行して準備を済ませてください。
    echo ------------------------------------------------------
    pause
)
