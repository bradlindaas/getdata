library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

part1 <- sum(year(sampleTimes) == 2012)
part2 <- sum((wday(sampleTimes, label=T))=="Mon" & year(sampleTimes) == 2012)

c(part1,part2)