bm_mkl <- benchmarkme::benchmark_std(10)
saveRDS(bm_mkl, "bm_base.RData")

setdiff(dir(recursive = TRUE, include.dirs = TRUE),
        dir(recursive = TRUE, include.dirs = FALSE))

unlink(my_path, recursive = TRUE)
my_path <- "~/this_dir/sub_dir"
if (!dir.exists(my_path)) {
  message("Creating directory...")
  dir.create(my_path, recursive = TRUE)
}
dir.exists(my_path)

base <- readRDS("bm_base.RData")
mkl <- readRDS("bm_mkl.RData")

