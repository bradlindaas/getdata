setwd("~/getdata/project")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/project.zip")) {
  download.file(fileURL, destfile = "./data/project.zip", method="curl")
}
if (!file.exists("./data/UCI HAR Dataset/")) {
  unzip("./data/project.zip", exdir="./data")
}