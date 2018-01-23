# CodeBook
## Introduction
Steps enumerated below with explanation. Screenshot in RStudio is provided as well.

### Environment Initialization
Clean workspace environment first.
```R
rm(list=ls())
```

Explictly set the working directory to a preferred directory. Structure below is just a personal preference.
```R
refDir <- "D:\\Documents\\_data-science-track\\_Module3-DataScienceToolbox\\Week4\\peer-graded-assignment"
setwd(prefDir)

if(!file.exists("./downloads")) {
	dir.create("./downloads")
}
```

### Getting the Human Activity Recognition (HAR) Data from the given URL
```R
downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(downloadUrl, destfile="./downloads/UCI_HAR.zip")

downloadedFile <- "./downlads/UCI_HAR.zip"

unzip(downloadedFile)
```
![Downloading Zipfile in RStudio](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/Week4-downloadZipFile.png)

### Storing the path to the text files with data
```R
x_train_table <- "UCI HAR Dataset/train/X_train.txt"
x_test_table <- "UCI HAR Dataset/test/X_test.txt"
features <- "UCI HAR Dataset/features.txt"

y_train_table <- "UCI HAR Dataset/train/y_train.txt"
y_test_table <- "UCI HAR Dataset/test/y_test.txt"

subject_train_table <- "UCI HAR Dataset/train/subject_train.txt"
subject_test_table <- "UCI HAR Dataset/test/subject_test.txt"
```

### Load the Datasets in R or RStudio, then merge both Train and Test Data
**X = Measurement Variables**
Load and merge the data from different source text files.
```R
x_train <- read.table(x_train_table)
x_test <- read.table(x_test_table)
combined_xtrain_and_xtest <- rbind(x_train, x_test)
var_names <- read.table(features)
```
![Var Names](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/var_names.png)

Features are on **V2** column of **var_names** (561 obs. of 2 variables), so embed these variables as column titles of the combined **Xtrain** and **XTest**. This will make the column title descriptive.
```R
colnames(combined_xtrain_and_xtest) <- as.character(var_names$V2)
```
![Combined XTrain and XTest](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/combined_xtrain_and_xtest.png)


**Y = Different types of Activities**
Load and merge the data from different source text files.
```R
y_train <- read.table(y_train_table)
y_test <- read.table(y_test_table)
combined_ytrain_and_ytest <- rbind(y_train, y_test)
```
![Combined XTrain and XTest](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/combined_ytrain_and_ytest.png)

Change **V1** column to **ActivityType** to make it more descriptive.
```R
colnames(combined_ytrain_and_ytest) <- "ActivityType"
```

**Make the ActivityType more understandable.**
Based on the Activity Labels provided:
ActivityID | ActivityType
------------ | -------------
1 | WALKING
2 | WALKING_UPSTAIRS
3 | WALKING_DOWNSTAIRS
4 | SITTING
5 | STANDING
6 | LAYING

```R
ActID1 <- "WALKING"
ActID2 <- "WALKING_UPSTAIRS"
ActID3 <- "WALKING_DOWNSTAIRS"
ActID4 <- "SITTING"
ActID5 <- "STANDING"
ActID6 <- "LAYING"

```

Then, replaced the ID to its equivalent descriptive Activity Type.
```R
combined_ytrain_and_ytest[,1] <-gsub("1", ActID1, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("2", ActID2, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("3", ActID3, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("4", ActID4, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("5", ActID5, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("6", ActID6, combined_ytrain_and_ytest[,1])
```

A view of the Summary Counts.
```R
summary(as.factor(combined_ytrain_and_ytest[,1]))
```
![Summary Counts](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/summaryCounts.png)

**Subjects / Participants**
Load and merge the data from different source text files.
```R
subject_train <- read.table(subject_train_table)
subject_test <- read.table(subject_test_table)
combined_subject_train_and_subject_test <- rbind(subject_train, subject_test)
```
![Combined Subjects](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/combined_subject_train_and_subject_test.png)

**Time to merge the Subject and Activity variables.**
```R
temp_df <- cbind(combined_ytrain_and_ytest, combined_xtrain_and_xtest)
overall_merged_df <- cbind(combined_subject_train_and_subject_test, temp_df)
```
![Overall Merged Data](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/overall_merged_data.png)

**Selecting the mean and standard deviation variables.**
```R
mean_std_cols <- var_names$V2[grep("mean\\(\\)|std\\(\\)", var_names$V2)]
mean_and_std_dvn <- c("SubjectNum", "ActivityType", as.character(mean_std_cols))
selected_df <- subset(overall_merged_df, select = mean_and_std_dvn)
```

**Making the Column Names more Descriptive**
```R
names(selected_df) <-gsub("^t", "Time", names(selected_df))
names(selected_df) <-gsub("^f", "Frequency", names(selected_df))
names(selected_df) <-gsub("BodyAcc", "BodyAcceleration", names(selected_df))
names(selected_df) <-gsub("Mag", "Magnitude", names(selected_df))
names(selected_df) <-gsub("Gyro", "Gyroscope", names(selected_df))
names(selected_df) <-gsub("GravityAcc", "GravityAcceleration", names(selected_df))
# Clean the Open and Close Parenthesis
names(selected_df) <-gsub("\\(\\)", "", names(selected_df))

mean_and_std_dvn_clean <- selected_df
```

**View the changes in RStudio**
```R
View(mean_and_std_dvn_clean)
```
![mean_and_std_dvn_clean](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/mean_and_std_dvn_clean.png)

**Create a second, independent tidy data set with the average of each variable for each activity and each subject.**
```R
mean_and_std_dvn_clean_avg <- aggregate(.~SubjectNum - ActivityType, mean_and_std_dvn_clean, mean)
```

**View in RStudio...**
```R
View(mean_and_std_dvn_clean_avg)
```
![mean_and_std_dvn_clean_avg](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/mean_and_std_dvn_clean_avg.png)

**Write to a CSV file.**
```R
write.table(mean_and_std_dvn_clean_avg, file = "UCI_HAR_mean_and_std_dvn_clean_avg.csv", row.names=FALSE)
#write.csv(mean_and_std_dvn_clean_avg, "UCI_HAR_mean_and_std_dvn_clean_avg.txt")

```