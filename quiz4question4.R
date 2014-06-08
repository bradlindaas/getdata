fileURL1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/quiz4question4-gdp.csv")) {
  download.file(fileURL1, destfile = "./data/quiz4question4-gdp.csv", method="curl")
}
if (!file.exists("./data/quiz4question4-ed.csv")) {
  download.file(fileURL2, destfile = "./data/quiz4question4-ed.csv", method="curl")
}

gdp<-read.csv("./data/quiz4question4-gdp.csv")
ed<-read.csv("./data/quiz4question4-ed.csv")
ed<-ed[-228,]
gdp<-gdp[5:194,]
gdp$X.3<-gsub(",", "", gdp$X.3)

mergedData<- merge(gdp, ed, by.x="X", by.y="CountryCode")

length(grep("^Fiscal year end: June", mergedData$Special.Notes))
