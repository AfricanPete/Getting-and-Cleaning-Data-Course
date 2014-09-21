#################################################################################################
# SCRIPT:       run_analysis.R                                                                  #
# OBJECTIVES:                                                                                  #
#               1 -Merges the training and the test sets to create one data set.                #
#               2- Extracts only the measurements on the mean and standard deviation for each   #
#                  measurement.                                                                 #
#               3- Uses descriptive activity names to name the activities in the data set       #
#               4- Appropriately label the data set with descriptive variable names.           #
#               5- From the data set in step 4, creates a second, independent tidy data set     #
#                  with the average of each variable for each activity and each subject.        #
#===============================================================================================#

setwd("C:/Couresra/GettingandCleaningData/Data/UCI HAR Dataset")


######## 1 Merges the training and the test sets to create one data set.#########################
#################################################################################################
##Import files into data frames for the descriptive variables
meta_Activity <-read.table("./activity_labels.txt");
meta_Features <-read.table("./features.txt");

##Import files into data frames for the training data 
train_Subject <-read.table("./train/subject_train.txt");
train_Set     <-read.table("./train/X_train.txt");
train_Labels  <-read.table("./train/y_train.txt");

##Import files into data frames for the test data.
test_Subject  <-read.table("./test/subject_test.txt");
test_Set      <-read.table("./test/X_test.txt");
test_Labels   <-read.table("./test/y_test.txt");

#Format Set Data Frames for train and test
variableDescription_Set <- meta_Features$V2
colnames(test_Set)      <- variableDescription_Set
colnames(train_Set)      <- variableDescription_Set

#Format Lables Data Frames for train and test
colnames(test_Labels)  <-"activityName_ID"
colnames(train_Labels) <-"activityName_ID"

#Format Subject Data Frames for train and test
colnames(test_Subject)     <- "subjectName_ID"
colnames(train_Subject)    <- "subjectName_ID"

#Join all training data, merging columns  ?cbind
trainDataFrame <- cbind(train_Subject,train_Set,train_Labels)

#Join all test data, merging columns
testDataFrame <-cbind(test_Subject,test_Set,test_Labels)
        
#Creat single data set, merging rows
mergedDataFrame <-rbind(trainDataFrame,testDataFrame)

######## 2- Extracts only the measurements on the mean and standard deviation for each ##########
#################################################################################################
#Extracts only the measurements on the mean and standard deviation for each   measurement
extractData <-mergedDataFrame[,grep("mean\\(\\)|std\\(\\)|subject|activity",names(mergedDataFrame))]


######## 3- Uses descriptive activity names to name the activities in the data set ##########
#################################################################################################
#Format activity Data Frame, activityDescription is the last column in the data frame
colnames(meta_Activity) <- c("activityName_ID","activityDescription")
FinalDataMerged = merge(extractData,meta_Activity,by='activityName_ID')

######## 4- Appropriately label the data set with descriptive variable names ##########
#################################################################################################
#Clean up variable names
replace4<-gsub("-std$","StdDev", names(FinalDataMerged))
names(FinalDataMerged) <- replace4

replace5<-gsub("-mean","Mean", names(FinalDataMerged))
names(FinalDataMerged) <- replace5

replace1<-gsub("\\(|\\)|-|,", "", names(FinalDataMerged))
names(FinalDataMerged) <- replace1

replace2<-gsub("^(t)","time", names(FinalDataMerged))
names(FinalDataMerged) <- replace2

replace3<-gsub("^(f)","freq", names(FinalDataMerged))
names(FinalDataMerged) <- replace3

######## 5 From the data set in step 4, create a second, independent tidy data set 
########   with the average of each  variable for each activity and each subject.   
#################################################################################################
FinalData  = FinalDataMerged[,names(FinalDataMerged) != "activityDescription"];
aggDataSet <-aggregate(FinalData[,names(FinalData) != c("activityName_ID","subjectName_ID")],by=list(activityName_ID=FinalData$activityName_ID,subjectName_ID = FinalData$subjectName_ID),mean);
independentTidyData  <-merge(aggDataSet,meta_Activity,by='activityName_ID')