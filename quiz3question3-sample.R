aoraw <- read.csv("./data/appleorange.csv", stringsAsFactors=FALSE, header=FALSE)
head(aoraw,10)
tail(aoraw,10)
aodata <- aoraw[3:700,]
names(aodata) <- c("country", "countrynumber", "products", 
                   "productnumber", "tonnes", "year")
aodata$countrynumber <- as.integer(aodata$countrynumber)
fslines <- which(aodata$country == "Food supply quantity (tonnes) (tonnes)")
aodata <- aodata[(-1 * fslines),]
aodata$tonnes <- gsub("\xca", "", aodata$tonnes)
aodata$tonnes <- gsub(", tonnes \\(\\)", "", aodata$tonnes)
aodata$tonnes <- as.numeric(aodata$tonnes)
aodata$year <- 2009