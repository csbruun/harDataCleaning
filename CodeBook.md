CodeBook
========

This file describes how the HAR data is loaded by the script "run_analysis.R", what processes are performed on it, and what the columns and variables in the resulting data set mean.


### The Input Data
The script downloads the data from the UCI HAR data dump located here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It downloads a zip file to the local directory, and then unzips all contents into the local directory.  The locations of the unzipped directory and the data subdirectories are then stored, and the following files are read into memory:
* UCI HAR Dataset/activity_labels.txt
* UCI HAR Dataset/features.txt
* UCI HAR Dataset/test/subject_test.txt
* UCI HAR Dataset/test/X_test.txt
* UCI HAR Dataset/test/Y_test.txt
* UCI HAR Dataset/train/subject_train.txt
* UCI HAR Dataset/train/X_train.txt
* UCI HAR Dataset/train/Y_train.txt

These files are loaded into data frames, and serve as inputs to the data processing steps.

"activity_labels.txt" contains the description of the activity IDs, and "features.txt" contains the description of the columns of the measurement data sets.

"Y_test.txt" and "Y_train.txt" contain the activity IDs for the test and training data, respectively, and "X_test.txt" and "X_train.txt" contain the actual measurement data.  The "subject_test.txt" and "subject_train.txt" files contain the subject IDs for the measured activities.

The data consists of measurements along these features:

* tBodyAcc-{XYZ}
* tGravityAcc-{XYZ}
* tBodyAccJerk-{XYZ}
* tBodyGyro-{XYZ}
* tBodyGyroJerk-{XYZ}
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-{XYZ}
* fBodyAccJerk-{XYZ}
* fBodyGyro-{XYZ}
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Here, the "t"" prefix indicates measurements in the time-domain, and "f" prefix indicates frequency-domain measurements obtained by FFT calculations.  "{XYZ}" indicates that a given measurement is from a spatial sensor, and has measurements in the X, Y, and Z directions.


### Data Processing
The "subject_*", "Y_*", and "X_*" data frames are joined together to produce a complete observation set for each entry.  Additionally, the "activity_labels" frame is used to add a column describing the activity for each observation.  Then the variable columns are filtered for only those columns containing either mean or standard deviation data for each measured feature.


### Data Columns


### Variables
