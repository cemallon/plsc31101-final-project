## This file tidies the csv file created in 01
## Setting up: 
require(tidyverse)
require(dplyr)
require(rvest)
require(stringr)
require(purrr)
require(lubridate)
Asylum<- read.csv(file="/Users/cemallon/Documents/Computational-Tools/plsc31101-final-project/Data/Amenesty_International_Asylum.csv",stringsAsFactors = FALSE)

#filter out all the NAs
Asylum_Full<- Asylum%>%
  filter(!is.na(region), !is.na(date), !is.na(text), !is.na(title))%>%
  subset(select=-c(X))

#filter out all the incorrect titles
#these are titles like "Amnesty's Experts"
#the reason is that these pages are coded differently than 
Asylum_Title<-Asylum_Full%>%
  filter(title!="Amnesty's experts")
#number of observations dropped from 159 to 132

#This gives everything a nice name and simplifies the date to just the year
Asylum_Tidy<-Asylum_Title%>%
  rename(Date=date, Region=region, Title=title, Text=text)%>%
  mutate(Date=as.numeric(str_extract(Date,"\\d{4}")))


#Next I need to manually collapse the regions
#For some reason, Amnesty International doesn't stick to regions
#In a few cases they list specific countries
#I'll continue to keep the Turkey, Afghanistan, and Russia left as separate entities
#Miscoding on the original site for two articles, marked the regions as Refugees and Detention
#Recoded to Europe

Region_clean<- recode(Asylum_Tidy$Region,"Burundi"="Africa", "Congo"="Africa", "Kenya"="Africa", "Eritrea"="Africa",
                         "Libya"="Middle East and North Africa","Middle East and North Africa " = "Middle East and North Africa",
                         "Hungary"= "Europe and Central Asia", "Spain"="Europe and Central Asia", 
                         "France"="Europe and Central Asia","Greece"="Europe and Central Asia","Italy"="Europe and Central Asia",
                         "Ecuador"="Americas","Venezuela"="Americas", "Cuba"="Americas",
                         "Nauru" = "Asia and The Pacific", "Australia"="Asia and The Pacific", "Malaysia"="Asia and The Pacific",
                         "Refugees"="Europe and Central Asia","Detention"="Europe and Central Asia",
                          "United States of America"="Americas")

Asylum_Tidy$Region_clean<- as.character(Region_clean)

#Removing the old Region 
Asylum_Tidyer<- Asylum_Tidy%>%
  subset(select= -c(Region))%>%
  rename("Region"="Region_clean")%>%
 subset(select=c(1,4,2,3))
  
write.csv(Asylum_Tidyer,file= "Amenesty_International_Asylum_CLEAN.csv")

