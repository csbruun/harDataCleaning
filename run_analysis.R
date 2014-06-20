## 1 Obtain zip file and unpack
setwd("C:\\Users\\Christian\\Documents\\Data_Science\\Getting_and_Cleaning_Data\\Project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
localFile <- "UCI_HAR.zip"
if (!file.exists(localFile)) {
  download.file(fileUrl, destfile = localFile)
  dateDownloaded <- date()
  dateDownloaded
  
  unzip(localFile,
        list=TRUE)
  
  unzip(localFile,
        list=FALSE,
        overwrite=TRUE,
        unzip="internal")
}

dataDir <- "UCI HAR Dataset"
testDataDir <- paste(dataDir, "/test", sep="")
trainDataDir <- paste(dataDir, "/train", sep="")


