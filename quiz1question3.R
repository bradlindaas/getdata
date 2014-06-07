fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

if (!file.exists("../data")) {
  dir.create("../data")
}

if (!file.exists("../data/quiz1question3.xlsx")) {
  download.file(fileURL, destfile = "../data/quiz1question3.xlsx", method="curl")
}

# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
# dat 
# need to solve for...
# sum(dat$Zip*dat$Ext,na.rm=T)

# I didn't want to install all that Java stuff for the quiz, but here is how
# Post in how to install packages on Ubuntu for this course
# http://tuxette.nathalievilla.org/?p=1380&lang=en

Zip <- c(74136, 30329, 74136, 80203, 80120)
Ext <- c(0, NA, 0, 0, 456)
sum(Zip*Ext,na.rm=T)

