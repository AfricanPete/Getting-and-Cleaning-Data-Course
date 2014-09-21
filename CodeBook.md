
#Code Book - Information about variables 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# Study Design - How the data was collected.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

 The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


Source Data can be located:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip





#Transformations 
Download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Extract getdata-projectfiles-UCI HAR Dataset.zip to R studio into working data directory.
###1 Merges the training and the test sets to create one data set
Set working directory based on working data directory, using : setwd() 

Check that R Studio working directory and working directory is aligned, using: getwd()
 
Set working directory based on downloaded files

Read the files into data frames for activity_labels.txt,features.txt,subject_train.txt,X_train.txt,y_train.txt,subject_test.txt,X_test.txt,y_test.txt

Format the variables: Required for column selection

Subset features.txt into each training data set (test and train) and check results

Subset descriptive variables

Join all training data, merging columns 

Join all test data, merging columns

Create single data set, merging rows

###2- Extracts only the measurements on the mean and standard deviation for each.
On the final data set use sub setting with pattern matching to remove any columns that do not have std and mean in the variable string. Include subject and activity keys for subject and label sets 

###3- Uses descriptive activity names to name the activities in the data set
Merge the activity data frame created earlier with the filtered dataset from the second step, named extractData.
The new data frame is named FinalDataMerged.

###4- Appropriately label the data set with descriptive variable names
Replace:  
"mean" with "Mean"	   
"std" with "StdDev"  
"t" with "time"  
"f" with "freq"  
"_, ()" with ""  

###5- Create tidy data set
