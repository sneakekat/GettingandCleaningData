
1. subjectnumber 
	* indicates subject number given by researchers
	* numbers are 1-30
	* there are multiple measurements for each activity type per subjectnumber
	
2. activity
	* original activity_labels file was coded as below
	* my analysis converts numbers to activity labels, see below
		* 1 WALKING
		* 2 WALKING_UPSTAIRS
		* 3 WALKING_DOWNSTAIRS
		* 4 SITTING
		* 5 STANDING
		* 6 LAYING

3. Variables (measurements) that were kept must contain one of the following:
	* mean(): Mean value
	* std(): Standard deviation
	* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* Examples	
	* gravityMean
	* tBodyAccMean
	* tBodyAccJerkMean
	* tBodyGyroMean
	* tBodyGyroJerkMean

4. runanalysis.R finds the mean of variables grouped by subjectnumber and activity
	* that calculation is indicated by prefix "Mean of"


The complete list of original variables of each feature vector is available in 'features.txt'
