---
title: "Readme file for coursera getting and cleaning data project"
output: github_document
---
#Getting and cleaning data course project
_By: Leo Timmermans_  
_Submission date: december 31, 2016_

#Instructions for the project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

Here are the data for the project:
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Steps taken to achieve this:
##Loading the needed packages into R
```R
## Load packages to be used
library(data.table)
library(dplyr)
```

## Download the original data
```R
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

## Unzip file to datadirectory
unzip("./data/Dataset.zip", exdir = "./data")
```

##Download and unzip the files
```R
## Downloading the original data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

## Unzip file to datadirectory
unzip("./data/Dataset.zip", exdir = "./data")
```
This creates a new folder `("./data/UCI HAR Dataset")` containing the original files.
After reading the documentation in `README.txt`, the files needed for the analysis in the assignment are:  
- `activity_labels.txt` - activity for which data was recorded  
- `features.txt` - column names / variable names for the columns in the data files  
- `test/subject_test.txt` and `train/subject_test.txt` - number of the subject whose data was recorded  
- `test/Y_test.txt` and `train/Y_train.txt` - activity for which data was recorded  
- `test/X_test.txt` and `train/X_train.txt` - recorded data from the experiment  

## Read files into R and merge the test and training set
Above files are read into R using the `read.table` command.
```R
## read files
ActivityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
Features <- read.table("./data/UCI HAR Dataset/features.txt")
TestSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
TrainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
TestActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
TrainActivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
TestData <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
TrainData <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
```
While the test and training sets are merged by using the `rbind` command.
```R
## merge test and training sets (Subjects, Activity and Data)
AllSubjects <- rbind(TestSubjects, TrainSubjects)
AllActivity <- rbind(TestActivity, TrainActivity)
AllData <- rbind(TestData, TrainData)
```

##Give the variables descriptive variable names
As taught in the lecture "Editing Text Variables", names of variables have been changed to meet following standards:  
- All lower case  
- Descriptive names  
- No duplicates  
- No underscores, dots or white spaces  

By now the variable names are in the dataframe called `Features` (from the file `features.txt`).  
Changes to the variable names:  
- all lower case  
- variable names starting with "t" are now starting with "time" (descriptive name)  
- variable names starting with "f" are now starting with "frequency" (descriptive name)  
- variable names containing "acc" now contain "accelerometer" (descriptive name)  
- variable names containing "gyro" now contain "gyroscope" (descriptive name)  
- variable names containing "mag" now contain "magnitude" (descriptive name)  
- variable names containing "bodybody" now contain "body" (remove duplicate)  

Code used:
```R
#  remove first column of Features, to have a set of column names
#  and make the names all lower case
Features <- tolower(Features$V2)
#  renaming values in Features to get descriptive variable names
Features <- gsub("^t", "time", Features)
Features <- gsub("^f", "frequency", Features)
Features <- gsub("acc", "accelerometer", Features)
Features <- gsub("gyro", "gyroscope", Features)
Features <- gsub("mag", "magnitude", Features)
Features <- gsub("bodybody", "body", Features)
```
Assign names to variables in the dataframes `AllSubjects`, `AllActivity` and `ActivityLabels`:
```R
#  name variable(s) for AllSubject, AllActivity and ActivityLabels
colnames(AllSubjects)[1] <- "subjectid"
colnames(AllActivity)[1] <- "activitynr"
colnames(ActivityLabels)[1] <- "activitynr"
colnames(ActivityLabels)[2] <- "activity"
```

##Descriptive names for activities in the data set
Because merging activitynames with activities changes the sorting, I've added rownumbers to the dataframe containing the activities (`AllActivity`). After that I've merged the dataframes `AllActivity` and `ActivityLabels` into `AllActivity` and reset the sorting to the original order using the rownumbers.
```R
## add variable activityname to AllActivity
#  add rowid to be able to keep the original sorting
AllActivity$id <- 1:nrow(AllActivity)
#  merge AllActivity and ActivityLabels
AllActivity <- merge(AllActivity, ActivityLabels)
#  reset roworder to original roworder of AllActivity
setorder(AllActivity, id)
```

##Add variablenames to the data
The data still has no variablenames. The variablenames in `Features` are the names needed for the data.
```R
#  name variables of AllData
setnames(AllData, names(AllData), as.character(Features))
```

##Extract only the measurements on the mean and standard deviation for each measurement. 
The file `features_info.txt` tells us that there measurements each have, among others a mean, a standard deviation. However there also is a variables partially named meanFreq (=mean frequency).
This meanFreq is not a mean of the measurements of the variable, so I have not taken these variables into account for this assignment. Which means only variables with the addition `"-mean()-"` and `"-std()-"` where extracted.
```R
## subset AllData to keep only means and standard deviations
AllData <- AllData[grepl("*mean\\(\\)|std\\(\\)", names(AllData))]
```

##Remove invalid characters from variable names
Parenthesis `()` and minus signs `-` are converted to dots when reading data. To prevent difficulties these characters are removed.
```R
## remove invalid characters from variable names
#  remove () from variable names
names(AllData) <- gsub("\\(\\)", "", names(AllData))
#  remove - from variable names
names(AllData) <- gsub("-", "", names(AllData))
```

##Combine subjects, activities and data into 1 table (dataframe)
The info from subjects, activities and data need to be put together and duplicates (`rownumber` and `activitynumber`) need to be removed to have no duplicates in variables.
```R
## merge AllSubject, AllActivity and AllData
NewDataTable <- cbind(AllSubjects, AllActivity, AllData)
#  remove variables "id" and "activitynr".
#  they are duplicates of rownumber and activity
NewDataTable <- NewDataTable[,!(names(NewDataTable) %in% c("id", "activitynr"))]
```

##Create a seperate, independent tidy data set with the average of each variable for each activity and each subject
The dataset needs to be grouped by `subjectid` and `activity` and the mean needs to be calculated for each of the variables.
```R
## create tidy data set with the average of each variable for each activity and 
## each subject
TidyDataSet <- group_by(NewDataTable, subjectid, activity) %>%
                        summarise_each(funs(mean))
```
Now the data can be written to disk in the file `"TidyDataSet.txt"`. As per instruction `row.names = FALSE` has to be used in the command.
```R
## create tidy data set with the average of each variable for each activity and
## each subject to disk. The first line of the file contains the variable
## names. File can be read in using: 
## read.table("TidyDataSet.txt", header = TRUE)
## assuming the file is in the working directory
write.table(TidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)
```
This file is also in this repository, just like the complete r-script `run_analysis.R`. The file can be read into R using the command `read.table("TidyDataSet.txt", header = TRUE)`. The first row in the file contains the variable names.
The tidy data set has 180 rows of data (30 subjects with 6 activities each) and 68 columns (subjectid, activity and 66 means of measurements).