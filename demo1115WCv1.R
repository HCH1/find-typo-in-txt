## http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know#reasons-you-should-use-word-clouds-to-present-your-text-data
# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes
# install.packages("hunspell")
# library("hunspell")
# library("tm")
# library("SnowballC")
# library("wordcloud")
# library("RColorBrewer")
inpath = "~/Documents/2016demo/demo1115WCbyR/drive-download-20161116T115340Z/22FDX_Rev1.0_0.0.txt"
text <- readLines(inpath)
text <- gsub("[[^A-Za-z0-9]]"," ", text)
text <- gsub("[[:punct:]]"," ", text)
docs <- Corpus(VectorSource(text))
# docs <- gsub("rx","rrxx",docs)
# toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
# docs <- tm_map(docs, toSpace, "\\(")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, stripWhitespace)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
write.table(x = d, file = "o11.csv", sep = ",", 
            col.names = NA, qmethod = "double")
head(d, 10)
set.seed(1234)
##
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
##
barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,
        col ="lightblue", main ="Freq words",
        ylab = "freq")
##
# words <- c("beer", "wiskey", "wine")
words <- readLines("o11.csv")
# hunspell_check(words)
bad_words <- hunspell(words)
head(bad_words, 10)
# write(bad_words, file = "o2.txt", sep = "\t")
lapply(bad_words, write, "o33.txt", append=TRUE, ncolumns=1000)
##
