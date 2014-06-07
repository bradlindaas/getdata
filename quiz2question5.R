fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

if (!file.exists("../data")) {
  dir.create("../data")
}

if (!file.exists("../data/quiz2question5.for")) {
  download.file(fileURL, destfile = "../data/quiz2question5.for", method="curl")
}

q5 <- read.fwf("../data/quiz2question5.for", skip=4, widths=c(13,6,7,6,7,6,7,6,7))

sum(q5[,4])