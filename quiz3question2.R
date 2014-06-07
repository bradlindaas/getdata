fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if (!file.exists("../data")) {
  dir.create("../data")
}
if (!file.exists("../data/quiz3question2.jpg")) {
  download.file(fileURL, destfile = "../data/quiz3question2.jpg", method="curl")
}
library(jpeg)
result <- readJPEG("../data/quiz3question2.jpg", native=TRUE)
quantile(result, c(.3,.8))