This is a template you can use for your final projects (as well other projects where you need to post replication code.) Fill in each section with information on your own project.

## Short Description
In this project I webscrapped Amnesty International's articles published on Asylum between 2015 and 2019. In Code 01 I first collect the URLs of all of the search results across the four search pages using a function 'all_URLs'. Through another function I was able to get the region, title, date, and text of each article which became a dataframe and was written into a csv file. 

In Code 02 the data collected in 01 is tidied into Amnesty_International_Asylum_CLEAN.csv. All of the NAs were removed from the dataset, incorrect formattings are removed, and several of the 'Regions' are renamed to be more encompassing. 

In Code 03 the data is processed for text analysis using the 'bing' sentiment dictionary. Visual depictions of the data are created using the newly formatted text including a word cloud, line graph, several column plots, and a regression analysis. 

## Dependencies

1. R, 3.6.1

## Files

1. Narrative.Rmd: Provides a narrative of the project, main challenges, solutions, and results.
2. Narrative.pdf: A knitted pdf of 00_Narrative.Rmd. 
3. AsylumSlides: Presentation slides discussing the process and results of the project.

#### Code
1. 01-AmnestyDF.R: Collects data from Amnesty International search results for "Asylum" and exports data to the file Amnesty_International_Asylum.csv.
2. 02-AmnestyTidy.R: Loads and cleans the raw dataset.
3. 03-Amnestyanalysis.R: Creates a dataset of all the words used. Conducts descriptive analysis of the data, producing the visualizations found in the Results directory and the regression table.

#### Data

1. Amnesty_International_Asylum.csv: The dataset constructed from scraping Amnesty International's search results for Amnesty. 
Link: https://www.amnesty.org/en/latest/news/?contentType=2561&issue=1613&sort=date&p=7
The dataset includes observations for the following variables: 
    - *Date*: Year the article was published. 
    - *Region*: Region the article focuses on. 
    - *Title*: Title of the Amnesty International article.
    - *Text*: Text of the Amnesty International articles. 
2. Amnesty_International_Asylum_CLEAN.csv: The cleaned dataset. Removes all NAs from the dataset and collapses the Region column into more inclusive categories. 
    - *Date*: Year the article was published. 
    - *Region*: Region the article focuses on.
    - *Title*: Title of the Amnesty International article.
    - *Text*: Text of the Amnesty International articles. 
3.Amnesty_International_Asylum_Text_Analysis.csv: The dataset used for text analysis of the articles. 
    - *Date*: Year the article was published. 
    - *Region*: Region the article focuses on.
    - *Title*: Title of the Amnesty International article.
    - *Text*: Text of the Amnesty International articles. 
    - *Score*: The positive or negative score of the words used in the                articles. 

#### Results

1. Wordcloud_Overall.png: A wordcloud of the most frequently used words in Amnesty International articles on asylum.
2. Average Sentiment Scores Over Time.png: A line graph showing how the sentiment score by region has changed from 2015-2019. 
3. regression-table.txt: The regression results of the three models showing the effects of region and date on the score of an article. 
4. Average Sentiment Scores by Region Overall.png: An column plot showing the mean sentiment scores by region overall. 
5. Multiple_Charts.png: A file diaplaying numerous column plots showing the mean sentiment scores by region per year. 

## More Information

Contact Information:
cemallon@uchicago.edu

Citations: 
Amenesty International. December 8, 2019. https://www.amnesty.org/en/latest/news/?contentType=2561&issue=1613&sort=date.
Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.
Terman, Rochelle (2019). "PLSC 31101: Computational Tools for Social Science" 


