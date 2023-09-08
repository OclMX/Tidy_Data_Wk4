# Week 4 Tidy Data Codebook

Prepared by: Ozzie 

## Background
Wearable computing is very popular amongst data science professionals
at the time the lesson was published on Coursera.

As a student, one must understand the dataset, download it, reshape it 
into a tidy dataset, and apply simple analytics. 

In this codebook you will find the entities provided by 
Human Activity Recognition Using Smartphones on December 9th, 2012.

### Per the web site the data was collected as follows:
Human Activity Recognition database built from the recordings of 30 subjects 
performing activities of daily living (ADL) while carrying a waist-mounted 
smartphone with embedded inertial sensors.

#### Additional Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Tidy Process
See the input section for the list of files and their description. 

0) The data is downloaded and loaded into data frames.
1) The training and test data sets are first combined.
  a) subjects, x axis, and y axis test data sets are merged using cbind.
  b) subjects, x axis, and y axis train data sets are merged using cbind.
  c) both the test and train data sets are merged to form one data set.
  d) column names are applied using the data from the features file.
2) The activity codes are replaced with descriptive names using factoring. 
3) Only columns/variables that contain standard deviation and means measures, 
   along with the subject and activity, are kept. All others are discard by 
   only grepping for sbj, activity, mean, and std in column names.
4) Variables/columns names that contain abbreviations are the tidy'ed 
   providing the full word. e.g. Mag becomes Magnitude.
5) Finally the tidy data set is produced with the 
   average of each variable for each activity and each subject.
   The dplyr package was leveraged here to simplify the melting process.
    a) This last data frame is then written to disk with the 
       file name tidyData.txt
       

## Inputs From the Author's ReadMe File
### For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


### The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


### Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws


### License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.


