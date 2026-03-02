@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   TikTok Live Tap Dashboard - 最新版への更新
echo ======================================================
echo.

:: Git のチェック
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [!] Git がインストールされていないため、自動更新はできません。
    echo 手動で最新の ZIP をダウンロードしてください。
    echo.
    pause
    exit /b 1
)

echo 最新の状態にアップデートします...
echo.

echo [1/2] 最新のプログラムを取得中...
call git pull

echo [2/2] 構成を更新中...
call npm install

echo.
echo アップデートが完了しました！
echo.
pause
