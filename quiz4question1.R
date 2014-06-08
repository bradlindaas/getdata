fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/quiz4question1.csv")) {
  download.file(fileURL, destfile = "./data/quiz4question1.csv", method="curl")
}
q4q1<-read.csv("./data/quiz4question1.csv")

splitNames = strsplit(names(q4q1),"wgtp")
splitNames[[123]]

