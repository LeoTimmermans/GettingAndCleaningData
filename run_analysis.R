## Load packages to be used
library(data.table)
library(dplyr)

## Downloading the original data
if (!file.exists("./data")) {
        dir.create("./data")
}
fileUrl <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

## Unzip file to datadirectory
unzip("./data/Dataset.zip", exdir = "./data")

## read files
ActivityLabels <-
        read.table("./data/UCI HAR Dataset/activity_labels.txt")
Features <- read.table("./data/UCI HAR Dataset/features.txt")
TestSubjects <-
        read.table("./data/UCI HAR Dataset/test/subject_test.txt")
TrainSubjects <-
        read.table("./data/UCI HAR Dataset/train/subject_train.txt")
TestActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
TrainActivity <-
        read.table("./data/UCI HAR Dataset/train/y_train.txt")
TestData <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
TrainData <- read.table("./data/UCI HAR Dataset/train/x_train.txt")

## merge test and training sets (Subjects, Activity and Data)
AllSubjects <- rbind(TestSubjects, TrainSubjects)
AllActivity <- rbind(TestActivity, TrainActivity)
AllData <- rbind(TestData, TrainData)

## clean data
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

#  name variable(s) for AllSubject, AllActivity and ActivityLabels
colnames(AllSubjects)[1] <- "subjectid"
colnames(AllActivity)[1] <- "activitynr"
colnames(ActivityLabels)[1] <- "activitynr"
colnames(ActivityLabels)[2] <- "activity"

## add variable activityname to AllActivity
#  add rowid to be able to keep the original sorting
AllActivity$id <- 1:nrow(AllActivity)
#  merge AllActivity and ActivityLabels
AllActivity <- merge(AllActivity, ActivityLabels)
#  reset roworder to original roworder of AllActivity
setorder(AllActivity, id)

#  name variables of AllData
setnames(AllData, names(AllData), as.character(Features))

## subset AllData to keep only means and standard deviations
AllData <- AllData[grepl("*mean\\(\\)|std\\(\\)", names(AllData))]

## remove invalid characters from variable names
#  remove () from variable names
names(AllData) <- gsub("\\(\\)", "", names(AllData))
#  remove - from variable names
names(AllData) <- gsub("-", "", names(AllData))

## merge AllSubject, AllActivity and AllData
NewDataTable <- cbind(AllSubjects, AllActivity, AllData)
#  remove variables "id" and "activitynr".
#  they are duplicates of rownumber and activity
NewDataTable <-
        NewDataTable[,!(names(NewDataTable) %in% c("id", "activitynr"))]

## create tidy data set with the average of each variable for each activity and
## each subject
TidyDataSet <- group_by(NewDataTable, subjectid, activity) %>%
        summarise_each(funs(mean))

## create tidy data set with the average of each variable for each activity and
## each subject to disk. The first line of the file contains the variable
## names. File can be read in using: 
## read.table("TidyDataSet.txt", header = TRUE)
## assuming the file is in the working directory
write.table(TidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)