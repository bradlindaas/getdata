
library(reshape2)
library(data.table)

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

# get the names from activity lablels to use as column names
column_labels <- as.character(read.table
      ("../largedata/UCI HAR Dataset/features.txt", header=F)$V2)
subject <- as.character(read.table
      ("../largedata/UCI HAR Dataset/test/subject_test.txt", header=F)$V1)
activity <- as.character(read.table
      ("../largedata/UCI HAR Dataset/test/y_test.txt", header=F)$V1)
activity_labels <- read.table("../largedata/UCI HAR Dataset/activity_labels.txt", header=F)
#activity_labels <- as.data.table(activity_labels)

#Clean column names by remove (),
column_labels <- gsub("\\(", "", column_labels)
column_labels <- gsub("\\)", "", column_labels)
column_labels <- gsub("\\,", "", column_labels)

# read the X_test file in
X_test <- read.table("../largedata/UCI HAR Dataset/test/X_test.txt")
X_test <- as.data.table(X_test)
#set the column names
names(X_test) <- column_labels
X_test <- cbind(activity, X_test)
X_test <- cbind(subject, X_test)
X_test$activity <- sapply(X_test$activity, function(x) activity_labels[x,2])
