file=open("28LPSErulesALL_orig","r+")
wordcount={}
for word in file.read().split():
    if word not in wordcount:
        wordcount[word] = 1
    else:
        wordcount[word] += 1
#log = open("wc_28LPSE.txt", "w");
for k,v in wordcount.items():
    #print >>log, k, v
    print k, v