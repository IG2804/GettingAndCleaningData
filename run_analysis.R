
#Load the files with 561 features for both train and test samples

train <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')
test <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')

#Load the files with the subject/volunteer id for both train and test samples

sub_train <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')
sub_test <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')

#Load the files with the activity id for each volunteer for both train and test samples


activity_train <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')
activity_test <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",header = FALSE, row.names = NULL, quote=NULL, comment='')
  

# Name the activity and subject files

names(sub_train) <- c("subject_id")
names(sub_test) <- c("subject_id")

names(activity_train) <- c("activity_id")
names(activity_test) <- c("activity_id")

#Load the activity labels and features-desc files

activity_labels <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", row.names = NULL)
names(activity_labels) <- c("activity_id", "activity_name")

features <- read.table("C:/Ishani/Learning R/Getting And Cleaning Data/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt", row.names = NULL)
features[[1]] <- NULL

#Name the train and test features files

colnames(train) = as.character(features[,1])
colnames(test) = as.character(features[,1])

#Append the subject_id, activity_id and activity_name to train and test feature files

train <- cbind(sub_train, train,activity_train)
test <- cbind(sub_test, test,activity_test)

#Merge train and test into one file, and add the activity labels 
data_all <- rbind(train, test)
data_all <- merge(data_all, activity_labels, by = c("activity_id"))

#Choose only the measurements with mean and std.deviations, plus the id variables (on subject and activity)

data_allM <- data_all[,grep("mean", names(data_all), value=TRUE)]
data_allS <- data_all[,grep("std", names(data_all), value=TRUE)]
data_all2 <- cbind(data_allM, data_allS, data_all$activity_name, data_all$subject_id)


library(dplyr)
data_all2 <- rename(data_all2, subject_id = `data_all$subject_id`, activity_name = `data_all$activity_name`)

#Using the melt and dcast functions in reshape2 library to calculate the mean for each subject for every activity

library(reshape2)



id_labels <- c("subject_id", "activity_name")
x <- colnames(data_all2[1:79],)
data_all2_melt <- melt(data_all2, id = id_labels, measure.vars = x)
data_all2_tidy <- dcast(data_all2_melt, subject_id + activity_name ~ variable, mean)

write.table(data_all2_tidy,"C:/Ishani/Learning R/Getting And Cleaning Data/Tidy_Data_Part5.txt", row.names = FALSE )






