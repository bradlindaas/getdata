library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists("./data/quiz1question5.csv")) {
  download.file(fileURL, destfile = "./data/quiz1question5.csv", method="curl")
}

DT <- fread("./data/quiz1question5.csv")

resultA <- system.time(A<-tapply(DT$pwgtp15,DT$SEX,mean))
resultB <- system.time(B<-sapply(split(DT$pwgtp15,DT$SEX),mean))
# this fails resultC <- system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
resultD <- system.time(D<-DT[,mean(pwgtp15),by=SEX])
resultE <- system.time({E<-mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
resultF <- system.time(F<-mean(DT$pwgtp15,by=DT$SEX))

A # correct results
B # correct results
# C didn't even process
D # correct results
E # didn't return the results split by sex
F # didn't return the results split by sex

results <- rbind(resultA, resultB, resultD)

results

