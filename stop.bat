@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 強制終了
echo ======================================================
echo.
echo ツールが重なっていたり、終了できない場合に実行してください。
echo.

:: 起動中のnodeプロセスをすべて終了させる
taskkill /f /im node.exe >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo [✓] ツールを正常に終了させました。
) else (
    echo [!] 現在、起動中のツールは見つかりませんでした。
)

echo.
echo これで再度 start.bat や launch-browser.vbs を開くことができます。
echo.
pause
