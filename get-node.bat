@echo off
chcp 65001 > nul
setlocal

echo ======================================================
echo   Node.js 自動ダウンロードツール
echo ======================================================
echo.
echo インストール不要の Node.js をダウンロードしています...
echo (インターネットの速度により数十秒〜数分かかります)
echo.

set "NODE_URL=https://nodejs.org/dist/v20.11.1/node-v20.11.1-win-x64.zip"
set "ZIP_FILE=node_tmp.zip"
set "EXTRACT_DIR=node_tmp_dir"
set "FINAL_DIR=node-bin"

:: 1. ダウンロード (PowerShellを使用)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%NODE_URL%' -OutFile '%ZIP_FILE%'"

if not exist "%ZIP_FILE%" (
    echo [!] ダウンロードに失敗しました。インターネット接続を確認してください。
    pause
    exit /b 1
)

echo.
echo [✓] ダウンロード完了。展開（解凍）しています...

:: 2. 展開 (PowerShellを使用)
if exist "%EXTRACT_DIR%" rd /s /q "%EXTRACT_DIR%"
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%'"

:: 3. フォルダ整理
echo.
echo [✓] フォルダを整理しています...
if exist "%FINAL_DIR%" rd /s /q "%FINAL_DIR%"
for /d %%i in ("%EXTRACT_DIR%\node-*") do move "%%i" "%FINAL_DIR%"

:: 4. 後片付け
del "%ZIP_FILE%"
rd /s /q "%EXTRACT_DIR%"

echo.
echo ======================================================
echo   完了しました！
echo   これで「インストールなし」でツールが動かせます。
echo ======================================================
echo.
timeout /t 5
exit /b 0
