###############################################################################
# Author: Jerrison Li
# Date: 12.22.2015 10:26:31 AM 
# Description: 
#
###############################################################################
setwd("H:/Documents/GitHub/GettingAndCleaningDataProject")

library(dplyr)
library(reshape2)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = 
                                  c("activity_id", "activity_label"))

# feature aka measurement labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = 
                           c("feature_id", "feature_label"))

###############################################################################
#                           test data set                                                               
###############################################################################


# list of which subject performed which row of activities
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = 
                               c("subject_id"))

# activity for each X_test row
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# test data set
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = 
                         features$feature_label)
X_test$activity <- as.numeric(as.matrix(y_test))
X_test$subject <- as.numeric(as.matrix(subject_test))
X_test <- merge(X_test, activity_labels, by.x = "activity", by.y = 
                    "activity_id")

test_data_set <- X_test[, c("subject", "activity_label",
                            grep("mean|Mean|std|Std", names(X_test),
                                 value = TRUE))]

test_data_set <- tbl_df(test_data_set)


###############################################################################
#                       train data set                                                               
###############################################################################

# list of which subject performed which row of activities
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = 
                                c("subject_id"))

# activity for each X_train row
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# train data set
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = 
                          features$feature_label)
X_train$activity <- as.numeric(as.matrix(y_train))
X_train$subject <- as.numeric(as.matrix(subject_train))
X_train <- merge(X_train, activity_labels, by.x = "activity", by.y = 
                     "activity_id")

train_data_set <- X_train[, c("subject", "activity_label",
                              grep("mean|Mean|std|Std", names(X_train),
                                   value = TRUE))]

train_data_set <- tbl_df(train_data_set)

###############################################################################
#                       combined data set                                                               
###############################################################################

combined_data_set <- rbind(train_data_set, test_data_set)

melted_data_set <- melt(combined_data_set, id.vars = c("subject", 
                                                       "activity_label"))

grouped_melt_set <- group_by(melted_data_set, subject, activity_label, variable)

###############################################################################
#                           OUTPUT                                                              
###############################################################################

output <- summarise(grouped_melt_set, average = mean(value))

# write to file

write.table(output, file = "GettingAndCleaningDataProject.txt", row.names =
                FALSE)

