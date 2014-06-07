fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

if (!file.exists("../data")) {
  dir.create("../data")
}

if (!file.exists("../data/quiz1question1.csv")) {
  download.file(fileURL, destfile = "../data/quiz1question1.csv", method="curl")
}

question1 <- read.table("../data/quiz1question1.csv", sep=",", header=TRUE)

nrow(subset(question1, VAL==24))