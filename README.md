# GettingAndCleaningData
This R code creates a tidy data set from the data collected as part of an experiment in human activity recognition using smartphone 
(Samsung Galaxy S II to be exact)
There were 30 participants/volunteers (referred to as subjects in the dataset) in the experiment
Each one participated in 6 different activities - walking, walking upstairs, walking downstairs,sitting, standing, laying)
The data set captured 3 -axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz using the embedded 
accelerometer and gyroscope of the smartphoes
Details about the experiment is contained here : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
As part of the experiment, volunteers were splitted randomly into two groups - train (70%) and test (30%)
For the purpose of creating the tidy data set, one has to deal with 3 different data sets- one for each of the training and test samples
The first is the feature vector (a data set containing measurements on 561 different features collected during the experiment)
The features_info file identifies the names of each of these features
The second is the subjects file 
The third is the activity file
The activity label file helps identify which activity (walking, standing etc.) is identified by which activity id or number
The goal of the tidy data set is to create one file/table/dataframe/dataset (pick your favotite!) that identifies the 
columns/fields/variables in the data from the features info and identifies each row as belonging to a particular volunteer or subject_id
and a particular activity combination
A typical record in this tidy data set would thus represent the following information (just an illustrative example)
Volunteer id = 3, activity = 1 (walking), measurements on each of the 561 different features captured by the accelerometer/gyroscope etc.
The second part of the data set is to extract only the measurements on mean and std.deviation of each of the features (around 79 of them)
The final tidy data set would be to calculate for each subject/volunteer and for each activity type, the average/mean of all the measurements
For the last analysis, melt and dcast funcions in the reshape2 library was used
