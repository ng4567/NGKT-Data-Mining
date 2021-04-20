# NGKT-Data-Mining

Summary:

This project is aimed at generating insights for groups such as data journalists, who might seek to predict which way a given county or jurisdiction might vote in a US election. This project does not use any polling data, and instead uses demographic data from the US census to try and predict if a given county is more likely to cast more votes for Democrats or Republicans in a US election. We obtained our demographic data from the US census bureau and our vote count data from MIT election lab.  After cleaning and merging the data, we employed various variable selection techniques to identify key features and then employed classification algorithms to try and predict a county’s vote. After validating our model with a 10-fold cross validation, we were able to engineer a k-nearest neighbors’ algorithm that predicted a county’s vote with 90% accuracy.


Data sources:

https://data.census.gov/cedsci/table?g=0100000US.050000&tid=ACSDP5Y2019.DP05&hidePreview=false

https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/VOQCHQ


Because of the complexity of the column names in the Census data, we decided to save time by eliminating some of the columns manually on Excel. Our code shows how to clean the dataset; however, you can use the csv on the Google Drive link to get the final version of the merged dataset we used in our analysis:

https://drive.google.com/file/d/1DFUoakVANu2OmuyBWuFuncjnrP5RgkUu/view?usp=sharing


This repository does not include data (can be accessed in the links above) but does include the following files:

.r file giving our code

.pdf file containing a detailed write up of our methods and results
