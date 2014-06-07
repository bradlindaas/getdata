library(sqldf)
 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists("./data/quiz2question2.csv")) {
  download.file(fileURL, destfile = "./data/quiz2question2.csv", method="curl")
}

acs <- read.table("./data/quiz2question2.csv", sep=",", header=TRUE)
results <- sqldf("select pwgtp1 from acs where AGEP < 50")

unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

