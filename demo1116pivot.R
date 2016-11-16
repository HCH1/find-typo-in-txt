# install.packages("reshape2")
# install.packages("compare")
# library(reshape2)
# library(compare)
##
setwd("~/Documents/2016demo/demo1115WCbyR/drive-download-20161116T115340Z/28LPSe_Rev1.0_1.0_Truth_Tables_n1n2csv")
ttcsv <- read.csv(file = "~/Documents/2016demo/demo1115WCbyR/drive-download-20161116T115340Z/28LPSe_Rev1.0_1.0_Truth_Tables_n1n2csv/28LPSe_Rev1.0_1.0_Truth_Tables_DTTn1v3.csv",header = TRUE)
# unpivot
ttcsv2 <- melt(ttcsv, id = c("Device", "SPICE"), na.rm = TRUE)
# sort
ttcsv2 <- ttcsv2[order(ttcsv2$Device),]
# pivot
ttcsv3 <- dcast(ttcsv2, Device + SPICE ~ variable)
# dd[with(dd, order(-z, b)), ]
# save unpivot
write.table(x = ttcsv2, file = "o1116v1.csv", sep = ",", 
            col.names = NA, qmethod = "double")
##
# dcast(DT.m1, family_id + age_mother ~ child, value.var = "dob")
##
a1 <- read.csv(file = "~/Documents/2016demo/demo1115WCbyR/drive-download-20161116T115340Z/28LPSe_Rev1.0_1.0_Truth_Tables_n1n2csv/o1116v1.csv",header = TRUE)
a2 <- read.csv(file = "~/Documents/2016demo/demo1115WCbyR/drive-download-20161116T115340Z/28LPSe_Rev1.0_1.0_Truth_Tables_n1n2csv/o1116v1c2.csv",header = TRUE)
# comparison <- compare(a1,a2,allowAll=TRUE)
# lapply(comparison, write, "o1116v1.txt", append=TRUE, ncolumns=1000)
