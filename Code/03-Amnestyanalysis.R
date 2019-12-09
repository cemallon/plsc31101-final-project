## This script does the following stuff:
## Getting Set up
require(tm)
require(ggplot2)
require (wordcloud)
require(tidytext)
require(tidyverse)
require(textdata)
require(dplyr)

Asylum.dat<- read.csv(file="/Users/cemallon/Documents/Computational-Tools/plsc31101-final-project/Data/Amenesty_International_Asylum_CLEAN.csv",stringsAsFactors = FALSE)

##Pre-Processing
Asylum<-Corpus(VectorSource(Asylum.dat$Text))
Asylum_dtm <- DocumentTermMatrix(Asylum,
                          control = list(stopwords = TRUE,
                                         tolower = TRUE,
                                         removeNumbers = TRUE,
                                         removePunctuation = TRUE))
Asylum_dtm<-as.data.frame(as.matrix(Asylum_dtm))

#Using bing lexicon for simple binary positive v. negative categorization
Asylum_sentiments<- get_sentiments("bing")

Asylum_sentiments$score<-ifelse(Asylum_sentiments$sentiment=="positive",1,-1)


#Score each article 
Words<- data.frame(word=colnames(Asylum_dtm))
Words<-merge(Words,Asylum_sentiments,all.x=T)
Words$score[is.na(Words$score)]<-0
Scores<- as.matrix(Asylum_dtm)%*%Words$score

##Edit the dataframe
Asylum.dat$Scores= Scores
Asylum.dat<- Asylum.dat%>%
  subset(select=-c(X))

#Write a CSV file of the data 
write.csv(Asylum.dat, "Amnesty_International_Asylum_Text_Analysis.csv")

##OverallWordcloud
Asylum_frequency<-colSums(as.matrix(Asylum_dtm))
Asylum_sorted<-sort(Asylum_frequency,decreasing=F)
set.seed(188)
wordcloud(names(Asylum_sorted),Asylum_sorted,max.words=50, colors=brewer.pal(4,"Paired"))

##Average Sentiment Scores Over Time Line Plot
Asylum.dat%>%
  group_by(Region,Date)%>%
  summarise(Mean_Scores=mean(Scores, na.rm=T))%>%
  ggplot(aes(x=Date, y=Mean_Scores,color=Region))+
  geom_line(size=1.5)+
  ylab("Mean Sentiment Score")+
  xlab("Year")+
  ggtitle("Average Sentiment Scores Over Time")

#Want to do a breakdown by region to see negative words


















