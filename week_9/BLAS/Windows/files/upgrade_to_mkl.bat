@ECHO OFF
ECHO Upgrading to MKL
@setlocal enableextensions
@cd /d "%~dp0"
for /f "delims=" %%i in ('R RHOME') do set rhome=%%i
set blaspath=%rhome%^\bin^\x64
ECHO Upgrading R BLAS to MKL
copy /Y %blaspath%^\mkl_rt.dll %blaspath%^\Rblas.dll
ECHO Upgrading R LAPACK to MKL
copy /Y %blaspath%^\mkl_rt.dll %blaspath%^\Rlapack.dll
::exit
