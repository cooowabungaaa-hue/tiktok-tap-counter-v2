@echo off
setlocal
echo ======================================================
echo   TikTok Live Tap Dashboard - 起動
echo ======================================================
echo.
echo ツールを起動しています...
echo ブラウザで http://localhost:8081 を開いてください。
echo.

call npm start

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ------------------------------------------------------
    echo 起動に失敗しました。先に setup.bat を実行して準備を済ませてください。
    echo ------------------------------------------------------
    pause
)
