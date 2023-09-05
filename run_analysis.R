library(dplyr)

# This is a simple script using base R functions to tidy up 
# activity reporting per Week 4's assignment instructions. 

# Load the data
#
#----------------------------------------------------------------------------------------------------------

# Download the file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

fileName <- "UCI HAR Dataset.zip"

if (!file.exists(fileName)) {
  download.file(fileURL, fileName, mode = "wb")
}

# unzip zip file if directory doesn't already exist
fileDir <- "UCI HAR Dataset"

if (!file.exists(fileDir)) {
  unzip(fileName)
}

# Let us get the variable names so that we can specify them as column names.
varNames <- read.table(file.path(fileDir, "features.txt"), as.is = TRUE) 

# Let us get the descriptive activity labels. Need the ID column.

actLabel <- (read.table(file.path(fileDir,"activity_labels.txt"),header = FALSE))

colnames(actLabel) <- c('actLabelID','actType')

#tst = test | tr = train

x_tst_data <- read.table(file.path(fileDir, "test", "X_test.txt"),header = FALSE)
X_tr_data <- read.table(file.path(fileDir, "train", "X_train.txt"),header = FALSE)
y_tst_data <- read.table(file.path(fileDir, "test", "y_test.txt"),header = FALSE)
y_tr_data <- read.table(file.path(fileDir, "train", "y_train.txt"),header = FALSE)
sbj_tst <- read.table(file.path(fileDir, "test", "subject_test.txt"),header = FALSE)
sbj_tr <- read.table(file.path(fileDir, "train", "subject_train.txt"),header = FALSE)

# Merging the data sets
#
#------------------------------------------------------------------------------------------------------------

#merge the data into a single table.
allActivity <- rbind(cbind(sbj_tst,x_tst_data,y_tst_data),cbind(sbj_tr,X_tr_data,y_tr_data))

#rm(x_tst_data, X_tr_data, y_tst_data, sbj_tst, sbj_tr)

#assign meaningful column names from the features file
colnames(allActivity) <- c("sbj",varNames[,2],"activity")

# Extract on the mean and standard deviation 
#
#-------------------------------------------------------------------------------------------------------------

#Now that we have column names we can omit those that were are not interested in.
# keep any variable that is a mean or standard deviation
# grep and grepl are not fun to deal with when I omitted the first column in varNames during the read...

colToReport <- grepl("sbj|activity|mean|std", colnames(allActivity))
allActivity <- allActivity[,colToReport]

# Descriptive activity names to name the activities
#
#--------------------------------------------------------------------------------------------------------------

#Categorize the data

allActivity$activity <- factor(allActivity$activity, 
                               levels = actLabel[, 1], labels = actLabel[, 2])

# Label the data with descriptive variable names.
#
#--------------------------------------------------------------------------------------------------------------

# I should have used functions. :)
# Not clear on the instructions. So following discussion posted by Gregory D. Horne 
# and Behfar Bastani response.
# I guess we remove special characters using gsub and expand abbreviations and
# corrent some variable names to tidy the data :)

#  Time to replace somewhat good abbreviations and remove special characters like dash.

colNames <- colnames(allActivity)

colNames <- gsub("\\(\\)-","",colNames)

# we could be build a list of abbrviations, etc. and sapply but I've spent too much time on this

colNames <- gsub("^f", "FrequencyDomain_",colNames)
colNames <- gsub("^t", "TimeDomain_",colNames)
colNames <- gsub("std", "StandardDeviation",colNames)
colNames <- gsub("Gyro", "Gyroscope",colNames)
colNames <- gsub("Freq", "Frequency",colNames)
colNames <- gsub("Acc", "Accelerometer",colNames)
colNames <- gsub("mean", "Mean",colNames)
colNames <- gsub("Mag", "Magnitude",colNames)

# Update column names
colnames(allActivity) <- colNames

# And finally produce a second tidy data set 
# with the average of each variable for each activity and each subject
#
#------------------------------------------------------------------------------------------------------

# Avoiding using the melt functions
# started the group with activity to match the order in the instructions

meanForAllActivity <- allActivity %>% 
  group_by(activity, sbj) %>%
  summarize_all(list(~ mean(., trim = .2)))

setwd(fileDir)

write.table(meanForAllActivity, "tidyData.txt", row.names = FALSE, 
            quote = FALSE)













