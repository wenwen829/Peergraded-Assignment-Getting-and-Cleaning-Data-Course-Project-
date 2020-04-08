library(dplyr)
library(tidyr)
library(readr)
if (!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/Dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile="./data/DataSet.zip")}
if(!file.exists("./Data/UCI HAR Dataset")){unzip("./Data/Dataset.zip",exdir="./data")}
