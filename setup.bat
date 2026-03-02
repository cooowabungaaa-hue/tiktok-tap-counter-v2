@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 初回セットアップ
echo ======================================================
echo.

:: --- Node.js 準備フェーズ ---

:CHECK_NODE
set NODE_EXE=node
where %NODE_EXE% >nul 2>nul
if %ERRORLEVEL% EQU 0 goto NODE_FOUND

:: ローカルの node-bin をチェック
if exist "%~dp0node-bin\node.exe" (
    set "PATH=%~dp0node-bin;%PATH%"
    goto NODE_FOUND
)

:: 他のプロジェクトから探す (ポータブル版の共有)
if exist "..\tiktok-rose-counter-main\node-bin\node.exe" (
    set "PATH=%~dp0..\tiktok-rose-counter-main\node-bin;%PATH%"
    goto NODE_FOUND
)
if exist "C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin\node.exe" (
    set "PATH=C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin;%PATH%"
    goto NODE_FOUND
)

:: ここまでで見つからない場合：自動ダウンロードを提案
echo [!] Node.js が見つかりませんでした。
echo.
echo このツールを動かすには Node.js という無料ソフトが必要です。
echo 会社PC等でインストールできない場合、ここに「ポータブル版」を
echo 自動でダウンロードして準備することができます。
echo.
set /p CHOICE="自動ダウンロードして準備しますか？ (y/n): "
if /i "%CHOICE%"=="y" (
    call get-node.bat
    goto CHECK_NODE
) else (
    echo.
    echo 中断しました。Node.js を手動で用意してください。
    pause
    exit /b 1
)

:NODE_FOUND
echo [✓] Node.js の準備ができました。
echo.
echo [1/2] 必要なプログラムの構成中...
echo (少し時間がかかります)
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
