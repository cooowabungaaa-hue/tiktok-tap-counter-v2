@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 初回セットアップ
echo ======================================================
echo.

:: 1. 既に PATH にあるかチェック
set NODE_EXE=node
where %NODE_EXE% >nul 2>nul
if %ERRORLEVEL% EQU 0 goto NODE_FOUND

:: 2. 自分のフォルダ内の node-bin をチェック
if exist "%~dp0node-bin\node.exe" (
    set "PATH=%~dp0node-bin;%PATH%"
    goto NODE_FOUND
)

:: 3. 他のプロジェクトの node-bin をチェック (既存の環境用)
if exist "..\tiktok-rose-counter-main\node-bin\node.exe" (
    set "PATH=%~dp0..\tiktok-rose-counter-main\node-bin;%PATH%"
    goto NODE_FOUND
)
if exist "C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin\node.exe" (
    set "PATH=C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin;%PATH%"
    goto NODE_FOUND
)

:NODE_NOT_FOUND
echo [!] Node.js が見つかりませんでした。
echo.
echo 会社や管理制限のあるPCで、インストールができない場合は：
echo 1. 「PORTABLE_GUIDE.md」を読んでください。
echo 2. ポータブル版をダウンロードして「node-bin」フォルダに入れてください。
echo.
pause
exit /b 1

:NODE_FOUND
echo [✓] Node.js を確認しました。
echo.
echo [1/2] 必要なプログラムを準備しています...
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
