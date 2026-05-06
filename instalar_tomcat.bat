@echo off
title Instalador Apache Tomcat 10

echo ===============================
echo BAIXANDO APACHE TOMCAT 10
echo ===============================

cd %USERPROFILE%\Downloads

powershell -Command "Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27-windows-x64.zip -OutFile tomcat.zip"

echo.
echo ===============================
echo EXTRAINDO ARQUIVOS
echo ===============================

powershell -Command "Expand-Archive -Path tomcat.zip -DestinationPath C:\Tomcat"

echo.
echo ===============================
echo TOMCAT INSTALADO
echo ===============================

echo Caminho:
echo C:\Tomcat\apache-tomcat-10.0.27

pause