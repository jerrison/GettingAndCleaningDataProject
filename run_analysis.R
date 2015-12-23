###############################################################################
# Author: Jerrison Li
# Date: 12.22.2015 10:26:31 AM 
# Description: 
#
###############################################################################
library(dplyr)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = 
                                  c("activity_id", "activity_label"))

# feature aka measurement labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = 
                           c("feature_id", "feature_label"))

# list of which subject performed which row of activities
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = 
                               c("subject_id"))

# activity for each X_test row
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# test data set
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = 
                         features$feature_label)



features
dim(X_test)
dim(subject_test)
summary(subject_test)
y_test


head(X_test)

dim(X_test)
dim(features)

dir()
subject_test
dim(y_test)
dim(features)
head(features)
head(y_test)
dir("UCI HAR Dataset/test/")
str(y_test)
summarise(y_test)
summary(y_test)


# run_analysis.R


