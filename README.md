This is a template you can use for your final projects (as well other projects where you need to post replication code.) Fill in each section with information on your own project.

## Short Description

Give a short, 1-2 paragraph description of your project. Focus on the code, not the theoretical / substantive side of things. 

## Dependencies

1. R, 3.6.1

## Files

#### /

1. Narrative.Rmd: Provides a 3-5 page narrative of the project, main challenges, solutions, and results.
2. Narrative.pdf: A knitted pdf of 00_Narrative.Rmd. 
3. Slides.XXX: Your lightning talk slides, in whatever format you prefer.

#### Code/
1. 01-AmnestyDF.R: Collects data from Amnesty International search results for "Asylum" and exports data to the file Amnesty_International_Asylum.csv.
2. 02-AmnestyTidy.R: Loads and cleans the raw dataset.
3. 03-Amnestyanalysis.R: Creates a dataset of all the words used. Conducts descriptive analysis of the data, producing the visualizations found in the Results directory.

#### Data/

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

#### Results/

1. Wordcloud_Overall.png: A wordcloud of the most frequently used words in Amnesty International articles on asylum.
2. Average Sentiment Scores Over Time.png: A line graph showing how the sentiment score by region has changed from 2016-2019. 

## More Information

Contact Information:
cemallon@uchicago.edu

Citations: 
Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.
Terman, Rochelle (2019). "PLSC 31101: Computational Tools for Social Science" 

