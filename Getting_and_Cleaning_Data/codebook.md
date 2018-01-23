# CodeBook
## Introduction
...TO be filled with description here...

### Initialization
Clean workspace first.
```R
rm(list=ls())
```

Explictly set the working directory to a preferred directory.
```R
refDir <- "D:\\Documents\\_data-science-track\\_Module3-DataScienceToolbox\\Week4\\peer-graded-assignment"
setwd(prefDir)

if(!file.exists("./data")) {
	dir.create("./data")
}
```

### Getting the Data from the given URL
```R
downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(downloadUrl, destfile="./data/UCI_HAR.zip")

zipFile <- "UCI_HAR.zip"
unzip(zipFile)
```
![Downloading Zipfile in RStudio](https://github.com/coolnumber9/datasciencecoursera/blob/master/Getting_and_Cleaning_Data/images/Week4-downloadZipFile.png)