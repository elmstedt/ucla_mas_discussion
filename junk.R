format.object_size <- function (x, units = "b", standard = "auto", ...) {
  known_bases <- c(legacy = 1024, IEC = 1024, SI = 1000)
  known_units <- list(SI = c("B", "kB", "MB", "GB", "TB",
                             "PB", "EB", "ZB", "YB"),
                      IEC = c("B", "KiB", "MiB", "GiB", "TiB",
                              "PiB", "EiB", "ZiB", "YiB"),
                      legacy = c("b", "Kb", "Mb", "Gb", "Tb", "Pb"),
                      LEGACY = c("B", "KB", "MB", "GB", "TB", "PB"))
  dots <- list(...)
  known_bases <- c(legacy = 1024, IEC = 1024, SI = 1000)
  known_units <- list(SI = c("B", "kB", "MB", "GB", "TB",
                             "PB", "EB", "ZB", "YB"), IEC = c("B", "KiB", "MiB",
                                                              "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"), legacy = c("b",
                                                                                                                    "Kb", "Mb", "Gb", "Tb", "Pb"), LEGACY = c("B", "KB",
                                                                                                                                                              "MB", "GB", "TB", "PB"))
  units <- match.arg(units, c("auto", unique(unlist(known_units),
                                             use.names = FALSE)))
  standard <- match.arg(standard, c("auto", names(known_bases)))
  if (standard == "auto") {
    standard <- "legacy"
    if (units != "auto") {
      if (endsWith(units, "iB"))
        standard <- "IEC"
      else if (endsWith(units, "b"))
        standard <- "legacy"
      else if (units == "kB")
        stop("For SI units, specify 'standard = \"SI\"'")
    }
  }
  base <- known_bases[[standard]]
  units_map <- known_units[[standard]]
  if (units == "auto") {
    power <- if (x <= 0)
      0L
    else min(as.integer(log(x, base = base)), length(units_map) -
               1L)
  } else {
    power <- match(toupper(units), toupper(units_map)) -
      1L
    if (is.na(power))
      stop(gettextf("Unit \"%s\" is not part of standard \"%s\"",
                    sQuote(units), sQuote(standard)), domain = NA)
  }
  unit <- units_map[power + 1L]
  if (power == 0 && standard == "legacy")
    unit <- "bytes"
  # paste(round(x/base^power, digits = digits), unit)
  if (is.null(dots[["digits"]]))
    dots[["digits"]] <- 1L

  value <- c(round(x/base^power, dots[["digits"]]))
  dots[["width"]] <- NULL
  dots[["digits"]] <- min(max(ceiling(log10(value)), 0) + dots[["digits"]], 22)
  # dots[["digits"]] <- max(ceiling(log10(value)), 0) + dots[["digits"]]
  dots[["x"]] <- value
  format(paste(do.call(format, dots), unit), ...)
}
dots <- list(digits = 17, scientific = FALSE)
x <- os
x <- sample(123)
w <- object.size(x)

os1
# interior format:
# digits,
rm(dots)
os1 <- structure(4e8, class = "object_size")
os2 <- structure(4e8 + 1, class = "object_size")
os3 <- structure(4e8 + 5, class = "object_size")
os4 <- structure(4e8 + 6, class = "object_size")
oss <- list(os1, os2, os3, os4)
os4 <- structure(round(runif(1) * 1e19), class = "object_size")
format(os4, units = "B", standard = "SI")
format(os4, units = "YiB")
format(os4, units = "B")

format(os4, units = "YB", standard = "SI", zero.print = "")

format(os4, units = "ZB", standard = "SI", digits = )
utils:::format.object_size(os4, units = "EB", standard = "SI")
w <- print(os4, units = "PB")

format(os3, units = "MB", standard = "LEGACY", scientific = FALSE) # why is this an error?? why not default to SI??
format(os3, units = "KiB") # why is this an error?? why not default to SI??
format(os3, units = "KiB") # why is this an error?? why not default to SI??
units <- "kB"
standard <- "SI"
digits <- 22
print(round(os3[[1]]/1024, digits = 22), digits = 22)
.Machine$double.digits
.Machine$double.base
cat(unlist(.Machine))
w <- c(2.220446e-16, 1.110223e-16, 2.225074e-308, 1.797693e+308, 2, 53, 5, 0, -52, -53, 11, -1022, 1024, 2147483647, 4, 8, 16, 8, 1.084202e-19, 5.421011e-20, 64, 5, 0, -63, -64, 15, -16382, 16384)
u <- c(2.220446e-16, 1.110223e-16, 2.225074e-308, 1.797693e+308, 2, 53, 5, 0, -52, -53, 11, -1022, 1024, 2147483647, 8, 8, 16, 8, 1.084202e-19, 5.421011e-20, 64, 5, 0, -63, -64, 15, -16382, 16384)
which(w != u)
set.seed(123)
x <- runif(1)
noquote(unlist(format(.Machine)))
noquote(unlist(format(.Platform)))
env <- lapply(search(), as.environment)
res <- list()
for (i in seq_along(env)) {
  res[[i]] <- sapply(env[[i]], object.size)
}
x <- numeric(1e8)
rm(x)
format(structure(sum(unlist(res)), class = "object_size"), units = "Mb")
memory.size(TRUE)
memory.size(FALSE)
proc.time()
gc(TRUE, FALSE, TRUE)
f <- function(e) print("cleaning....")
g <- function(x){ e <- environment(); reg.finalizer(e, f) }
g()
invisible(gc()) # trigger cleanup
memory.profile()
gc.time(on = TRUE)
gcinfo(TRUE)
detach(".Last.values")
nchar(format(.3, digits = 22)) - 2
for (os in oss) {
  format.object_size(os, units, standard, digits = digits,
                     scientific = FALSE, big.mark = ".", decimal.mark = ",",
                     width = 40, justify = "right", nsmall = 3) |> print()
  format.object_size(os, units, standard, digits = digits, scientific = FALSE) |> print()
  format.object_size(os, units, standard, digits = digits, scientific = FALSE) |> print()
  format(os, units, standard, digits = digits) |> print()
  utils:::format.object_size(os, units, standard, digits = digits, scientific = FALSE) |> print()
  utils:::format.object_size(os, units, standard, digits = digits) |> print()
  cat("\n")
}

print.object_size <-  function (x, quote = FALSE, units = "b", standard = "auto",
                                digits = 1L, ...) {
  y <- format.object_size(x, units, standard, digits, ...)
  if (quote) print.default(y, ...) else cat(y, "\n", sep = "")
  invisible(x)
}
rm(print.object_size)
os <- structure(4e8, class = "object_size")
utils:::format.object_size(os, units, standard)
utils:::format.object_size(os, units, standard, scientific = FALSE)
format.object_size(os, units, standard, scientific = FALSE)
format.object_size(os, units, standard)
utils:::print.object_size()
rm(format.object_size)
x <- numeric(1e8)
format(object.size(x), units = "KiB", digits = -3)
format(object.size(x), units = "KiB", digits = -3)
utils:::format.object_size(object.size(x), units = "KiB", digits = -3)
format.object_size(object.size(x), units = "KiB", nsmall = 3, digits = -3, drop0trailing = TRUE)
print(object.size(x), units = "KB", scientific = TRUE)
utils:::print.object_size(os, units = "KB", standard = "SI", scientific = FALSE)
print(os, units = "KB", standard = "SI", scientific = FALSE)
utils:::format.object_size(os, units = "KB", standard = "SI")

options(scipen = 0)
x <- numeric(1e8)
utils:::format.object_size(object.size(x), units = "KB")

