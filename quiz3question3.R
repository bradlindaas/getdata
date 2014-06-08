library(plyr)
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/quiz3question3-1.csv")) {
  download.file(fileURL1, destfile = "./data/quiz3question3-1.csv", method="curl")
}
if (!file.exists("./data/quiz3question3-2.csv")) {
  download.file(fileURL2, destfile = "./data/quiz3question3-2.csv", method="curl")
}

##### Clean up GDP data
gdpraw <- read.csv("./data/quiz3question3-1.csv", stringsAsFactors=FALSE, header=FALSE)
gdpdata <- gdpraw[6:195,]
gdpdata[,5]<-as.numeric(gsub(",","", gdpdata[,5]))
names(gdpdata)<-c("CountryCode", "rank", "C", "Long Name", "gdp", 
                  "F", "G", "H", "I", "J")
gdpdata$rank <- as.numeric(gdpdata$rank)

##### load Ed data
eddata <- read.csv("./data/quiz3question3-2.csv", stringsAsFactors=FALSE, header=TRUE)

# I fixed this to merge better
mergedData<-merge(eddata, gdpdata, by.x="CountryCode", by.y="CountryCode")

# Question 3 -- I got this wrong but I fixed it up
results <- arrange(mergedData, gdp)
c(nrow(mergedData), results[13,2])

# Question 4
split <- split(mergedData$rank, mergedData$Income.Group)
sapply(split, mean, na.rm=T)

#Question 5
library(Hmisc)
mergedData$ranGroups = cut2(mergedData$rank,g=5)
table(mergedData$ranGroups, mergedData$Income.Group)