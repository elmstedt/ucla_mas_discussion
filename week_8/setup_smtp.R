# from terminal
# docker run -p 25:25 --name smtp namshi/smtp
# Alternate 1 (From R):
#   system("docker pull namshi/smtp")
#   system("docker run -p 25:25 namshi/smtp", wait = FALSE)
# Alternate 1 (From R Studio):
#   tid <- rstudioapi::terminalExecute("docker pull namshi/smtp")
#   tid <- rstudioapi::terminalExecute("docker run -p 25:25 namshi/smtp")

# helper function
start_mail_server <- function() {
  tryCatch({
    message("Pulling latest image.")
    result <- system("docker pull namshi/smtp", intern = TRUE)
    message(paste(result, collapse = "\n"))
    tid <- rstudioapi::terminalExecute("docker run -p 25:25 --name smtp namshi/smtp",
                                       show = FALSE)
    message("Mail Server Starting")

    while(!any(grepl("listening for SMTP", rstudioapi::terminalBuffer(tid)))) {
      if (!is.null(rstudioapi::terminalExitCode(tid))) {
        stop(paste(rstudioapi::terminalBuffer(tid), collapse = "\n"))
      }
      Sys.sleep(0.1)
    }
    message("Mail server started")
    tid
  }, error = function(e) {
    stop(e)
  })
}

stop_mail_server <- function(tid) {
  tryCatch({
    message("Stoping mail server.")
    stopping <- system("docker stop smtp", intern = TRUE)

    message("Removing mail server.")
    removing <- system("docker rm smtp", intern = TRUE)
    message("Mail server stopped")
    rstudioapi::terminalKill(tid)
  }, error = function(e) {
    stop(e)
  })
}

tid <- start_mail_server()
stop_mail_server(tid)
