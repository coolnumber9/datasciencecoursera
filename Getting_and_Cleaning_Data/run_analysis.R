# Getting and Cleaning Data Project John Hopkins Coursera
# Week 4 Peer Graded Assignment
# by: Kristoffer Dominic Amora

# Clean workspace first
rm(list=ls())

# Explictly set the working directory to a preferred directory
prefDir <- "D:\\Documents\\_data-science-track\\_Module3-DataScienceToolbox\\Week4\\peer-graded-assignment"
setwd(prefDir)

if(!file.exists("./downloads")) {
	dir.create("./downloads")
}

# Getting the Data from the given URL
downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(downloadUrl, destfile="./downloads/UCI_HAR.zip")

downloadedFile <- "./downloads/UCI_HAR.zip"

unzip(downloadedFile)

# Storing the path to the txt files
x_train_table <- "UCI HAR Dataset/train/X_train.txt"
x_test_table <- "UCI HAR Dataset/test/X_test.txt"
features <- "UCI HAR Dataset/features.txt"

y_train_table <- "UCI HAR Dataset/train/y_train.txt"
y_test_table <- "UCI HAR Dataset/test/y_test.txt"

subject_train_table <- "UCI HAR Dataset/train/subject_train.txt"
subject_test_table <- "UCI HAR Dataset/test/subject_test.txt"

# Load the Datasets in R or RStudio, then merge both Train and Test Data

# --- X = Measurement variables ---
# Load and merge the data from different source text files
x_train <- read.table(x_train_table)
x_test <- read.table(x_test_table)
combined_xtrain_and_xtest <- rbind(x_train, x_test)
var_names <- read.table(features)
# Features are on V2 column of var_names, 
# so embed these variables as column titles of the combined 
# Xtrain and XTest. This will make the column title descriptive.
colnames(combined_xtrain_and_xtest) <- as.character(var_names$V2)

# --- Y = Different types of Activities ---
# Load and merge the data from different source text files
y_train <- read.table(y_train_table)
y_test <- read.table(y_test_table)
combined_ytrain_and_ytest <- rbind(y_train, y_test)
# Change V1 column to ActivityType to make it more descriptive
colnames(combined_ytrain_and_ytest) <- "ActivityType"

# Make the Activity Type more understandable.
# Based on the Activity Labels provided:
# 1 = WALKING
# 2 = WALKING_UPSTAIRS
# 3 = WALKING_DOWNSTAIRS
# 4 = SITTING
# 5 = STANDING
# 6 = LAYING

ActID1 <- "WALKING"
ActID2 <- "WALKING_UPSTAIRS"
ActID3 <- "WALKING_DOWNSTAIRS"
ActID4 <- "SITTING"
ActID5 <- "STANDING"
ActID6 <- "LAYING"

combined_ytrain_and_ytest[,1] <-gsub("1", ActID1, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("2", ActID2, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("3", ActID3, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("4", ActID4, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("5", ActID5, combined_ytrain_and_ytest[,1])
combined_ytrain_and_ytest[,1] <-gsub("6", ActID6, combined_ytrain_and_ytest[,1])

# Check the summary counts
summary(as.factor(combined_ytrain_and_ytest[,1]))

# Subjects / Participants
subject_train <- read.table(subject_train_table)
subject_test <- read.table(subject_test_table)
combined_subject_train_and_subject_test <- rbind(subject_train, subject_test)
# Make the Column Title for the Participants descriptive enough.
colnames(combined_subject_train_and_subject_test) <- "SubjectNum"

# Time to Merge the subject and activity variables 
temp_df <- cbind(combined_ytrain_and_ytest, combined_xtrain_and_xtest)
overall_merged_df <- cbind(combined_subject_train_and_subject_test, temp_df)

# Selecting the mean and standard deviation variables 
mean_std_cols <- var_names$V2[grep("mean\\(\\)|std\\(\\)", var_names$V2)]
mean_and_std_dvn <- c("SubjectNum", "ActivityType", as.character(mean_std_cols))
selected_df <- subset(overall_merged_df, select = mean_and_std_dvn)

# Making the Column Names more Descriptive
names(selected_df) <-gsub("^t", "Time", names(selected_df))
names(selected_df) <-gsub("^f", "Frequency", names(selected_df))
names(selected_df) <-gsub("BodyAcc", "BodyAcceleration", names(selected_df))
names(selected_df) <-gsub("Mag", "Magnitude", names(selected_df))
names(selected_df) <-gsub("Gyro", "Gyroscope", names(selected_df))
names(selected_df) <-gsub("GravityAcc", "GravityAcceleration", names(selected_df))
# Clean the Open and Close Parenthesis
names(selected_df) <-gsub("\\(\\)", "", names(selected_df))

mean_and_std_dvn_clean <- selected_df
# View the changes...
View(mean_and_std_dvn_clean)

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
mean_and_std_dvn_clean_avg <- aggregate(.~SubjectNum - ActivityType, mean_and_std_dvn_clean, mean)

# View in RStudio...
View(mean_and_std_dvn_clean_avg)

# Write to CSV file
write.table(mean_and_std_dvn_clean_avg, file = "UCI_HAR_mean_and_std_dvn_clean_avg.txt", row.names=FALSE)
