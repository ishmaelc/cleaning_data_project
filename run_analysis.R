library(data.table)

rm(list=ls())

## import test , train , feature and activity data into R
test.X <- read.table('./UCI HAR Dataset/test/X_test.txt')
test.Y <- read.table('./UCI HAR Dataset/test/Y_test.txt')
test.sub <- read.table('./UCI HAR Dataset/test/subject_test.txt')
train.X <- read.table('./UCI HAR Dataset/train/X_train.txt')
train.Y <- read.table('./UCI HAR Dataset/train/Y_train.txt')
train.sub <- read.table('./UCI HAR Dataset/train/subject_train.txt')
feat <- read.table('./UCI HAR Dataset/features.txt',colClasses='character')
act <- read.table('./UCI HAR Dataset/activity_labels.txt')

## combine test and training data
X <- rbind(test.X,train.X)
Y <- rbind(test.Y,train.Y)
sub <- rbind(test.sub,train.sub)

## combine subject X and Y data into one table
data <- cbind(sub,Y,X)

## convert data and act dataframes to data tables
## data.table package is used to manipulate data
setDT(data)
setDT(act)

## rename columnns of data to descriptive names
## subject, activityID are used for ssubject and activity fields
## names from the features.txt file are used to rename the features field.
setnames(data,c('subject','activityID',feat$V2))

## create vector of columns to keep; used grep function to search for 
## column names containing 'std' and 'mean()' strings.
keep <- c('subject','activityID'
          ,grep('std',feat$V2, value=T, fixed = T)
          ,grep('mean()',feat$V2, value=T, fixed = T))

## keep only columns that are needed; drop all others
data <- data[,keep, with = FALSE]

## Merge on activity names
setkey(data,activityID)
setkey(act,V1)
data[act,activity_name:=V2]

## remove all objects except data from memory
rm(list = ls()[ls() != "data"])

## remove activityID column
data[,activityID:=NULL]

## calculate average of each variable for each activity and each subject
summ_data <- data[,lapply(.SD,mean),by=.(subject,activity_name)]

## export table to tidydata.txt file
write.table(summ_data,file = 'tidydata.txt',row.name=FALSE)