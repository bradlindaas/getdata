fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists("../data")) {
  dir.create("../data")
}
if (!file.exists("../data/quiz3question1.csv")) {
  download.file(fileURL, destfile = "../data/quiz3question1.csv", method="curl")
}
q1 <- read.table("../data/quiz3question1.csv", sep=",", header=TRUE)

#Create a logical vector that identifies the households on greater than 
#10 acres who sold more than $10,000 worth of agriculture products. 

# i had to get rid of NA values with the extra step
# this vector has 77 TRUE values
lv <- q1$AGS == 6 & q1$ACR == 3
lv[is.na(lv)]<-FALSE

# double check subsetting by comparing using the subset() function 
identical(sum(lv), nrow(subset(q1, AGS == 6 & ACR == 3)))

#Assign that logical vector to the variable agricultureLogical. 
agricultureLogical <- lv

#Apply the which() function like this to identify the rows of the data frame 
#where the logical vector is TRUE. which(agricultureLogical) 
#What are the first 3 values that result?
head(which(agricultureLogical),3)