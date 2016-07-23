library(reshape2)

fname <- "getdata_dataset.zip"

## Downloading and unzipping the given dataset:
if (!file.exists(fname)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, fname, method="curl")
}  
else if (!file.exists("UCI HAR Dataset")) { 
  unzip(fname) 
}

# Load activity labels + features
act_lbl <- read.table("UCI HAR Dataset/activity_labels.txt")
act_lbl[,2] <- as.character(act_lbl[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# This part aims at extracting only the data based on mean and standard deviation
featuresRequired <- grep(".*mean.*|.*std.*", features[,2])
featuresRequired.names <- features[featuresRequired,2]
featuresRequired.names = gsub('-mean', 'Mean', featuresRequired.names)
featuresRequired.names = gsub('-std', 'Std', featuresRequired.names)
featuresRequired.names <- gsub('[-()]', '', featuresRequired.names)


# Loading  the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresRequired]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
traindata <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresrequired]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testdata <- cbind(test_subjects, test_activities, test)

# merging all the datasets and adding subsequent labels
mergedData <- rbind(traindata, testdata)
colnames(mergedData) <- c("subject", "activity", featuresRequired.names)

# turn activities & subjects into factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)

write.table(mergedData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
