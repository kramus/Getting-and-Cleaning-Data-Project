# Getting and Cleaning Data Course Project
Mark Machin  
October 24, 2015  
## Project Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

##Study Design and Data Processing

###Features Description
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

###Collection of the raw data
This project takes the raw data file from a Human Activity Recognition Using Smartphones study and converts it into a tidy data. The raw data was downloaded  [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##Creating the tidy datafile

###A walkthrough the creation of the tidy data file

We used the data from the link above in order to create the tidy data file. The `UCI HAR Dataset` contains a couple of files and folders. The files we are going to be working with are: - activity_labels.txt  (contains the activity labels)
- features.txt  (contains the variables names)
- subject_test.txt  (contains the subject ids for the test files)
- subject_train.txt (contains the subject ids for the train files)
- y_test.txt (contains the activity that correspond to each row in the test file)
- y_train.txt (contains the activity that correspond to each row in the train file)
- X_test.txt (test dataframe)
- X_train.txt (train dataframe)

####Step by Step Process

First we loaded `plyr and dplyr packages`. We then set up our working directory where the `UCI HAR Dataset` file were uncompressed. After that, we loaded our files above mentioned.
We then added the names of the variables using the `colnames() <- labels` R function for both dataframes (*test and train*). We changed the variable name in *subject files* to "id" and binded these files to the respective dataframes using `cbind()` R function. Now that we had the id variable in our main dataframes, we did the same process for the *y files* in order to add the column that gives the appropiate activity taken place in every row. We named that column "activity". After all these steps we proceeded to join or bind our two dataframes using the function `rbind`. 
Our course project required to extract only the columns where the mean and standard deviation were calculated. In order to do that, we needed to eliminate duplicated colnames. We achieved that step by using `data[,!duplicated(colnames(data))]` command. When there were not any duplicated name, we extracted only the columns of interest. We used
`select(data, id, activity, contains("mean()"), contains("std()"))' command to do that. It is **important** to point out that we did not extract columns where the meanFreq were taken because we thought that it was a completely different measure and we only wanted the mean and standard deviation measures. 
Afterwards, we labelled the variable activity using the command `dactivity[match(data$activity, activity$V1), 'V2']` where the `data object` is the main dataframe and `activity object` is the dataframe that contains the labels. After that we changed the variables names to a more descriptive name using `gsub or sub` functions. An example of this process is: `names(data) <- gsub("-","",names(data))`. We repeated this command to change parts of the variable names that we wanted. We ended up with descriptive names like this: **timeBodyAccelerometerMeanX**. 

Now in order to create the tidy dataframe with the correspond mean for all variables, we first order our data using `order()` function and then grouped it using `group_by()` function for the *dplyr package*. The commands were: `dat <- data[order(data$id, data$activity),]` and `dat <- group_by(dat, id, activity)`. Then we calculated the mean for all columns by person id and type of activity using the command: `tidy_data <- dat %>% summarise_each(funs(mean))`. 
Finally we export the tidy data to a text file using `write.table()` function. The final product contains a dataframe with 68 variables and 180 rows. For a detailed information about the variables values and classes, please read [the codebook.](https://github.com/kramus/Getting-and-Cleaning-Data-Project/blob/master/Codebook.md)

##Sources
The website of the study is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

****
###Access to tidy Data
If you want to access the tidy data, please use the following code in R:
```
fileurl <- "https://s3.amazonaws.com/coursera-uploads/user-3fac6b6aeb72fd55d9a46f0c/975117/asst-3/2697c5207a6e11e5ae9e2b7830052642.txt"
fileurl <- sub("^https", "http", fileurl)
tidydata <- read.table(url(fileurl), header = TRUE)
view(tidydata)
```

****
