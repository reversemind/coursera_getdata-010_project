##########################################################################################
#
# You should create one R script called run_analysis.R that does the following. 
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library(plyr)
library(data.table)


# download & unzip data file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zippedDataFileName <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

# data set directory
DIRECTORY_DATA_SET <- "./DATA_SET"
UCI_HAR_Dataset <- "UCI HAR Dataset"

# if data file is not exist just download it
if (!file.exists(zippedDataFileName)) {
  # method = "curl" - because of the Linux system
  download.file(fileURL, destfile = zippedDataFileName, method = "curl")
  unzip(zippedDataFileName, overwrite = TRUE, exdir = DIRECTORY_DATA_SET)
}


# check ourself
paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, sep = "/")


# load data
features <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "features.txt", sep = "/"), header = FALSE)

activities <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "activity_labels.txt", sep = "/"), header = FALSE, col.names = c("activity", "activity.name"))

subjectTrains <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "subject_train.txt", sep = "/"), header = FALSE)
dataSetTrains <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "X_train.txt", sep = "/"), header = FALSE)
labelTrains   <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "train", "y_train.txt", sep = "/"), header = FALSE)

subjectTest <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "subject_test.txt", sep = "/"), header = FALSE)
dataSetTest <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "X_test.txt", sep = "/"), header = FALSE)
labelTest   <- read.table(paste(DIRECTORY_DATA_SET, UCI_HAR_Dataset, "test", "y_test.txt", sep = "/"), header = FALSE)



################################################################################################
# 1. Merges the training and the test sets to create one data set.

dataSet <- rbind(dataSetTrains, dataSetTest)
labels <- rbind(labelTrains, labelTest)
subject <- rbind(subjectTrains, subjectTest)

mergedDataSet <- cbind(dataSet, labels, subject)



################################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# let's assign names to dataset for simplifying the access process 
# and further usefullness
names(subject) <- c("subject")
names(labels)  <- c("activity")
names(dataSet) <- features$V2

data <- cbind(dataSet, labels, subject)


# subselect only mean and standard deviation (std)
meanAndStdData <- data[,grepl("mean|std", names(data))]
names(meanAndStdData)


################################################################################################
# 3. Uses descriptive activity names to name the activities in the data set

tidyData <- join(data[,grepl("mean|std|activity|subject", names(data))], activities, by = "activity", match = "first")

# see activity.name


################################################################################################
# 4. Appropriately labels the data set with descriptive variable names.

names(tidyData) <- gsub("^t", "time", names(tidyData))
names(tidyData) <- gsub("^f", "frequency", names(tidyData))
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("Freq", "Frequency", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) <- gsub("BodyBody", "Body", names(tidyData))

names(tidyData)



################################################################################################
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyDataAverage <- ddply(tidyData, c("subject","activity"), numcolwise(mean))



################################################################################################
# Write to files

write.table(tidyData, file=paste(DIRECTORY_DATA_SET, "tidyData.txt", sep = "/"), row.names=FALSE)
write.table(tidyDataAverage, file=paste(DIRECTORY_DATA_SET, "tidyDataAverage.txt", sep = "/"), row.names=FALSE)


