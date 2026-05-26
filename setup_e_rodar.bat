@echo off
title Setup e Execucao - Biblioteca Java

set TOMCAT_VERSION=9.0.102
set TOMCAT_DIR=C:\apache-tomcat-%TOMCAT_VERSION%
set TOMCAT_ZIP=%USERPROFILE%\Downloads\apache-tomcat-%TOMCAT_VERSION%-windows-x64.zip
set TOMCAT_URL=https://archive.apache.org/dist/tomcat/tomcat-9/v%TOMCAT_VERSION%/bin/apache-tomcat-%TOMCAT_VERSION%-windows-x64.zip
set WAR_NAME=BibliotecaJava_Caua-Leonardo.war
set APP_NAME=BibliotecaJava_Caua-Leonardo
set APP_URL=http://localhost:8080/%APP_NAME%/livros

echo ==================================================
echo  BIBLIOTECA JAVA - SETUP PADRAO DAS AULAS
echo  Java 17 + Maven + PostgreSQL + Tomcat 9.0.102
echo ==================================================
echo.

echo [1/8] Verificando Java...
java -version
if errorlevel 1 (
    echo.
    echo ERRO: Java nao encontrado.
    echo Instale o Java JDK 17 conforme o material da aula.
    pause
    exit /b 1
)

echo.
echo [2/8] Verificando Maven...
mvn -version
if errorlevel 1 (
    echo.
    echo ERRO: Maven nao encontrado no PATH.
    echo O NetBeans possui Maven integrado, mas este .bat precisa do comando mvn.
    pause
    exit /b 1
)

echo.
echo [3/8] Preparando Apache Tomcat %TOMCAT_VERSION%...
if not exist "%TOMCAT_DIR%" (
    echo Tomcat nao encontrado em %TOMCAT_DIR%.
    echo Baixando Tomcat %TOMCAT_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri '%TOMCAT_URL%' -OutFile '%TOMCAT_ZIP%'"

    if errorlevel 1 (
        echo ERRO ao baixar o Tomcat.
        pause
        exit /b 1
    )

    echo Extraindo em C:\ ...
    powershell -Command "Expand-Archive -Path '%TOMCAT_ZIP%' -DestinationPath 'C:\' -Force"
) else (
    echo Tomcat ja encontrado em %TOMCAT_DIR%.
)

echo.
echo [4/8] Configurando usuario admin/admin do Tomcat...
(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<tomcat-users xmlns="http://tomcat.apache.org/xml"
echo               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
echo               xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
echo               version="1.0"^>
echo     ^<role rolename="manager-gui"/^>
echo     ^<role rolename="manager-script"/^>
echo     ^<role rolename="manager-jmx"/^>
echo     ^<role rolename="manager-status"/^>
echo     ^<user username="admin" password="admin" roles="manager-gui,manager-script,manager-jmx,manager-status"/^>
echo ^</tomcat-users^>
) > "%TOMCAT_DIR%\conf\tomcat-users.xml"

echo.
echo [5/8] Gerando WAR com Maven...
call mvn clean package
if errorlevel 1 (
    echo.
    echo ERRO: falha ao gerar o WAR.
    pause
    exit /b 1
)

if not exist "target\%WAR_NAME%" (
    echo.
    echo ERRO: arquivo target\%WAR_NAME% nao encontrado.
    pause
    exit /b 1
)

echo.
echo [6/8] Parando Tomcat antigo, se estiver rodando...
call "%TOMCAT_DIR%\bin\shutdown.bat"
timeout /t 3 >nul

echo.
echo [7/8] Fazendo deploy do projeto...
del /Q "%TOMCAT_DIR%\webapps\%WAR_NAME%" 2>nul
rmdir /S /Q "%TOMCAT_DIR%\webapps\%APP_NAME%" 2>nul
copy /Y "target\%WAR_NAME%" "%TOMCAT_DIR%\webapps\%WAR_NAME%"

echo.
echo [8/8] Iniciando Tomcat %TOMCAT_VERSION%...
call "%TOMCAT_DIR%\bin\startup.bat"

echo.
echo Aguardando o servidor iniciar...
timeout /t 8 >nul

echo Abrindo sistema...
start %APP_URL%

echo.
echo ==================================================
echo  Sistema iniciado em:
echo  %APP_URL%
echo.
echo  Tomcat usado:
echo  %TOMCAT_DIR%
echo.
echo  Login Manager Tomcat: admin
echo  Senha Manager Tomcat: admin
echo ==================================================
echo.
pause
