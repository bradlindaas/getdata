fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("../largedata")) {
  dir.create("../largedata")
}
if (!file.exists("../largedata/project.zip")) {
  download.file(fileURL, destfile = "../largedata/project.zip", method="curl")
}
if (!file.exists("../largedata/UCI HAR Dataset/")) {
  unzip("../largedata/project.zip", exdir="../largedata")
}