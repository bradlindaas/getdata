library(reshape2)
library(data.table)

dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(dataDir)) {
  dir.create(dataDir)
}
if (!file.exists(paste(dataDir, "project.zip", sep=""))) {
  download.file(dataFileURL, destfile = paste(dataDir, "project.zip", sep=""), method="curl")
}
if (!file.exists(paste(dataDir, "UCI HAR Dataset/", sep=""))) {
  unzip(paste(dataDir, "project.zip", sep=""), exdir=dataDir)
}

getFeatureLabels <- function () {
    ## Part 4, Appropriately labels the data set with descriptive variable names.
    ## It is possible these are not descriptive?
    feature_labels <- as.character(read.table(paste(dataDir, "UCI HAR Dataset/features.txt", sep=""), header=F)$V2)
    feature_labels <- gsub("\\(", "", feature_labels)
    feature_labels <- gsub("\\)", "", feature_labels)
    feature_labels <- gsub("\\,", "", feature_labels)
    feature_labels <- gsub("-", "", feature_labels)
    return (feature_labels)
}

getActivityData <- function (x) {
    ## Part 3, Uses descriptive activity names to name the activities in the data set
    activity <- as.factor(read.table(paste(dataDir, "UCI HAR Dataset/", x, "/y_", x, ".txt", sep=""), header=F)$V1)
    activity_labels <- read.table(paste(dataDir, "UCI HAR Dataset/activity_labels.txt", sep=""), header=F)
    activity <- sapply(activity, function(y) activity_labels[y,2])
    return (activity)
}

getSubjectData <- function(x) {
    subjects <- as.character(read.table(paste(dataDir, "UCI HAR Dataset/", x, "/subject_", x,".txt", sep=""), header=F)$V1)
    return(as.numeric(subjects))
}

readDataFile <- function(x) {
    dataFile <- read.table(paste(dataDir, "UCI HAR Dataset/", x, "/X_", x,".txt", sep=""), header=F, colClasses="numeric")
    #dataFile <- as.data.table(dataFile)
    return(dataFile)
}    

getXData <- function(dir) {
    XData <- readDataFile(dir)
    XData <- cbind(getSubjectData(dir), getActivityData(dir),XData)
    ## Part 3, Uses descriptive activity names to name the activities in the data set
    setnames(XData, c("subject", "activity", getFeatureLabels()))
}

## Part 1, Merge the training and the test sets to create one data set.
mergedData <- rbind(getXData("test"), getXData("train"))

## Part 2, Extracts only the measurements on the mean and standard deviation for each measurement.
tidyData <- mergedData[,grepl("subject|activity|mean|std", names(mergedData))]

## Part 5, Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# these is where I use reshape2