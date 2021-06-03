@ECHO OFF
@setlocal enableextensions
@cd /d "%~dp0"
for /f "delims=" %%i in ('R RHOME') do set rhome=%%i
set blaspath=%rhome%^\bin^\x64
set mkl=%blaspath%^\mkl_rt.dll
set rblas=%blaspath%^\Rblas.dll
set rlapack=%blaspath%^\Rlapack.dll
FOR /F "usebackq" %%A IN ('%mkl%') DO set mkl_size=%%~zA
FOR /F "usebackq" %%A IN ('%rblas%') DO set blas_size=%%~zA
FOR /F "usebackq" %%A IN ('%rlapack%') DO set lapack_size=%%~zA

if %mkl_size% == %blas_size% (
	ECHO Base R BLAS already backed up.
) else (
	ECHO Backing up Base R BLAS
	copy /Y %blaspath%^\Rblas.dll %blaspath%^\Rblas.dll.base
)
if %mkl_size% == %lapack_size% (
	ECHO Base R LAPACK already backed up.
) else (
	ECHO Backing up Base R LAPACK
	copy /Y %blaspath%^\Rlapack.dll %blaspath%^\Rlapack.dll.base
)
::exit