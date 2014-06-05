library(jsonlite)

leekUrl <- "https://api.github.com/users/jtleek/repos"
jsonData <- fromJSON(leekUrl)

pairs <- data.frame(name=jsonData$name, date=jsonData$created_at)
pairs[pairs$name=="datasharing",]