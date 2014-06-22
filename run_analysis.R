library(reshape2)

## 1 Obtain zip file and unpack
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



## 2 Identify locations of directories and files

# Directories
dataDir <- "UCI HAR Dataset"
testDataDir <- paste(dataDir, "/test", sep="")
trainDataDir <- paste(dataDir, "/train", sep="")

# Descriptive files
activityLabelsFile <- paste(dataDir, "/activity_labels.txt", sep="")
featuresFile <- paste(dataDir, "/features.txt", sep="")

# Test files
subjectTestFile <- paste(testDataDir, "/subject_test.txt", sep="")
xTestFile <- paste(testDataDir, "/X_test.txt", sep="")
yTestFile <- paste(testDataDir, "/Y_test.txt", sep="")

# Train files
subjectTrainFile <- paste(trainDataDir, "/subject_train.txt", sep="")
xTrainFile <- paste(trainDataDir, "/X_train.txt", sep="")
yTrainFile <- paste(trainDataDir, "/Y_train.txt", sep="")



## 3 Read data files to dataframes

# Descriptive data
activityLabels <- read.table(activityLabelsFile,
                             sep="",
                             header=FALSE,
                             col.names = c("activityId", "activity")
                             )
featuresFrame <- read.table(featuresFile,
                            sep="",
                            header=FALSE,
                            col.names = c("featureId", "feature")
                            )
# Convert features dataframe to vector
features <- featuresFrame[["feature"]]


# Read test data
subjectTest <- read.table(subjectTestFile,
                          sep="",
                          header=FALSE,
                          col.names = c("subjectId")
                          )
xTest <- read.table(xTestFile,
                    sep="",
                    header=FALSE,
                    col.names = features
                    )
yTest <- read.table(yTestFile,
                    sep="",
                    header=FALSE,
                    col.names = c("activityId")
                    )


# Read train data
subjectTrain <- read.table(subjectTrainFile,
                           sep="",
                           header=FALSE,
                           col.names = c("subjectId")
                           )
xTrain <- read.table(xTrainFile,
                     sep="",
                     header=FALSE,
                     col.names = features
                     )
yTrain <- read.table(yTrainFile,
                     sep="",
                     header=FALSE,
                     col.names = c("activityId")
                     )



## 4 Merge subject, x, and y data frames for test and train data

# Merge data frames for test data, add column for activity description
testActivities <- cbind(activityLabels[yTest$activityId,])
rownames(testActivities) <- NULL
test <- data.frame(subjectTest, testActivities, xTest)

# Merge data frames for train data, add column for activity description
trainActivities <- cbind(activityLabels[yTrain$activityId,])
rownames(trainActivities) <- NULL
train <- data.frame(subjectTrain, trainActivities, xTrain)



## 5 Merge test and train data frames together, add column for data type
test <- data.frame(type="test", test)
train <- data.frame(type="train", train)

merged <- rbind(test, train)



## 6 Filter for mean and std dev columns of data frame

# Produce list of columns to use as filter on data frame
columns <- features[grep("mean\\(\\)|std\\(\\)",
                         features, ignore.case=TRUE, perl=TRUE)]
columnFilter <- make.names(columns)

# Produced cleaned up column names (remove extra ".")
cleanColumns <- gsub("\\.\\.\\.", ".", columnFilter, perl=TRUE)
cleanColumns <- gsub("\\.\\.$", "", cleanColumns, perl=TRUE)

columnFilter <- c("subjectId", "activity", columnFilter)
cleanColumnFilter <- c("subjectId", "activity", cleanColumns)

# Apply column filter to merged data frame
filtered <- merged[,columnFilter]
colnames(filtered) <- cleanColumnFilter



## 7 Melt data frame to produce tidy data table

## The observation ids are "subjectId" and "activity"
## The variables are the mean and std columns of the original dataset

ids = c("subjectId", "activity")
melted <- melt(filtered,
               id.vars=ids,
               measure.vars=cleanColumns,
               variable.name="variable",
               value.name="value")



## 8 Compute means for each subjectId, activity, variable
agg <- aggregate(melted$value,
                 by=list(subjectId=melted$subjectId,
                         activity=melted$activity,
                         variable=melted$variable),
                 FUN=mean)
colnames(agg) <- c("subjectId", "activity", "variable", "mean")



## 8 Output the table to file
outputFile = "HAR_tidy.txt"
write.table(agg, file = outputFile,
            quote = FALSE,
            sep = ",",
            row.names = FALSE,
            col.names = TRUE)

