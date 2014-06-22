## Analysis Script
## by Brad Lindaas
## for Getting and Cleaning Data (getdata-004): Class Project

library(reshape2)
library(data.table)

## The assignment required the data to be located in the 'working directory'
## Simply change the dataDir variable to wherever your data is located and this script will process fine
## note: these path notations assume you run R in a UNIX environment. Adjust as needed
## dataDir <- "./"
dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(paste(dataDir, "UCI HAR Dataset/", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "project.zip", sep=""), method="curl")
    unzip(paste(dataDir, "project.zip", sep=""), exdir=dataDir)
}

getFeatureLabels <- function () {
    ## getFeatureLabels() has no arguments, as there is only one features.txt file
    ## the function extracts the feature labels from the "features.txt" file
    ## these values will makeup the column names of the dataset
    ## the function edits the labels to be more descriptive according to Part 4 
    ## The function returns a character vector
    feature_labels <- as.character(read.table(paste(dataDir, "UCI HAR Dataset/", "features.txt", sep=""), header=F)$V2)
    feature_labels <- gsub("\\(", "", feature_labels)
    feature_labels <- gsub("\\)", "", feature_labels)
    feature_labels <- gsub("\\,", "", feature_labels)
    feature_labels <- gsub("-", "", feature_labels)
    return (feature_labels)
}

getActivityData <- function (dir) {
    ## getActivityData() takes one argument (dir) that specifies either "train" or "test" 
    ## the function reads the specific Activty file to grab the specified actvity code
    ## the function translates the code to the friendly name found in activity_labels.txt
    ## as specified in Part 3, these values will makeup the column 'activity' of the dataset
    ## The function returns a factor
    activity <- as.factor(read.table(paste(dataDir, "UCI HAR Dataset/", dir, "/y_", dir, ".txt", sep=""), header=F)$V1)
    activity_labels <- read.table(paste(dataDir, "UCI HAR Dataset/activity_labels.txt", sep=""), header=F)
    activity <- sapply(activity, function(y) activity_labels[y,2])
    return (activity)
}

getSubjectData <- function(dir) {
    ## getSubjectData() takes one argument (dir) that specifies either "train" or "test" 
    ## the function reads the specific Subject file to grab the specific subject of the observation
    ## The function returns a numeric vector
    subjects <- as.character(read.table(paste(dataDir, "UCI HAR Dataset/", dir, "/subject_", dir,".txt", sep=""), header=F)$V1)
    return(as.numeric(subjects))
}

readDataFile <- function(dir) {
    ## readDataFile() takes one argument (dir) that specifies either "train" or "test" 
    ## the function reads the specific file into a data.frame
    ## This function was created to separate reading the files from constructing the data.frame
    ## in the possiblity that I need to adjust the parameters of the read
    ## The function returns a data frame
    dataFile <- read.table(paste(dataDir, "UCI HAR Dataset/", dir, "/X_", dir,".txt", sep=""), header=F, colClasses="numeric")
    return(dataFile)
}    

getXData <- function(dir) {
    ## getXData() takes one argument (dir) that specifies either "train" or "test" 
    ## This function utilizes all the helper functions to construct the data frame
    ## it calls the readDataFile helper function to grab the core data
    ## then it cbinds the subject and activity columns using those helper functions
    ## finally it sets the column names to the descriptive names using the helper functions
    ## The function returns a data frame
    XData <- readDataFile(dir)
    XData <- cbind(getSubjectData(dir), getActivityData(dir),XData)
    return(setnames(XData, c("subject", "activity", getFeatureLabels())))
}

## Part 1, Merge the train and the test sets to create one data set.
mergedData <- rbind(getXData("test"), getXData("train"))

## Part 2, Extract only the measurements on the mean and standard deviation for each measurement.
## Part 3, Use descriptive activity names to name the activities in the data set
## part 4, Appropriately label the data set with descriptive variable names. 
tidyData <- mergedData[,grepl("subject|activity|mean|std", names(mergedData))]

## Part 5, Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyMelt <- melt(tidyData, id=c(1:2), measure.vars=c(3:81))
averageTidyData<-dcast(tidyMelt, subject + activity ~ variable, mean)

## Export the final tidy data file to CSV to upload with submission
write.csv(averageTidyData, "tidy-mean.txt", row.names=F)
