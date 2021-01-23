library(data.table)
library(dplyr)

# Create a based directory to work on and save the tidy data set. 

if (!file.exists("data")) {
    dir.create("data")
}
setwd("data")

# Download and unzip the zip file. Remove the zip file afterwards
# Set the working directory to the new file

zip_link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = zip_link, destfile = "data.zip")
unzip("data.zip")
file.remove("data.zip")
setwd("UCI HAR Dataset")

# The file contains 3 types of data: the people ID, the activity types and
# the value of that measurement. For each data type, combine the train and 
# test file. After that we combine the 3 columns.

subject_train <- fread("train/subject_train.txt")
subject_test <- fread("test/subject_test.txt")
subject <- rbind(subject_train, subject_test)

activity_train <- fread("train/y_train.txt")
activity_test <- fread("test/y_test.txt")
activity <- rbind(activity_train, activity_test)

value_train <- fread("train/X_train.txt")
value_test <- fread("test/X_test.txt")
value <- rbind(value_train, value_test)

# Next step is joining the label table and the activity column. 
# The purpose is to substitute the number with the actual activity name.

label <- fread("activity_labels.txt")
names(label) <- c("id", "activity")
activity_df <- data.frame(activity)
names(activity_df) <- c("id")
# Since activity vector already has a name --> Can't assign directly 
# using the data.frame() function, have to use the names() function
activity <- merge(activity_df, label, by.x = "id", by.y = "id")
activity <- activity$activity

# Bind all the columns into 1 data frame
data <-  cbind(subject, activity, value)

# Read the names of each measurement and assign appropriate names 
# to each column

features <- fread("features.txt") 
names(data) <- unlist(list("id", "activity", features[,2]))
# Since names attribute only accepts character vector, I have to unlist
# because features[,2] is a vector inside of another vector --> A list 

# The next step is searching for columns with the keywords "mean" and "std"
# and removing all other columns. 

satisfy_col <- grep("mean\\(\\)|std\\(\\)|id|activity", names(data)) 
# The "|" symbol means "or" logical flow in regular expression. 
# Also since the "()" is a grouping mechanism, we need to specify 
# the 2 components "\\(" and "\\)" separately
data <- subset(x = data, select = satisfy_col) 

# The next step is making the variable name more descriptive and readable 
# by removing acronyms, spacing the words correctly and lowercases all the 
# words.


names(data) <- gsub("^t", "time ", names(data))
names(data) <- gsub("^f", "frequency ", names(data))
names(data) <- gsub("mean\\(\\)", " mean", names(data))
names(data) <- gsub("std\\(\\)", " standard deviation", names(data))
names(data) <- gsub("Gyro", " gyroscope", names(data))
names(data) <- gsub("Acc", " accelerometer", names(data))
names(data) <- gsub("Mag", " magnitude", names(data))
names(data) <- gsub("Jerk", " jerk", names(data))
names(data) <- tolower(names(data))
# Lowercase the names of variables

# Finally, I aggregate the value in all columns based on the activity types and 
# id of person

tidy_data <- data %>% 
    group_by(id, activity) %>%
    summarise_all(.funs = c(mean = "mean"))
# There are many functions that can be used to summarize multiples 
# columns (E.g: summarise_at, summarise_each ...). I just use summarise_all()
# because it is the simplest.

# After having the tidy data frame, we go back to the main directory (data) 
# and write the csv file there

setwd("..")
write.csv(x = tidy_data, file = "tidyData.csv", row.names = FALSE)