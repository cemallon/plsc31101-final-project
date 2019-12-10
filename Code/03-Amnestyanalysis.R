## This script does the following stuff:
## Getting Set up
require(tm)
require(ggplot2)
require (wordcloud)
require(tidytext)
require(tidyverse)
require(textdata)
require(dplyr)
require(glmnet)
require(stargazer)
require(gridExtra)

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
set.seed(478)
wordcloud(names(Asylum_sorted),Asylum_sorted,max.words=50, colors=brewer.pal(4,"Paired"),scale=c(2.0,0.25),res=300)

##Average Sentiment Scores Over Time Line Plot
Asylum.dat%>%
  group_by(Region,Date)%>%
  summarise(Mean_Scores=mean(Scores, na.rm=T))%>%
  ggplot(aes(x=Date, y=Mean_Scores,color=Region))+
  geom_line(size=1.5)+
  ylab("Mean Sentiment Score")+
  xlab("Year")+
  ggtitle("Average Sentiment Scores Over Time")

##Sentiment Scores by Region Column Plot
Asylum.dat%>%
  group_by(Date,Region)%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

##Column Plot 2015
Asylumyear1<- Asylum.dat%>%
  group_by(Region)%>%
  filter(Date=="2015")%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("2015 Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

#Column Plot 2016
Asylumyear2<- Asylum.dat%>%
  group_by(Region)%>%
  filter(Date=="2016")%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("2016 Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

#Column Plot 2017
Asylumyear3<- Asylum.dat%>%
  group_by(Region)%>%
  filter(Date=="2017")%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("2017 Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

#Column Plot 2018
Asylumyear4<- Asylum.dat%>%
  group_by(Region)%>%
  filter(Date=="2018")%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("2018 Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

#Column Plot 2019
Asylumyear5<- Asylum.dat%>%
  group_by(Region)%>%
  filter(Date=="2019")%>%
  summarise(MScore=mean(Scores, na.rm=T))%>%
  as_tibble()%>%
  ggplot(aes(x=Region,MScore, y=MScore,fill=Region))+
  geom_col()+
  scale_color_brewer("Paired")+
  ylab("Sentiment Score")+
  xlab("Region")+
  ggtitle("2019 Average Sentiment Scores By Region")+
  scale_y_reverse()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))

grid.arrange(Asylumyear1, Asylumyear2, Asylumyear3, Asylumyear4, Asylumyear5, nrow=2)



##Breakdown by region to see negative words
Model1<- lm(Asylum.dat$Scores~factor(Asylum.dat$Region))
Model2<- lm(Asylum.dat$Scores~factor(Asylum.dat$Date))
Model3<- lm(Asylum.dat$Scores~factor(Asylum.dat$Region)+factor(Asylum.dat$Date))

Asylum_Regression<- stargazer(Model1, Model2, Model3, title="Regression Results",type="text",
          omit="Constant", keep.stat="n",style="ajps",
          covariate.labels = c("Africa","Americas","Asia and the Pacific",
                               "Europe and Central Asia", "Middle East and North Africa",
                               "Morocco and Western Sahara", "Russia","Turkey",
                               "2016","2017","2018","2019",
                               out="regression-table.txt"))
write.table(Asylum_Regression,file="regression-table.txt",quote = FALSE, row.names = F)




















