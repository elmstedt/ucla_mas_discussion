echo off
@setlocal enableextensions
@cd /d "%~dp0"
for /f "delims=" %%i in ('R RHOME') do set rhome=%%i
set blaspath=%rhome%^\bin^\x64
ECHO Copying MKL files to %blaspath%
xcopy /y /e /s /q mkl %blaspath%
