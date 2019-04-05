# https://www.youtube.com/watch?v=9OSB9pmlJpI
# installing packages to connect R to SQL
# https://db.rstudio.com/getting-started/connect-to-database

install.packages("RMySQL")
library(DBI)
install.packages("odbc")

# this might help
# https://support.rstudio.com/hc/en-us/articles/115011264307-Troubleshooting-Connections

# to test if there is a local connection
con <- dbConnect(odbc(), "localhost")

con <- DBI::dbConnect (odbc::odbc(),
                  Driver = "SQL Server", 
                  dbname="kirillclassSQL",
                  Server="localhost\\IE10WIN7",
                  #port=1433,
                  Trusted_Connection="True"
                  #user="IEUser",
                  #password=""
                  )

con <- DBI::dbConnect(odbc::odbc(),
                      driver = "SQL Server",
                      database = "IE10WIN7",
                      --UID    = rstudioapi::askForPassword("Database user"),
                      --PWD    = rstudioapi::askForPassword("Database password"),
                      host = "localhost",
                      port = 1433
                      )