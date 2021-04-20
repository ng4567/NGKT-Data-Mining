# NGKT-Data-Mining

Summary:

This project is aimed at generating insights for our client Pew Research Center, who is trying to decrease the uncertainty of their findings in their surveys about the relationship between demographics and voting tendenies. We have also created a model that could be implemented by election forecasters, who might seek to predict which way a given county or jurisdiction might vote in a US election a year before. We obtained our demographic data from the US census bureau and our vote count data from MIT election lab.  After cleaning and merging the data, we employed various variable selection techniques to identify key features and then employed classification algorithms to try and predict a county’s vote, which we did with 92% accuracy (as compared to a No-Information-Rate of 84%). We also discovered certain insights about the voting tendencies of white, blacks, Asians, Millenials, and old people.


Data sources:

https://data.census.gov/cedsci/table?g=0100000US.050000&tid=ACSDP5Y2019.DP05&hidePreview=false

https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/VOQCHQ


Because of the complexity of the column names in the Census data, we decided to save time by eliminating some of the columns manually on Excel. Our code shows how to clean the dataset; however, you can use the csv on the Google Drive link to get the final version of the merged dataset we used in our analysis:

https://drive.google.com/file/d/1DFUoakVANu2OmuyBWuFuncjnrP5RgkUu/view?usp=sharing


This repository does not include data (can be accessed in the links above) but does include the following files:

.r file giving our code

.pdf file containing a detailed write up of our methods and results
