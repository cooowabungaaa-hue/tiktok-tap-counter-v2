@echo off
chcp 65001 > nul
setlocal

:: 最小化して再起動する仕組み
if not "%1"=="min" (
    start "TikTokLiveTap_Running_Window" /min cmd /c "%~nx0" min
    exit /b
)

:: タイトルを明示的に設定
title TikTokLiveTap_Running_Window

echo ======================================================
echo   TikTok Live Tap Dashboard - 起動
echo ======================================================
echo.

:: Node.js のチェック
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    if exist "%~dp0node-bin\node.exe" (
        set "PATH=%~dp0node-bin;%PATH%"
    ) else if exist "..\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=%~dp0..\tiktok-rose-counter-main\node-bin;%PATH%"
    ) else if exist "C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin\node.exe" (
        set "PATH=C:\Users\小野明子\Desktop\tiktok-rose-counter-main\node-bin;%PATH%"
    ) else (
        echo [!] Node.js が見つかりません。
        echo 先に setup.bat を実行して内容を確認してください。
        echo.
        pause
        exit /b 1
    )
)

echo ツールを起動しています...
echo ブラウザが自動的に開くまで数秒お待ちください。
echo (この画面は最小化されています)
echo.

call npm start

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ------------------------------------------------------
    echo 起動に失敗しました。
    echo ------------------------------------------------------
    pause
)
