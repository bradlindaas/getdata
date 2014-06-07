library(XML)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists("./data/quiz1question4.xml")) {
  download.file(fileURL, destfile = "./data/quiz1question4.xml", method="curl")
}

doc <- xmlParse("./data/quiz1question4.xml", useInternal=TRUE)
rootNode = xmlRoot(doc)

# Make sure to doublecheck the ZIPCODE value
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)