# README
## Summary
- This repository contains;
* an R script run_analysis.R to process the UCI Human Activity Recognition data set, which can be downloaded from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* CodeBook.md file that describes the variables, the data, and any transformations or work that has been performed to clean up the data
* README.md file that describes the project.
- Some more details about the data and the variables can be found in the README.txt and features_info.txt files in the folder found on the above link.
- Note that the name of the data folder “UCI HAR Dataset” which includes the data subfolders “test” and “train” used in the analyses have been changed to “Data” on my local drive to make the related line of code a bit shorter. Additionally, in order to run the code, the working directory needs to be adjusted according to the R script run_analysis.R.

## Steps Followed Throughout the Analysis
- run_analysis.R script uses the X_train.txt (training set) and X_test.txt (test set) files in the folders Data\train and Data\test and horizontally merges them into one data frame named Xall. 
- The columns are renamed with each column name corresponding to one of the features listed in the features.txt file. 
- This data frame is then cleaned by keeping only the columns representing the features that we are interested in, namely mean() and std() related features. This decreases the column numbers from 561 (number of all the features in the features.txt file) to 66. The new data frame is named Xallmeanstd.
- Subjects (with ID numbers 1 to 30) in the subject_train.txt and subject_test.txt files are merged into a data frame called subject. Each subject performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. 
- Activity labels (1 to 6) in the y_train.txt (training labels) and y_test.txt (test labels) files are merged vertically into data frame called activity, and then these activities (1 to 6) are linked to the activity names in the activity_labes.txt file.
- subject and activity data frames are then merged horizontally with Xallmeanstd to create the data frame X, with the subject and activity columns named as “Subject” and “Activity”.
- Finally, a tidy data frame named Xtidywide is created: each row corresponds to a subject & activity pair while each column corresponds to the mean of a feature (a mean or std) over several attempts for an activity by a subject. This data set meets the tidy set criteria mentioned in Tidy Data paper by Hadley Wickham.

