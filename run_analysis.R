#downloads and unzips the data
fn <- "gettingandcleaningdataproject.zip"

fileURL < "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR”
download.file(fileURL, fn, method="curl")
unzip(fn) 

#reads in the activity labels and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels [,2] <- as.character(activity_labels [,2])
features[,2] <- as.character(features[,2])

#IDs and then subsets only the mean and standard deviation variables
features_meanandstd <- grep("mean|std", features[,2])
features_meanandstd.names <- features[featuresWanted,2]
features_meanandstd.names <- gsub('-mean', 'MEAN',features_meanandstd.names)
features_meanandstd.names <- gsub('-std', 'STD', features_meanandstd.names)
features_meanandstd.names <- gsub('[-()]', '', features_meanandstd.names)

#creates the dataframe for the training subjects
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_results <- read.table("UCI HAR Dataset/train/X_train.txt")[ features_meanandstd]
train_set <- cbind(train_subjects, train_activities, train_results)

#creates the dataframe for the test subjects
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_results <- read.table("UCI HAR Dataset/test/X_test.txt")[ features_meanandstd]
test_set <- cbind(test_subjects, test_activities, test_results)

#combines the training and testing data frames
train_and_test <- rbind(train_set, test_set)
colnames(train_and_test) <- c("Subject", "Activity", features_meanandstd.names)

library(reshape2)

#melts the data wrt subject and activity and recasts it so that the mean of each variable for each subject-activity combination is calculated
train_and_test.melted <- melt(train_and_test, id = c("Subject", "Activity"))
train_and_test.mean <- dcast(train_and_test.melted, Subject + Activity ~ variable, mean)

#changes activity to a factor so that it can be relabeled in the table

train_and_test.mean $Activity <- factor(train_and_test.mean $Activity, levels = activity_labels [,1], labels = activity_labels [,2])
write.table(train_and_test.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
