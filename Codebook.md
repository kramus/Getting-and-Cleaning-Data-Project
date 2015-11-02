# Codebook for Getting and Cleaning Data Course Project
Mark Machin  
October 24, 2015  


## Project Description
This project takes a raw data file from a Human Activity Recognition Using Smartphones study and convert it into a tidy data.


##Study design and data processing

###Collection of the raw data
The raw data was downloaded  [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##Creating the tidy datafile

###Guide to create the tidy data file

We used the data from the link above in order to create the tidy data file, For more detailed information about the proccess of creation of the tidy dataframe please read [README file in this repository.](https://github.com/kramus/Getting-and-Cleaning-Data-Project/blob/master/README.md)

##Description of the variables in the tidy_data.txt file
This file includes 68 variables that were substracted from a raw file of 561 variables. The tidy dataframe contains only the variables in which the mean or standard deviation were calculated. The final product contains the mean of all variables grouped by person and type of activity. For a more detailed explanation please read [README file.](https://github.com/kramus/Getting-and-Cleaning-Data-Project/blob/master/README.md)



###Detailed description

#### Variable 1: id
- Description: Unique person identifier
- Class: *integer*
- Range:  1 to 30

#### Variable 2: activity
- Description: Type of activity employed by the person
- Class: *factor*
- Levels:  6 levels: 1 = LAYING, 2 = SITTING, 3 = STANDING, 4 = WALKING, 5 = WALKING_DOWNSTAIRS, 6 = WALKING_UPSTAIRS

####
#### Variables 3 to 68 have the same structure:

```
##       [,1]                                        
##  [1,] "timeBodyAccelerometerMeanX"                
##  [2,] "timeBodyAccelerometerMeanY"                
##  [3,] "timeBodyAccelerometerMeanZ"                
##  [4,] "timeGravityAccelerometerMeanX"             
##  [5,] "timeGravityAccelerometerMeanY"             
##  [6,] "timeGravityAccelerometerMeanZ"             
##  [7,] "timeBodyAccelerometerJerkMeanX"            
##  [8,] "timeBodyAccelerometerJerkMeanY"            
##  [9,] "timeBodyAccelerometerJerkMeanZ"            
## [10,] "timeBodyGyroscopeMeanX"                    
## [11,] "timeBodyGyroscopeMeanY"                    
## [12,] "timeBodyGyroscopeMeanZ"                    
## [13,] "timeBodyGyroscopeJerkMeanX"                
## [14,] "timeBodyGyroscopeJerkMeanY"                
## [15,] "timeBodyGyroscopeJerkMeanZ"                
## [16,] "timeBodyAccelerometerMagnitudMean"         
## [17,] "timeGravityAccelerometerMagnitudMean"      
## [18,] "timeBodyAccelerometerJerkMagnitudMean"     
## [19,] "timeBodyGyroscopeMagnitudMean"             
## [20,] "timeBodyGyroscopeJerkMagnitudMean"         
## [21,] "frequencyBodyAccelerometerMeanX"           
## [22,] "frequencyBodyAccelerometerMeanY"           
## [23,] "frequencyBodyAccelerometerMeanZ"           
## [24,] "frequencyBodyAccelerometerJerkMeanX"       
## [25,] "frequencyBodyAccelerometerJerkMeanY"       
## [26,] "frequencyBodyAccelerometerJerkMeanZ"       
## [27,] "frequencyBodyGyroscopeMeanX"               
## [28,] "frequencyBodyGyroscopeMeanY"               
## [29,] "frequencyBodyGyroscopeMeanZ"               
## [30,] "frequencyBodyAccelerometerMagnitudMean"    
## [31,] "frequencyBodyAccelerometerJerkMagnitudMean"
## [32,] "frequencyBodyGyroscopeMagnitudMean"        
## [33,] "frequencyBodyGyroscopeJerkMagnitudMean"    
## [34,] "timeBodyAccelerometerStdX"                 
## [35,] "timeBodyAccelerometerStdY"                 
## [36,] "timeBodyAccelerometerStdZ"                 
## [37,] "timeGravityAccelerometerStdX"              
## [38,] "timeGravityAccelerometerStdY"              
## [39,] "timeGravityAccelerometerStdZ"              
## [40,] "timeBodyAccelerometerJerkStdX"             
## [41,] "timeBodyAccelerometerJerkStdY"             
## [42,] "timeBodyAccelerometerJerkStdZ"             
## [43,] "timeBodyGyroscopeStdX"                     
## [44,] "timeBodyGyroscopeStdY"                     
## [45,] "timeBodyGyroscopeStdZ"                     
## [46,] "timeBodyGyroscopeJerkStdX"                 
## [47,] "timeBodyGyroscopeJerkStdY"                 
## [48,] "timeBodyGyroscopeJerkStdZ"                 
## [49,] "timeBodyAccelerometerMagnitudStd"          
## [50,] "timeGravityAccelerometerMagnitudStd"       
## [51,] "timeBodyAccelerometerJerkMagnitudStd"      
## [52,] "timeBodyGyroscopeMagnitudStd"              
## [53,] "timeBodyGyroscopeJerkMagnitudStd"          
## [54,] "frequencyBodyAccelerometerStdX"            
## [55,] "frequencyBodyAccelerometerStdY"            
## [56,] "frequencyBodyAccelerometerStdZ"            
## [57,] "frequencyBodyAccelerometerJerkStdX"        
## [58,] "frequencyBodyAccelerometerJerkStdY"        
## [59,] "frequencyBodyAccelerometerJerkStdZ"        
## [60,] "frequencyBodyGyroscopeStdX"                
## [61,] "frequencyBodyGyroscopeStdY"                
## [62,] "frequencyBodyGyroscopeStdZ"                
## [63,] "frequencyBodyAccelerometerMagnitudStd"     
## [64,] "frequencyBodyAccelerometerJerkMagnitudStd" 
## [65,] "frequencyBodyGyroscopeMagnitudStd"         
## [66,] "frequencyBodyGyroscopeJerkMagnitudStd"
```
- Description: Measures collected from two type of sensors: accelerometer and gyroscope. These sensors have two components: gravitational and body motion components (X, Y, Z for each component). They represent either mean or standard deviation of time or frequency.
- Class: *numeric*
- Range:  -1 to 1
- Calculation: These variables were calculated using `summarise_each` R command. We took the mean of the variables by groups (id and activity). 

##Sources
The website of the study is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

****
###Access to tidy Data
If you want to access the tidy data, please use the following code in R:
```
fileurl <- "https://s3.amazonaws.com/coursera-uploads/user-3fac6b6aeb72fd55d9a46f0c/975117/asst-3/2697c5207a6e11e5ae9e2b7830052642.txt"
fileurl <- sub("^https", "http", fileurl)
tidydata <- read.table(url(fileurl), header = TRUE)
View(tidydata)
```

****
