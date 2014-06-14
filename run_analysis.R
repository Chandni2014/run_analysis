# reading all the files in R. 
# I have manually unzipped the files and reading individual files.

X_train <- read.table("C:/MYprograms/train/X_train.txt")
y_train <- read.table("C:/MYprograms/train/y_train.txt")

X_test <- read.table("C:/MYprograms/test/X_test.txt")
y_test <- read.table("C:/MYprograms/test/y_test.txt")

subject_train <- read.table("C:/MYprograms/train/subject_train.txt", header =FALSE)
subject_test <- read.table("C:/MYprograms/test/subject_test.txt")
features <- read.table("C:/MYprograms/UCI HAR Dataset/features.txt")

# naming the columns of each data table appropriately.

names(features) <- c("number", "Descrp")
names(X_train) <- features$Descrp
names (X_test) <- features$Descrp
names(y_train) <- "Activity"
names(y_test) <- "Activity"

# combining the X & Y of train / test data table. 
X_train <- cbind(X_train, y_train)
X_test <- cbind(X_test, y_test)


# searching for column names(variables) which have 'Mean' & 'std' in features data table.
grep("[Mm]ean" , features$Descrp)
grep("[Ss]td" , features$Descrp)

# keeping the columns where 'Mean' & 'std' are present and dropping the rest.
X_train_msd <- X_train[, c(1:6,41:46,81:86,121:126, 161:166, 201:202, 214:215,227:228,240:241,253:254,266:271,294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 513, 516, 517, 526,529,530,539,542,543,552:561
                           ,562)]

X_test_msd <- X_test[, c(1:6,41:46,81:86,121:126, 161:166, 201:202, 214:215,227:228,240:241,253:254,266:271,294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 513, 516, 517, 526,529,530,539,542,543,552:561
                           ,562)]

# inserting a column in test/ train each which identifies them as training or testing.
X_train_msd$Subject <- "training"
X_test_msd$Subject <- "testing"

# naming the columns of the subject data table
names(subject_train) <- "sub1"
names(subject_test) <- "sub1"

# combining train data table which has only the mean & std coloumns 
# with subject data table.
X_train_msd <- cbind(X_train_msd, subject_train)
X_test_msd <- cbind(X_test_msd, subject_test)

# merging the final train and test data together.
mergeddata <- rbind(X_train_msd, X_test_msd)

# substitute activity number with the activity name.
mergeddata$Activity <- gsub("1", "WALKING", mergeddata$Activity)
mergeddata$Activity <- gsub("2", "WALKING_UPSTAIRS", mergeddata$Activity)
mergeddata$Activity <- gsub("3", "WALKING_DOWNSTAIRS", mergeddata$Activity)
mergeddata$Activity <- gsub("4", "SITTING", mergeddata$Activity)
mergeddata$Activity <- gsub("5", "STANDING", mergeddata$Activity)
mergeddata$Activity <- gsub("6", "LAYING", mergeddata$Activity)

# This is an additional step.
# bcos later I decided to drop some of the columns which I felt was not relevant.
mergeddata <- mergeddata[ ,c(-80,-81)]
mergeddata <- mergeddata[ ,-80:-86]
mergeddata <- mergeddata[, c(-47:-49, -56:-58, -65:-67, -70,-73,-76,-79)]

# here I have removed () from the variable names in the merged data table.
names(mergeddata) <- gsub("\\()", "", names(mergeddata))

# created temp data 'tmpdata' from mergeddata dropping the character columns
# so that it can be used in the aggregate function.
tmpdata <- mergeddata[,1:66]

# storing the column 'sub1' of mergeddata in variable s1
s1 <- mergeddata$sub1
# storing the column 'Activity' of mergeddata in variable act
act <- mergeddata$Activity

# using the aggregate function to create the new tidy dataset which has mean of all 
# the columns grouped by 's1'(subject) and 'act'(activity)

newtidydata <- aggregate(tmpdata, by = list(act,s1), FUN = "mean")

