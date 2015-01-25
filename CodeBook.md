
# Code Book for run_analysis.R

## Processing tidy data set from original raw data

### Inital constants

1. DIRECTORY_DATA_SET - local directory where to save zip files, data sets and results
2. UCI_HAR_Dataset - local directory for loaded original data sets 

### Load data into data.frame's
```R
features  
activities 

subjectTrains  
dataSetTrains 
labelTrains

subjectTest
dataSetTest
labelTest

```

```R
features <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "features.txt", sep = "/"), header = FALSE)

activities <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "activity_labels.txt", sep = "/"), header = FALSE, col.names = c("activity", "activity.name"))

subjectTrains <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "subject_train.txt", sep = "/"), header = FALSE)
dataSetTrains <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "X_train.txt", sep = "/"), header = FALSE)
labelTrains   <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "y_train.txt", sep = "/"), header = FALSE)

subjectTest <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "subject_test.txt", sep = "/"), header = FALSE)
dataSetTest <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "X_test.txt", sep = "/"), header = FALSE)
labelTest   <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "y_test.txt", sep = "/"), header = FALSE)
```

### 1. Merges the training and the test sets to create one data set.
Results in **mergedDataSet** variable

```R
> ncol(mergedDataSet)
[1] 563
> nrow(mergedDataSet)
[1] 10299
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Results in **meanAndStdData** - subselected only mean and standard deviation (std)
 
```R
> names(meanAndStdData)
 [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"              
 [4] "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
 [7] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"           
[10] "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
[13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"          
[16] "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
[19] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"             
[22] "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
[25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"         
[28] "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
[31] "tBodyAccMag-mean()"              "tBodyAccMag-std()"               "tGravityAccMag-mean()"          
[34] "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
[37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"        
[40] "tBodyGyroJerkMag-std()"          "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
[43] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"                "fBodyAcc-std()-Y"               
[46] "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
[49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"          
[52] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
[55] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"      
[58] "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
[61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"              
[64] "fBodyGyro-std()-Z"               "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
[67] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"              "fBodyAccMag-std()"              
[70] "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
[73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"         
[76] "fBodyBodyGyroMag-meanFreq()"     "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
[79] "fBodyBodyGyroJerkMag-meanFreq()"
```
 
### 3. Uses descriptive activity names to name the activities in the data set
Results in **tidyData**

```R
> head(tidyData[, c(1,82,2:4)], n=4)
  activity activity.name tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1        5      STANDING         0.2885845       -0.02029417        -0.1329051
2        5      STANDING         0.2784188       -0.01641057        -0.1235202
3        5      STANDING         0.2796531       -0.01946716        -0.1134617
4        5      STANDING         0.2791739       -0.02620065        -0.1232826
```

### 4. Appropriately labels the data set with descriptive variable names.
Replace short names according to pattern - and assign to **tidyData**
```R
"t" -> "time"
"f" -> "frequency"
"Acc" -> "Accelerometer"
"Freq" -> "Frequency"
"Gyro" -> "Gyroscope"
"Mag" -> "Magnitude"
"BodyBody" -> "Body"
```

```R
> head(tidyData[, c(1,82,2:4)], n=4)
  activity activity.name timeBodyAccelerometer-mean()-X timeBodyAccelerometer-mean()-Y timeBodyAccelerometer-mean()-Z
1        5      STANDING                      0.2885845                    -0.02029417                     -0.1329051
2        5      STANDING                      0.2784188                    -0.01641057                     -0.1235202
3        5      STANDING                      0.2796531                    -0.01946716                     -0.1134617
4        5      STANDING                      0.2791739                    -0.02620065                     -0.1232826
```

### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Results in **tidyDataAverage**


### Write results into two files
Files **tidyData.txt** and **tidyDataAverage.txt** inside a DIRECTORY_DATA_SET variable

```R
> list.files(path = paste(".", DIRECTORY_DATA_SET, sep = "/" ))
[1] "tidyData.txt"        "tidyDataAverage.txt" "UCI HAR Dataset" 
```


## Introduction for data set information - Human Activity Recognition Using Smartphones Data Set

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.


### Data Set Information:

Data Set Characteristics: Multivariate, Time-Series
Attribute Characteristics: N/A
Associated Tasks: Classification, Clustering
Number of Instances: 10299
Number of Attributes: 561
Missing Values? N/A

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


### Attribute Information

For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

