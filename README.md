Original Data Notes below Kat's Analysis
======

Kat's Analysis:
======
---Reading the Dataset

~ set working directory to folder with Samsung Dataset	
	ex: C:\Users\sneakekat\Desktop\Data Science Toolkit\GettingCleaningData\Week4\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset
	

--Why is it a Tidy data?

~ Intertial Signals Ommitted for BOTH sets, because they did not have mean() or std() values needed for analysis
~ Final Data describes:
	a) activity descriptor (walking, walking upstairs, etc) # originally was coded by number
	b) subject (denoted by a number)
	c) variables with descriptors that only represent mean() or std() (ex,fBodyBodyGyroJerkMag-std() all 81 metrics recorded per subject, per activity)
			*** there is a question as to whether meanfreq() should be included, since I do not know the application of the data, I kept it
	d) complete data (not sorted by group or mean) is 10299 X 81
			*** this sums to the rows of test data(2947) + train data(7352)
			*** 81 indicates 2 descriptive columns + 79 measurements 


~Cleaned up in two parts (first Test, then Training Data)
	A) test data read into R  (dimensions 2947 X 561)
	B) features (column names) 561 rows read into R
		***This variable was also used for Training Data
	C) Features added as Test Data Column Titles
	D) Activity labels (6 X 1) loaded into R, (activity_labels.txt)
		***This variable was used for Training Data
	E) Activity Test Data (y_test.txt) was loaded , dim of (2947 X 1) 
	F) Activity labels were matched with Test Activity Data (y_test.txt)
	G) Activity labels were added as a column to test data, make Test Data dims (2947 X 562)
	H) Subject data loaded, dim (2947 X 1)
	I) Subject data added as column to Test Data (dim 2947 X 563)
	J) Subsetted data with column names including "mean", "std", dim(2947 X 81)

*** K) Completed Steps A-J for Training Data, except Training Data has Dims of 7352 X 561
	- Activity Train Data has dims of 7352 X 1 (y_train.txt)
	- Subject data has dims of 7352 X1 (subject_train.txt)
	L) Merged complete Trainng Data with Test Data with total dims of (10299 X 81)


~ Sorting Data by Subject and Activity Level to give Mean for each
	A) Data was melted by subject number and activity, variables were descriptor measurements such as "fBodyBodyGyroJerkMag-std()"
	B) Data was dcast to create a dataset 180 X 81

Reading the Dataset
=====

write.table(dcastTest, "groupedData.txt", row.name=FALSE)


ORIGINAL READ ME FILE PROVIDED BY OWNERS OF DATA IS BELOW
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset included the following files:
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


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
