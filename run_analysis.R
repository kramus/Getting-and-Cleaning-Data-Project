##Getting and Cleaning Data Project Assigment
#run_analysis R script

#Load packages
library(plyr)
library(dplyr)

#Setting up working directory
getwd()
setwd(".\\UCI HAR Dataset")

#To verify files within my directory
list.files(".\\test")
list.files(".\\train")

##Load files into R

#Files in the main folder:
activity <- read.table(".\\activity_labels.txt")
feature <- read.table(".\\features.txt")

#Files in test folder:
x_test <- read.table(".\\test\\X_test.txt")
sub_test <- read.table(".\\test\\subject_test.txt")
y_test <- read.table(".\\test\\y_test.txt")

#Files in train folder
x_train <- read.table(".\\train\\X_train.txt")
sub_train <- read.table(".\\train\\subject_train.txt")
y_train <- read.table(".\\train\\y_train.txt")

#'First step:
#'Change names of the variables in both datasets (test and 
#'train). This is done by using feature.txt file and applying it to the 
#'variables names:
colnames(x_test) <- feature$V2 
colnames(x_train) <- feature$V2 

#'Second step:
#'Bind subject files into the main datasets.

#Changing name of the variable to "id"
names(sub_test)[1] <- "id"
names(sub_train)[1] <- "id"

#Binding id variable into main datasets
x_test <- cbind(sub_test, x_test)
x_train <- cbind(sub_train, x_train)

#'Third step:
#'Bind activity files (6 type of activities) into the main datasets. 

#Changing name of the variable to "activity"
names(y_test)[1] <- "activity"
names(y_train)[1] <- "activity"

#Binding type_activity variable into main datasets
x_test <- cbind(x_test, y_test)
x_train <- cbind(x_train, y_train)


#'Fouth step:
#'join both dataframes (test and train):

data <- rbind(x_test, x_train)

##Select columns related to mean() and std()
#First step:
#Take a look at the duplicated variables:
dupli <- data[,duplicated(colnames(data))]
names(dupli)

#None of the duplicated variables contain either mean() or std().
#Eliminate duplicated colnames variables:
data <- data[,!duplicated(colnames(data))]

#'Select columns related to either mean or std
data <- select(data, id, activity, contains("mean()"), contains("std()"))

#'Add label to the variable activity 
data$activity <- activity[match(data$activity, activity$V1), 'V2']

#' Change variables names for a more descriptive format.
names(data) <- gsub("-","",names(data))
names(data) <- gsub("\\(\\)","",names(data))
names(data) <- sub("^t", "time", names(data))
names(data) <- sub("^f","frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitud", names(data))
names(data) <- gsub("mean", "Mean", names(data))
names(data) <- gsub("std", "Std", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))


##Creation of the tidy data
dat <- data[order(data$id, data$activity),]
dat <- group_by(dat, id, activity)

#Tidy data with the mean of every variable by id and activity
tidy_data <- dat %>% summarise_each(funs(mean))

#Exporting data to text file.
write.table(tidy_data, file = "..\\tidy_data.txt", row.names = FALSE)
