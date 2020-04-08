library(dplyr)
library(tidyr)
library(readr)

# Download the data and unzip
if (!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/Dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile="./data/DataSet.zip")}
if(!file.exists("./data/UCI HAR Dataset")){unzip("./data/Dataset.zip",exdir="./data")}

# Load all the data sets
# Load the main dataset with all measurements
x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE) 
x_test<-read.table("./data/UCI HAR Dataset/test/x_test.txt",header=FALSE)
# Load the columns with activityIds for both datasets
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
# Load the subject column, 21 for training data and 9 for test data
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
# Load the features with all the column names/measurements for both datasets
columnames<-read.table("./data/UCI HAR Dataset/features.txt")
# Load the activity types tested with activityId
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt",header=F)

# Give column names 
colnames(y_train)<-"activityId"; colnames(y_test)<-"activityId"
colnames(subject_train)<-"subjectId";colnames(subject_test)<-"subjectId"
colnames(activity_labels)<-c("activityId","activityType")
colnames(x_train)<-columnames[,2]; colnames(x_test)<-columnames[,2]

# Merge the train and test datasets with activityId and subjectId
merged_train<-cbind(subject_train,y_train,x_train); dim(merged_train);
merged_test<-cbind(subject_test,y_test,x_test);dim(merged_test);
merged_total<-rbind(merged_train,merged_test);dim(merged_total);
names(merged_total)

# Give descriptive names to all measurements
selectednames<-(grepl("activityId|subjectId|mean\\(\\)|std\\(\\)", columnames[,2]))
selectedcolumns<-merged_total[,selectednames==TRUE];dim(selectedcolumns)

# Getting the average of each variable for each activity/subject combination
shorttable<-aggregate(. ~subjectId+activityId, selectedcolumns, mean);dim(shorttable)

# Replace activityIds with descriptive activity names and write to txt file
shorttable1<-merge(shorttable, activity_labels, by="activityId")%>%
  select(subjectId, activityType, everything(),-activityId)%>%
  write.table(file="tidydataset.txt", row.names=FALSE)

# To review the outcome
answer <- read.table("test.txt", header = TRUE) 
View(answer) 


