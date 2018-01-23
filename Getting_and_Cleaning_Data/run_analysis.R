# Getting and Cleaning Data Project John Hopkins Coursera
# Week 4 Peer Graded Assignment
# by: Kristoffer Dominic Amora

# Clean workspace first
rm(list=ls())

# Explictly set the working directory to a preferred directory
prefDir <- "D:\\Documents\\_data-science-track\\_Module3-DataScienceToolbox\\Week4\\peer-graded-assignment"
setwd(prefDir)

if(!file.exists("./data")) {
	dir.create("./data")
}

downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(downloadUrl, destfile="./data/UCI_HAR.zip")

zipFile <- "UCI_HAR.zip"
unzip(zipFile)
