#########################################################################
## Week 1
#########################################################################

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/acs.csv", method="curl")
list.files("./data")
dateDownloaded <- date()
cameraData <- read.table("./data/camera.csv", sep=",", header=TRUE)

xmlUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(xmlUrl, useInternal=TRUE)
xmlInternalTreeParse(xmlUrl)
rootNode = xmlRoot(doc)
xmlName(rootNode)
