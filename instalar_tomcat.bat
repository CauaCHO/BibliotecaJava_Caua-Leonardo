@echo off
title Setup BibliotecaJava

set TOMCAT_VERSION=10.0.27
set TOMCAT_DIR=C:\Tomcat\apache-tomcat-%TOMCAT_VERSION%
set TOMCAT_ZIP=%USERPROFILE%\Downloads\tomcat-%TOMCAT_VERSION%.zip
set TOMCAT_URL=https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27-windows-x64.zip

set WAR_NAME=BibliotecaJava_Caua-Leonardo.war
set APP_URL=http://localhost:8080/BibliotecaJava_Caua-Leonardo/livros

echo ===============================
echo 1. Verificando Java
echo ===============================
java -version
if errorlevel 1 (
    echo ERRO: Java nao encontrado. Instale o Java 17 antes.
    pause
    exit /b
)

echo ===============================
echo 2. Verificando Maven
echo ===============================
mvn -version
if errorlevel 1 (
    echo ERRO: Maven nao encontrado. Instale o Maven antes.
    pause
    exit /b
)

echo ===============================
echo 3. Baixando Tomcat 10.0.27
echo ===============================

if not exist "C:\Tomcat" mkdir C:\Tomcat

if not exist "%TOMCAT_DIR%" (
    powershell -Command "Invoke-WebRequest -Uri '%TOMCAT_URL%' -OutFile '%TOMCAT_ZIP%'"
    powershell -Command "Expand-Archive -Path '%TOMCAT_ZIP%' -DestinationPath 'C:\Tomcat' -Force"
) else (
    echo Tomcat ja existe.
)

echo ===============================
echo 4. Configurando usuario Tomcat
echo ===============================

(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<tomcat-users xmlns="http://tomcat.apache.org/xml"
echo               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
echo               xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
echo               version="1.0"^>
echo     ^<role rolename="manager-gui"/^>
echo     ^<role rolename="manager-script"/^>
echo     ^<role rolename="admin-gui"/^>
echo     ^<user username="admin" password="admin" roles="manager-gui,manager-script,admin-gui"/^>
echo ^</tomcat-users^>
) > "%TOMCAT_DIR%\conf\tomcat-users.xml"

echo ===============================
echo 5. Gerando WAR
echo ===============================

call mvn clean package

if not exist "target\%WAR_NAME%" (
    echo ERRO: WAR nao encontrado.
    pause
    exit /b
)

echo ===============================
echo 6. Parando Tomcat antigo
echo ===============================

call "%TOMCAT_DIR%\bin\shutdown.bat"

timeout /t 3

echo ===============================
echo 7. Fazendo deploy
echo ===============================

del /Q "%TOMCAT_DIR%\webapps\%WAR_NAME%" 2>nul
rmdir /S /Q "%TOMCAT_DIR%\webapps\BibliotecaJava_Caua-Leonardo" 2>nul

copy /Y "target\%WAR_NAME%" "%TOMCAT_DIR%\webapps\%WAR_NAME%"

echo ===============================
echo 8. Iniciando Tomcat
echo ===============================

call "%TOMCAT_DIR%\bin\startup.bat"

echo Aguardando iniciar...
timeout /t 8

echo ===============================
echo 9. Abrindo sistema
echo ===============================

start %APP_URL%

echo.
echo Sistema iniciado em:
echo %APP_URL%
echo.
pause