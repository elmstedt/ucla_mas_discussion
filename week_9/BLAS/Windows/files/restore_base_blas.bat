@echo off
@setlocal enableextensions
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

for /f "delims=" %%i in ('R RHOME') do set rhome=%%i
set blaspath=%rhome%^\bin^\x64
ECHO Restoring Base R BLAS
copy /Y %blaspath%^\Rblas.dll.base %blaspath%^\Rblas.dll
ECHO Restoring Base R LAPACK
copy /Y %blaspath%^\Rlapack.dll.base %blaspath%^\Rlapack.dll
pause
exit