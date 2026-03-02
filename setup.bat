@echo off
setlocal
echo ======================================================
echo   TikTok Live Tap Dashboard - 初回セットアップ
echo ======================================================
echo.
echo このツールを動かすために必要な準備（プログラムの導入）を行います。
echo まだ Node.js をインストールしていない場合は、先にインストールを済ませてください。
echo.
pause

echo.
echo [1/2] 必要なパッケージをインストールしています...
call npm install

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ------------------------------------------------------
    echo エラーが発生しました。Node.js が正しくインストールされているか確認してください。
    echo ------------------------------------------------------
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [2/2] 完了しました！
echo 今後は start.bat をダブルクリックするだけでツールを起動できます。
echo.
pause
