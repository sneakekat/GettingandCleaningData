library(dplyr)
library(reshape2)

### Read/Clean/Shape Test Data by: 1) Add Features as Titles, 2) Add Activities Labels as Columns 3) Add Subjects as Columns 4)Adding Train/Test Type ***deleted later when sorting 5) Reorder Data

        X_test <- read.table(file="./test/X_test.txt", sep="") #READ X_test file  # drops the last decimal, rounds, only in R console?
        X_testdf <- tbl_df(X_test)  ## converted to tbl_df so easier to sort later

### READ in features, use featuresonly for BOTH data sets    
    features <- read.table(file="features.txt", sep="", stringsAsFactors=FALSE) # cleaned up by changing column names & subsetting
    featuresonly <- features[,2]  # subsets to use ONLY column 2 with feature descriptors
    
        colnames(X_testdf) <-c(featuresonly)## add column names to Test DATA using featuresonly file
        
        testMeanStd <- X_testdf[grepl("mean()|std()", names(X_testdf))]  # subset out the mean & std
        
        Y_testfile <- read.table(file="./test/y_test.txt", sep="")# LOAD IN Y TEST ACTIVITY LABELS, change numbers to activity descriptions
        index <- c(1, 2, 3, 4, 5, 6)
        activities <- c("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying")
        Y_testfile[2] <- activities[match(Y_testfile$V1, index)]    # matches activity numbers to activity descriptors
        test_activities <- Y_testfile[2]  # only uses column 2 with activity names
        colnames(test_activities) <- c("activity")  # change col name to activity (descriptive)

        TestDatLessSubj <- cbind(testMeanStd, test_activities) # bind Test Data To activity data

        subjectsTest <- read.table(file="./test/subject_test.txt", sep="") ## read in subjects for test data
        colnames(subjectsTest) <- c("subject number") # change col names , for future - put NO space between subject & number
        TestCmpData <- cbind(TestDatLessSubj, subjectsTest) # bind subjects to Test dataframe

        testtype <- data.frame(a=1:2947, subjType="test")  # create subject test column to label type of data
        testtype2 <- testtype[2] #subset only "test" label
        TestCmpData <- cbind(TestCmpData, testtype2)  # bind test type with existing merged data

        TestCmpData <- tbl_df(TestCmpData)
        TestCmpData <- select(TestCmpData, 82:1) #reorder so subject type, then #, then activitiy


### Read/Clean/Shape Train Data by: 1) Add Features as Titles, 2) Add Activities Labels as Columns 3) Add Subjects as Columns 4)Adding Train/Test Type ***deleted later when sorting 5) Reorder Data
        
        X_train <- read.table(file="./train/X_train.txt", sep="")
        X_traindf <- tbl_df(X_train)

        colnames(X_traindf) <- c(featuresonly)#featuresonly defined above, added features as column names to data

        trainMeanStd <- X_traindf[grepl("mean()|std()", names(X_traindf))]# pull out mean / STD only ... this includes meanFreq() type values

        Y_trainfile <- read.table(file="./train/y_train.txt", sep="")   # read in train activity labels, change numbers to des, col names& bind to mean.std file
        Y_trainfile[2] <- activities[match(Y_trainfile$V1, index)] #matched numbers to activity descriptors
        train_activities <- Y_trainfile[2] # subset only activity descriptors
        colnames(train_activities) <- c("activity")  # changed col 2 to descriptive "activity"
        TrainDatLessSubj <- cbind(trainMeanStd, train_activities)  #add activity descriptors to exsiting train dataset


        subjectsTrain <- read.table(file="./train/subject_train.txt", sep="") #read in subject values
        colnames(subjectsTrain) <- c("subject number") #add descriptor
        TrainCmpData <- cbind(TrainDatLessSubj, subjectsTrain)  #add subject values to existing train dataset

        traintype <- data.frame(a=1:7352, subjType ="train")  # add in train column descriptor (got rid of this later when sorting for new subset)
        traintype2 <- traintype[2]
        TrainCmpData <- cbind(TrainCmpData, traintype2) #bind train descriptor to exisiting train dataset

        TrainCmpData <- tbl_df(TrainCmpData) # convert to tbl_df (dplyr) reorder columns
        TrainCmpData <- select(TrainCmpData, 82:1) #reorder columns to match test dataset


### merge Train & Test Data Sets
    MergedData <- rbind(TrainCmpData, TestCmpData)


### Create New Tidy Dataset ordered by Subject # & Activity , calculate Mean

    MergedDataWO1 <- MergedData[2:82]   ## gets rid of extra "train" or "test" descriptor created above

    tablemelt <- melt(MergedDataWO1, id=c("subject number", "activity"), measure.vars=colnames(MergedDataWO1[3:81]))  #melts all variables to columns
    
    colnames(tablemelt)[1] <- c("subjectnumber")  # change subject number WITHOUT SPACE to work with dcast below

    GroupedData <- dcast(tablemelt, subjectnumber + activity ~ variable, mean) # Groups Data by subject, activity, calculates mean for each variable

###final tidy dataset    
    print(GroupedData) 
 
