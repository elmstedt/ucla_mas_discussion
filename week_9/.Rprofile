# set prompt to time:
invisible(addTaskCallback(function(...) {
  options(prompt = format(Sys.time(), "%H:%M:%S> "))
  # options(prompt = paste(basename(getwd()), ">"))

  invisible(TRUE)
}, name = "time"))
if (interactive()) options(prompt = format(Sys.time(), "%H:%M:%S> "))

# set options
options(showWarnCalls = TRUE,
        showErrorCalls = TRUE,
        useFancyQuotes = FALSE)

# save multiple results
options(max_last_n = 10L,
        max_last_size = 100L)
attach(new.env(), name = ".Last.values")
assign(".init_last_values",
       function() {
         assign(".Last.values",
                list2DF(list(time  = character(),
                             call  = character(),
                             value = list())),
                envir = as.environment(".Last.values"))
         invisible(NULL)
       },
       envir = as.environment(".Last.values"))
assign(".save_value",
       function(...) {
         if (exists(".Last.values")) {
           n <- getOption("max_last_n", 10)
           call  <- paste(format(..1), collapse = "\n")
           if (length(call) && call != ".Last.values" && !is.null(..2)) {
             .Last.values <- rbind(list2DF(list(time  = Sys.time(),
                                                call  = call,
                                                value = list(..2))),
                                   .Last.values)
             assign(".Last.values",
                    .Last.values[seq_len(pmin(nrow(.Last.values), n)), ],
                    envir = as.environment(".Last.values"))
           }
         } else {
           if (!any(search() == ".Last.values")) {
             removeTaskCallback("lastcall")
           } else {
             .init_last_values()
             Recall(...)
           }
         }
         invisible(TRUE)
       },
       envir = as.environment(".Last.values"))
invisible(addTaskCallback(.save_value, name = "lastcall"))



# Run at the start
.First <- function() {
  if (file.exists(".Last.values.RData")) {
    load(file = ".Last.values.RData", envir = as.environment(".Last.values"))
  }
  print(utils::sessionInfo())
  if (interactive())
    print(fortunes::fortune())
}

# Say goodbye
.Last <- function() {
  save(.Last.values, file = ".Last.values.RData")
  cat("\n   Goodbye!\n")
}

