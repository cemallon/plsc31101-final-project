#Looking at Amnesty International's News on Asylum seekers (Filters= Asylum + Article)
require(tidyverse)
require(dplyr)
require(rvest)
require(stringr)
require(purrr)
require(lubridate)

base<- "https://www.amnesty.org/en/latest/news/?contentType=2561&issue=1613&sort=date&p="
page=c(1:11)%>%as.character()
webpages<- str_c(base, page)

#gets all the URLs from the search results
all_URLs<- function(i){
  URLs<- read_html(i)%>%
    html_nodes(".search-item__link")%>%
    html_attr("href")%>%
    as.character()
  results<- paste0("https://www.amnesty.org", URLs)
  return(results)
}
#all of the news articles
ALL_URLS<- map(webpages, all_URLs)%>%
  unlist()

#function to get the region, title, date, and text of each article
scrape_text <- function(url){
  webpage<- read_html(url)
  text <- html_nodes(webpage, ".wysiwyg") %>%
    html_text()
  title<- html_nodes(webpage,".heading--main")%>%
    html_text()
  region<-html_nodes(webpage, ".tags__item--bold--sm+ .tags__item--discrete .tags__link--discrete--md")%>%
    html_text()
  date<- html_nodes(webpage, "time")%>%
    html_text()
  all_info<- data.frame(date=ifelse(length(date)==0, NA, date),
                        region=ifelse(length(region)==0,NA, region),
                        title= ifelse(length(title)==0,NA,title),
                        text= ifelse(length(text)==0,NA,text))
  return(all_info)
}
#Need to include the ifelse part in the data.frame in case articles aren't formatted in the same way
#Apparently its too much money to have uniform structure
#some of the articles aren't actually formatted using the same nodes, 
#some titles use nodes that mean different things on different pages

#Making a giant data frame
Amenesty_International_Asylum<- map_dfr(ALL_URLS,scrape_text)

#Creating a csv file 
write.csv(Amenesty_International_Asylum,file= "Amenesty_International_Asylum.csv")











