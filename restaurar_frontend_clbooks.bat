@echo off
chcp 65001 >nul
setlocal

echo ==================================================
echo  RESTAURAR FRONTEND PREMIUM CL BOOK'S
echo ==================================================

set ZIP_NAME=CL Book's.zip
set TEMP_DIR=.tmp_clbooks_frontend
set DEST_DIR=frontend\cl-books\apps\web

if not exist "%ZIP_NAME%" (
    echo.
    echo ERRO: coloque o arquivo "%ZIP_NAME%" na raiz deste projeto.
    echo Exemplo:
    echo %cd%\%ZIP_NAME%
    echo.
    pause
    exit /b 1
)

if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

echo Extraindo ZIP...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%ZIP_NAME%' -DestinationPath '%TEMP_DIR%' -Force"

if not exist "%TEMP_DIR%\CL Book's\apps\web" (
    echo.
    echo ERRO: estrutura esperada nao encontrada dentro do ZIP.
    echo Esperado: CL Book's\apps\web
    echo.
    pause
    exit /b 1
)

echo Removendo frontend antigo...
if exist "%DEST_DIR%" rmdir /s /q "%DEST_DIR%"
mkdir "frontend\cl-books\apps"

echo Copiando frontend real do ZIP...
xcopy "%TEMP_DIR%\CL Book's\apps\web" "%DEST_DIR%" /E /I /Y >nul

echo Limpando temporarios...
rmdir /s /q "%TEMP_DIR%"

echo.
echo ==================================================
echo  FRONTEND PREMIUM RESTAURADO COM SUCESSO
echo ==================================================
echo.
echo Agora execute:
echo cd frontend\cl-books\apps\web
echo npm install
echo npm run dev
echo.
echo Depois rode o backend Java no Tomcat para consumir as APIs reais.
echo.
pause
