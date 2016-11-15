## http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know#reasons-you-should-use-word-clouds-to-present-your-text-data
# Install
# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes
# Load
# library("tm")
# library("SnowballC")
# library("wordcloud")
# library("RColorBrewer")
# Read the text file
text <- readLines("/Users/HCHung/Documents/2016demo/demo1115WCbyR/28LPSErulesALL_orig.txt")
# Load the data as a corpus
docs <- Corpus(VectorSource(text))
# inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "\\(")
docs <- tm_map(docs, toSpace, "\\)")
docs <- tm_map(docs, toSpace, "\\[")
docs <- tm_map(docs, toSpace, "\\]")
docs <- tm_map(docs, toSpace, "\\{")
docs <- tm_map(docs, toSpace, "\\}")
# docs <- tm_map(docs, toSpace, "\\.")
docs <- tm_map(docs, toSpace, "\\,")
# docs <- tm_map(docs, toSpace, "/")
# docs <- tm_map(docs, toSpace, "@")
# docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
# docs <- tm_map(docs, removeNumbers)
# Remove punctuations
# docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
write.table(x = d, file = "o1.csv", sep = ",", 
            col.names = NA, qmethod = "double")
head(d, 10)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
##
barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,
        col ="lightblue", main ="Freq words",
        ylab = "freq")
##
library(hunspell)
# words <- c("beer", "wiskey", "wine")
words <- readLines("/Users/HCHung/Documents/2016demo/demo1115WCbyR/o1.csv")
# hunspell_check(words)
bad_words <- hunspell(words)
head(bad_words, 10)
# write(bad_words, file = "o2.txt", sep = "\t")
lapply(bad_words, write, "o3.txt", append=TRUE, ncolumns=1000)
##
