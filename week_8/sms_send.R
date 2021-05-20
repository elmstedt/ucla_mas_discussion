install.packages("emayili")
library(emayili)

# send email to phone
# Google Fi
#   sms & mms: 0000000000@msg.fi.google.com
# Verizon
#   sms:       0000000000@vtext.com
#   mms:       0000000000@vzwpix.com
# AT&T
#   sms:       0000000000@txt.att.net
#   mms:       0000000000@mms.att.net
# Tmobile
#   sms & mms: 0000000000@tmomail.net

email <- envelope(to      = c("jake.elmstedt@gmail.com",
                              "3235324466@msg.fi.google.com"),
                  from    = "mas405@localhost",
                  reply   = "jake.elmstedt@gmail.com",
                  subject = "Testing SMS",
                  text    = "Text me back!")
email
smtp_host <- Sys.getenv("smtp_host")
smtp_port <- Sys.getenv("smtp_port")

send <- server(host = smtp_host,
               port = smtp_port)

send
send(email)
