The project is an assignment of the Coursera online course - Getting and Cleaning Data.


##Files in the Project

* README.md - the file you are reading right now
* run_analysis.R - R code to get tidy data as requirement
* codebook.md - code book describing the variables, the data, and transformations


##Data Source

The data set is from the course website representing data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


##Introduction to the Main function

One R script called run_analysis.R has been created to obtain clean and tidy data. The major steps by R code as follows.

###1.Merges the training and the test sets to create one data set.

The goal of the step is to merge the data. The original data is mainly seperated into two parts, train data(in the "train" folder) and test data(in the "test" folder). This step combines them into one data set. In addition, subjects("subject_train.txt" and "subject_test.txt") and activities(in "Y_train.txt" and "Y_test.txt") are added respectively.

The data set named "data_merged" is created with columns "subjects", "activities" and features(i.e. measurements).

###2.Extracts only the measurements on the mean and standard deviation for each measurement. 

Features(in "features.txt") are input and utilized in this step. Measurements(columns in "data_merged") whose title contains "mean()" or "std()" are selected. For example, "tBodyAcc-mean()-X" will be chosen while "fBodyAcc-meanFreq()-X" will not.

The data set "data_mean_std" is the output of the step, with columns "subjects", "activities" and features.

###3.Uses descriptive activity names to name the activities in the data set.

In the stage, descriptive activity names are obtained from "activity_labels.txt", in order to replace activity number in "data_mean_std".

This step gets the data set "data_activity_names" with columns "subjects", "activities" and features. "activities" is the last column.

###4.Appropriately labels the data set with descriptive variable names. 

The step creates a data set named "data_labels", which re-arranges the column order in "data_activity_name" and labels the variable names.

###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Function "aggreagate" is adopted to figure out the mean for every subject on their own activities.

The data set "data_tidy" comes out at the end. It is a 180 * 68 data frame.

The result, "data_tidy" is written in "data_tidy.txt".