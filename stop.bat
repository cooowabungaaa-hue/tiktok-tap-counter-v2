@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 終了処理
echo ======================================================
echo.
echo ツールを安全に終了させています...
echo.

:: 1. 起動中のプログラム (node.exe) を終了させる
taskkill /f /im node.exe >nul 2>&1

:: 2. 起動用の黒い画面 (start.bat) をタイトルで探して、そのPIDを狙い撃ちで終了させる
:: taskkill /fi は不安定なため、tasklist から抽出する
for /f "tokens=2 delims=," %%a in ('tasklist /v /fo csv /nh ^| findstr /i "TikTokLiveTap_Running_Window"') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo [✓] 終了処理を完了しました。
echo.

:: もしこのバッチファイル自体が UI (Node.js) から呼ばれた場合は、
:: このウィンドウが残らないように exit する
if not "%1"=="noexit" (
    echo 3秒後にこの画面を閉じます。
    timeout /t 3 > nul
    exit
)
