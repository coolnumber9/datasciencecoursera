# Getting and Cleaning Data 
## Week 4 | Peer-graded Assignment

![Week 4 Timeline](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/week4.png)

This repository contains all the files needed for the peer-graded assignment requirements of **Getting and Cleaning Data Course (Week 4).**

### Background
One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like **Fitbit**, **Nike**, and **Jawbone Up** are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the **accelerometers** from the **Samsung Galaxy S smartphone**. A full description is available at the site where the data was obtained: 

 * [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

 * [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Note: Emphasis and rephrasing of a couple of texts are mine. The rest are copied from the assignment instruction.

---

The main objectives of this peer-graded assignment is to create an **R script** that does the following:
1. Download the Human Activity Recognition data from the source.
2. Merge Training and Test dataset into one dataset.
3. Extract only the measurements on the mean and standard deviation for each measurement.
4. Labels the dataset with descriptive variable names.
5. From the dataset in step 4, create a second, independent tidy dataset with the average of each variable for each activity and each subject. 

---

## Files
Here are the files in this repo.
1. **Readme** - This file
2. **images** directory - Just a repository for the images embedded in the readme and codebook markdown text.
3. **.gitignore** - use to ignore files that are not needed to be commited in git and github.
4. **codebook.md** - shows the data being provided, the variables and observations, and the steps to reproduce the output that is being required by this course's final assignment.
5. **run_analysis.R** - The R script to produce the output required for this course's final assignment.

**Please refer to the CodeBook for the steps in reproducing the data output needed.**