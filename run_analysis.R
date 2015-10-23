library(dplyr)
library(tidyr)

#STEP 1: Merges the training and the test sets to create one data set

#Load the train data
subject_train <- read.table("./Dataset/train/subject_train.txt")
X_train <- read.table("./Dataset/train/X_train.txt")
Y_train <- read.table("./Dataset/train/Y_train.txt")
names(subject_train)[names(subject_train) == "V1"] = "subjects"
names(Y_train)[names(Y_train) == "V1"] = "activities"
#Combind subjects and activities into data_train
data_train <- cbind(subject_train, Y_train, X_train) 

#Load the test data
subject_test <- read.table("./Dataset/test/subject_test.txt")
X_test <- read.table("./Dataset/test/X_test.txt")
Y_test <- read.table("./Dataset/test/Y_test.txt")
names(subject_test)[names(subject_test) == "V1"] = "subjects"
names(Y_test)[names(Y_test) == "V1"] = "activities"
#Combind subjects and activities into data_test
data_test <- cbind(subject_test, Y_test, X_test) 

#merge the train data and the test data
data_merged <- rbind(data_train, data_test)

#STEP 2: Extracts only the measurements on 
#the mean and standard deviation for each measurement

#Read features as col.names in X_train and X_test
features <- read.table("./Dataset/features.txt", stringsAsFactors = FALSE)

col_mean <- grep("mean()", features$V2, fixed = TRUE)
data_mean <- data_merged[, col_mean + 2]
col_std <- grep("std()", features$V2, fixed = TRUE)
data_std <- data_merged[, col_std + 2]
data_mean_std <- cbind(data_merged[, c(1, 2)], data_mean, data_std)

#STEP 3: Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./Dataset/activity_labels.txt", stringsAsFactors = FALSE)
names(activity_labels) <- c("activities", "activity_names")
data_activity_names <- select(merge(data_mean_std, activity_labels, by = "activities"),
                              -activities)

#STEP 4: Labels the data set with descriptive variable names
data_labels <- cbind(data_activity_names[, 1], data_activity_names[, 68])
data_labels <- cbind(data_labels, data_activity_names[, 2:67])
names(data_labels)[1:2] <- c("subjects", "activities")
names(data_labels)[3:(length(col_mean) + 2)] <- features$V2[col_mean]
names(data_labels)[(length(col_mean) + 3):ncol(data_activity_names)] <- features$V2[col_std]

#STEP 5: Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject
data_tidy <- aggregate(data_labels[, 3:ncol(data_labels)],
                       by = list(activities = data_labels$activities, 
                                 subjects = data_labels$subjects),
                       FUN = mean, na.rm = TRUE)

#Create a txt file containing the data set in step 5
write.table(data_tidy, "data_tidy.txt", row.names = FALSE)
