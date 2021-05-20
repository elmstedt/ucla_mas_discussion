# Run local mail relay:
# from cli
#     docker pull namshi/smtp
#     docker run -p 25:25 --name smtp namshi/smtp

# R package for simple smtp
install.packages("emayili")
library(emayili)

# alternate:
#     blastula for html email


email <- envelope(to      = "jake.elmstedt@gmail.com",
                  from    = "mailbot@mas405",
                  subject = "This is a Test",
                  text    = "This is a test.")
str(email)
email$header$Date <- "Mon, 17 May 2021 00:26:49 GMT"
email
smtp_host <- Sys.getenv("smtp_host")
smtp_port <- Sys.getenv("smtp_port")
send <- server(host = "127.0.0.1",
               port = "25")
send
send(email, verbose = TRUE)
