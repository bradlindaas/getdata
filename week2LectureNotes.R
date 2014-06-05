
######################################################################
## Week 2
######################################################################

library(RMySQL)

ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu", db="hg19")
allTables <- dbListTables(hg19)
length(allTables)
fieldList <- dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "SELECT count(*) from affyU133Plus2")
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMisSmall <- fetch(query, n=10); dbClearResult(query); 
dim(affyMisSmall)

library(httr)
leekUrl <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- GET(leekUrl)
content <- content(html, as="text")
parsedHtml <- htmlParse(content, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)