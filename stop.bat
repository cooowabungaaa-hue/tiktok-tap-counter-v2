@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 強制終了
echo ======================================================
echo.
echo ツールを安全に終了させ、画面を閉じます...
echo.

:: 1. 起動中のプログラム (node.exe) を終了させる
taskkill /f /im node.exe >nul 2>&1

:: 2. start.bat で開いた黒い画面をタイトルで探して終了させる
taskkill /f /fi "WINDOWTITLE eq TikTokLiveTap_Start*" /im cmd.exe >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo [✓] ツールと起動画面を正常に終了させました。
) else (
    echo [✓] 終了処理を完了しました。
)

echo.
echo 3秒後にこの画面を自動で閉じます。
timeout /t 3 > nul
exit
