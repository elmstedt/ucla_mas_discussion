blas_path <- file.path(R.home(), "bin", "x64")
mkl_path <- file.path(blas_path, "mkl_rt.dll")
base_blas_path <- file.path(blas_path, "Rblas.dll.base")
base_lapack_path <- file.path(blas_path, "Rlapack.dll.base")
R_blas_path <- file.path(blas_path, "Rblas.dll")
R_lapack_path <- file.path(blas_path, "Rlapack.dll")

# backup base
backup_base <- function() {
  if (!file.exists(base_blas_path)) {
    file.copy(R_blas_path, base_blas_path, overwrite = TRUE)
  }
  if (!file.exists(base_lapack_path)) {
    file.copy(R_lapack_path, base_lapack_path, overwrite = TRUE)
  }
}

restore_base <- function() {
  file.copy(base_blas_path, R_blas_path, overwrite = TRUE)
  file.copy(base_lapack_path, R_lapack_path, overwrite = TRUE)
}

restore_mkl <- function() {
  file.copy(mkl_path, R_blas_path, overwrite = TRUE)
  file.copy(mkl_path, R_lapack_path, overwrite = TRUE)
}

restore_base()
system2("copy", c("/Y", base_blas_path, "test.dll"))
