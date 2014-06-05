leekUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(leekUrl)
htmlCode <- readLines(con)
pairs <- data.frame(line=htmlCode, char=nchar(htmlCode))
pairs$char[c(10,20,30,100)]