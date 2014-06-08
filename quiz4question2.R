fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/quiz4question2.csv")) {
  download.file(fileURL, destfile = "./data/quiz4question2.csv", method="curl")
}
q4q2<-read.csv("./data/quiz4question2.csv")
q4q2 <- q4q2[5:194,]

q4q2$X.3<-gsub(",", "", q4q2$X.3,)

mean(as.numeric(q4q2$X.3))

# Question 3
grep("^United",q4q2$X.2)