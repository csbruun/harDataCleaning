harDataCleaning
===============

This repository contains R-language data cleaning scripts for UCI human activity recognition data.


### Purpose
The script will download and then process the data from the UCI HAR data dump. 


### Input Data
The data loaded is from the UCI Human Activity Recognition Using Smartphones data set.  This consists of motion sensor data collected from smartphones while a sample set of users was conducting certain activities.

A description of the project and the data set is available here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The the input data is loaded from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script was originally created using the dataset downloaded on 2014-06-21.


### Output Data
The script will produce a CSV file named "HAR_tidy.txt" in the local directory.  This output file consists of the mean measurement values for each subject, activity, and measurement variable.


### To Run the Script
To run the script, make sure you are connected to the internet and have write permission on the current directory.  Then load the script into R and execute.


### To Load the Produced Data File
To load the produced data file "HAR_tidy.txt" into R, use a command such as the following:
    
    har <- read.table(file="HAR_tidy.txt", header=TRUE, sep=",")
    