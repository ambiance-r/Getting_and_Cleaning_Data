# Getting and Cleaning Data - Assignment: CodeBook
## General Information
- This file describes the variables, the data, and any transformations or work that you performed to clean up the data
- The dataset used in this assignment comes from the paper Anguita et.al. (2012):
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
- The R script uses the dplyr package. Therefore, before running the R script, one should be make sure that the package is installed (if not already installed).

## Steps Followed in the R script
- The analyses in the R script run_analysis.R loads the two data sets in the files X_train.txt (from the folder Data\train) and X_test.txt (from the folder  Data\test) as data frames named X_train (with 7352 rows and 561 columns) and X_test (with 2947 rows and 561 columns). It then vertically merges the training and the test sets to create one data frame named Xall. (Note that the name of the file “UCI HAR Dataset” which includes the data folders “test” and “train” have been changed to “Data” on my local drive to make the related line of code a bit shorter.)
- Each of the 561 columns in this new data frame (just like in X_train and X_test data frames) corresponds to one of the features in the features.txt file. [*The features selected for this dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These signals were used to estimate variables of the feature vector for each pattern such as mean (mean()), standard deviation (std()), median absolute deviation (mad()), etc.* The complete list of variables of each feature vector can be found in 'features.txt' file and detailed information on the study and the variables are in the README.txt and features_info.txt files in the Data folder.]
- Each row in Xall corresponds to an attempt for a particular activity (listed in y_train.txt  and y_test.txt files, which are in Data\train and Data\test folders, respectively, and labelled in activity_labels.txt file, which is in folder Data) by a particular subject (listed in subject_train.txt and subject_test.txt files in the folders Data\train and Data\test). The values of the features by each subject for a particular activity, which are listed in features.txt file (such as mean, std., median, etc.), are calculated over these various attempts.
- The 561 features in the features.txt file are loaded to R as a data frame called features. Then (by using a for loop) each of the feature names is assigned to a column of the Xall data frame.
- After this, only the columns of the Xall data frame related to the mean and standard deviation for each measurement (i.e. only the columns with expressions "mean()" (but not meanFreq()) and "std()") are extracted and the new data frame is called Xallmeanstd. The new data frame now has the following 66 features (out of 561 features):
 "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
 "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
 "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
 "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
 "tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
 "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
 "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
 "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
 "tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
 "tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
 "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
 "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
 "tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
 "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"           
 "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
 "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
 "fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
 "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"          
 "fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
 "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
 "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"

- The training (from subject_train.txt file) and test (from subject_test.txt file) subject lists corresponding to all the 30 subjects (subjects with ID 1 to 30) performing the activities in this study are loaded to R as data frames named subject_test and subject_train. Then, they are merged vertically and the resulting data frame is named subject. Similarly, the training (from y_train.txt file) and test (from y_test.txt file) activity lists corresponding to all the 6 activities included in this study are loaded to R as data frames named activity_train and activity_test. Then, they are merged vertically and the resulting data frame is named activity.
- Using the six descriptive activity names (provided in the activity_labels.txt file), the activities in the activity data frame, which range from 1 to 6, are named. The activity names are as follows: 1=walking, 2=walking_upstairs, 3=walking_downstairs, 4=sitting, 5=standing, 6=laying.
- Then, the subject and activity data frames are merged horizontally with the data set named Xallmeanstd (with only mean and std features). The new dataset is called X. The subject and activity columns are renamed as "Subject" and "Activity". There are 66 (for each feature selected)+ 1 (for subject) + 1 (for activity) = 68 columns in this new data frame, X.
- From the data set X, a second, independent tidy data set, X_tidywide, is created with the average of each variable for each activity and each subject. Each row corresponds to a subject & activity pair (therefore, there are 30 x 6 = 180 rows) while each column corresponds to the mean of a feature (a mean or std) over several attempts for an activity by a subject (68 columns). The data is then saved as a .txt file named X_tidywide.txt, which has been uploaded to this Github repository.
