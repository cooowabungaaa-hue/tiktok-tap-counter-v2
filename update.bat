@echo off
setlocal
echo ======================================================
echo   TikTok Live Tap Dashboard - 最新版への更新
echo ======================================================
echo.
echo ツールを最新の状態にアップデートします...
echo.
pause

echo.
echo [1/2] 最新のプログラムを取得しています...
call git pull

echo.
echo [2/2] 必要な構成を更新しています...
call npm install

echo.
echo アップデートがすべて完了しました！
echo.
pause
