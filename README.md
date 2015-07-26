The script in this project does the following:

1.  Downloads and unzips the data, reads in the activity labels and features
2.  IDs and then subsets only the mean and standard deviation variables
3.  Creates data frames for the training and test sets and then merges them to create a joined data set.
4.  Identifys and extracts only the measurements on the mean and standard deviation for each measurement. 
5.  Uses descriptive activity names to name the activities in the data set
6.  Appropriately labels the data set with descriptive variable names. 
7.  melts the data wrt subject and activity and recasts it so that the mean of each variable for each subject-activity combination is calculated
8.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
