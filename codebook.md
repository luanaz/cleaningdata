This code book describes the variables, the data and transformations from run_analysis.R.

##DATA SOURCE

The data set is from the course website representing data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data is mainly seperated into two parts, train data(in the "train" folder) and test data(in the "test" folder). 

In folder train, three files are concidered as the data source
* X_train.txt - contains the records that subjects act for every activity and every features(i.e. measurements)
* Y_train.txt - indicates the activities of records
* subject_train.txt - indicates the subjects of records

Similarily, in folder test, three files are used to obtain data
* X_test.txt - contains the records that subjects act for every activity and every features(i.e. measurements)
* Y_test.txt - indicates the activities of records
* subject_test.txt - indicates the subjects of records

Besides, two files are adopted to obtain information.
* features.txt - includes features' titles, which are integrated as column names for data in X_train.txt and X_test.txt.
* activity_labels.txt - indicates the association between activity names and numbers from Y_train.txt and Y_test.txt.

##VARIABLES

There are 5 data set are created respectively for the 5 main steps. They are data_merged, data_mean_std, data_activity_names, data_labels and data_tidy.

All of them contain 3 kinds of variables. The first is column "subjects", the second is column "activities" and the third are columns of features. Features are used as variables, such as "tBodyAcc-mean()-X" and "tGravityAcc-std()". 

##DATA AND TRANSFORMATION

The followings are used in run_analysis.R. The sequence is arranged according to the first appearance.

###subject_train
* data.frame: 7352 obs. of  1 variable
* 1st column(subjects): int, subject numbers from "subject_train.txt"
	
###X_train
* data.frame: 7352 obs. of  561 variables
* 1st - 561st columns: num, data from "X_train.txt"
* note: column names are from the variable features

###Y_train
* data.frame: 7352 obs. of  1 variable
* 1st column(activities): activity numbers from "Y_train.txt"

###data_train
* data.frame: 7352 obs. of  563 variables
* 1st column(subjects): int, subject numbers
* 2nd column(activities): int, activity numbers
* 3rd - 563rd columns: num, measurement data
* note: combination of subject_train, X_train and Y_train

###subject_test
* data.frame: 2947 obs. of  1 variable
* 1st column(subjects): int, subjects from "subject_test.txt"
	
###X_test
* data.frame: 2947 obs. of  561 variables
* 1st - 561st columns: num, data from "X_test.txt"
* note: column names are from the variable features

###Y_test
* data.frame: 2947 obs. of  1 variable
* 1st column(activities): activity numbers from "Y_test.txt"

###data_test
* data.frame: 2947 obs. of  563 variables
* 1st column(subjects): int, subject numbers
* 2nd column(activities): int, activity numbers
* 3rd - 563rd columns: num, measurement data
* note: combination of subject_test, X_test and Y_test

###data_merged
* data.frame: 10299 obs. of  563 variables
* 1st column(subjects): int, subject numbers
* 2nd column(activities): int, activity numbers
* 3rd - 563rd columns: num, measurement data
* note: combination of data_train and data_test

###features
* data.frame: 561 obs. of  2 variables
* 1st column: int, ordinal
* 2nd column: chr, feature names from "features.txt"

###col_mean 
* int [1:33]
* note: position numbers indicate item whose name includes "mean()" in the second column of the features

###data_mean
* data.frame: 10299 obs. of  33 variables
* 1st - 33rd columns: num, measurement data
* note: selecting columns from data_merged by col_mean

###col_std
* int [1:33]
* note: position numbers indicate item whose name includes "std()" in the second column of the features

###data_std
* data.frame: 10299 obs. of  33 variables
* 1st - 33rd columns: num, measurement data
* note: selecting columns from data_merged by col_std

###data_mean_std
* data.frame: 10299 obs. of  68 variables
* 1st column(subjects): int, subject numbers
* 2nd column(activities): int, activity numbers
* 3rd - 68th columns: num, measurement data
* note: combination of data_mean and data_std

###activity_labels
* data.frame: 6 obs. of  2 variables
* 1st column(activities): int, activity numbers
* 2nd column(activity_names): chr, activity names
* note: from the file activity_labels.txt

###data_activity_names
* data.frame: 10299 obs. of  68 variables
* 1st column(subjects): int, subject numbers
* 2nd - 67th columns: num, measurement data
* 68th column(activity_names): chr, activity names
* note: merging data_mean_std and activity_labels to obtain a data set with descriptive activity names

###data_labels
* data.frame: 10299 obs. of  68 variables
* 1st column(subjects): Factor w/ 30 levels, subject numbers
* 2nd column(activities): Factor w/ 6 levels, activities
* 3rd - 68th column(features, i.e. measurements): num, measurement data for this activity
* note: labelling and re-arranging variables in the data set of data_activity_names

###data_tidy
* data.frame: 180 obs. of  68 variables
* 1st column(subjects): Factor w/ 30 levels, subject numbers
* 2nd column(activities): Factor w/ 6 levels, activities
* 3rd - 68th column(features, i.e. measurements): num, measurement data for this activity
* note: by using the previous result, data_labels, a tidy data set with the average of each variable for each activity and each subject is created