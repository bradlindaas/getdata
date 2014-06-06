
######################################################################
## Week 3
######################################################################


set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X
X[,1]
X[(X$var1 <= 3 & X$var3 > 11),]
X[order(X$var1),]
library(plyr)
arrange(X,var1)

######## Summarizing Data
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
if(!file.exists("./data")){
  dir.create("./data")
}
if (!file.exists("./data/restaurants.csv")) {
  download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
}
restData <- read.csv("./data/restaurants.csv")

summary(restData)
str(restData)
quantile(restData$councilDistrict,na.rm=TRUE)
table(restData$zipCode,useNA="ifany")
colSums(is.na(restData))
restData[restData$zipCode %in% c("21212","21213"),]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~., data=DF)
xt

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")

######### Creating new variable
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
if(!file.exists("./data")){
  dir.create("./data")
}
if (!file.exists("./data/restaurants.csv")) {
  download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
}
restData <- read.csv("./data/restaurants.csv")

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

######### reshaping data

library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
dcast(carMelt, cyl ~ variable, mean)

################# merging data
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
if(!file.exists("./data")){
  dir.create("./data")
}
if (!file.exists("./data/reviews.csv")){
  download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
}
if (!file.exists("./data/solutions.csv")){
  download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
}
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
