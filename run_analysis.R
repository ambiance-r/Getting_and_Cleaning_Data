# Getting and Cleaning Data - Week 4 - Programming Assignment:

## Set working directory:
setwd("C:/Users/user/Desktop/week4assignment")

## Load the training (from X_train.txt file) and test (from X_test.txt file) data:
X_train <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\train\\X_train.txt",header=F,sep="", dec = ".")
X_test <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\test\\X_test.txt",header=F,sep="", dec = ".")

## 1.	Merge the training and the test sets to create one data set. Each of the 561 columns
## in this new data set corresponds to a feature in the features.txt file. Each row corresponds 
## to an attempt for a particular activity (listed in y_train.txt  and y_test.txt files and 
## labelled in activity_labels.txt file) by a particular subject (listed in subject_train.txt 
## and subject_test.txt files).
Xall <- rbind(X_train, X_test)

## Load the features list from the features.txt file:
features <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\features.txt",header=F,sep="", dec = ".")
features <- as.vector(features[,2])  # select the second column which gives the feature names

## Assign the feature names to columns of the merged dataset: 
for (i in 1:561){
  names(Xall)[i] <- features[i]
}

## 2.	Extract only the measurements on the mean and standard deviation for each measurement,
## i.e. extract only the columns with expressions "mean()" (but not meanFreq()) and "std()".
## This results in a new data frame with only 66 features.
Xallmeanstd <- Xall[ ,grepl("mean|std", names(Xall)) & !grepl("meanFreq", names(Xall))]
## head(Xallmeanstd)

## Load the training (from subject_train.txt file) and test (from subject_test.txt file) subject
## lists corresponding to all the 30 subjects included in this study. Then, merge them:
subject_train <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\train\\subject_train.txt",header=F,sep="", dec = ".")
subject_test <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\test\\subject_test.txt",header=F,sep="", dec = ".")
subject <- rbind(subject_train, subject_test)

## Load the training (from y_train.txt file) and test (from y_test.txt file) activity
## lists corresponding to all the 6 activities included in this study. Then, merge them:
activity_train <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\train\\y_train.txt",header=F,sep="", dec = ".")
activity_test <- read.table("C:\\Users\\user\\Desktop\\week4assignment\\Data\\test\\y_test.txt",header=F,sep="", dec = ".")
activity <- rbind(activity_train, activity_test)

## 3.	Use the six descriptive activity names (provided in the activity_labels.txt file) to name 
## the activities 1 to 6 in the data set:
activity$V1 <- factor(activity$V1, levels = c(1,2,3,4,5,6), labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))

## Merge the subject and activity data frames with the merged data set named Xallmeanstd (with only mean and std features):
## The new dataset is named X. Then, name the subject and activity columns as "Subject" and "Activity":
X <- cbind(subject, activity, Xallmeanstd)
names(X)[1] <- "Subject"
names(X)[2] <- "Activity"

## 4.	Appropriately labels the data set with descriptive variable names.
# Please see above (the for loop).

## 5.	From the data set in step 4, X, create a second, independent tidy data set, X_tidywide, 
## with the average of each variable for each activity and each subject.Each row corresponds to
## a subject & activity pair (therefore, there are 30 x 6 = 180 rows) while each column
## corresponds to the mean of a feature (a mean or std) over several attempts for an activity
## by a subject (therefore there are 66 (for each feature selected above)+ 1 (for subject) + 1 (for activity) = 68 columns).
## Then, save the data set as a .csv file.

## install.packages("dplyr")   # to install the dplyr package for the first time
library(dplyr)
X_tidywide <- X %>% group_by(Subject, Activity) %>% summarise_all(mean)
write.table(X_tidywide, file = "X_tidywide.txt", sep = "\t", row.name=FALSE)
