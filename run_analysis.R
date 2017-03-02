## extracts test data
subjectTest <- readLines("./UCI HAR Dataset/test/subject_test.txt")
yTest <- readLines("./UCI HAR Dataset/test/y_test.txt")
# extracts the x values as a table beause of multiple columns
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

## extracts train data
subjectTrain <- readLines("./UCI HAR Dataset/train/subject_train.txt")
yTrain <- readLines("./UCI HAR Dataset/train/y_train.txt")
# again extracts the x values as a table beause of multiple columns
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")


## extracts activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityid", "activity"))
# appropriatly assigns y values (activity id's) descriptive activity labels 
yTest <- activityLabels[yTest, "activity"]
yTrain <- activityLabels[yTrain, "activity"]

## extracts features
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureid", "feature"))
# appropriatly assigns features descriptive names
features$feature <- gsub("^t", "time", features$feature)
features$feature <- gsub("^f", "frequency", features$feature)
features$feature <- gsub("Acc", "Accelerometer", features$feature)
features$feature <- gsub("Gyro", "Gyroscope", features$feature)
features$feature <- gsub("Mag", "Magnitude", features$feature)
features$feature <- gsub("BodyBody", "Body", features$feature)
# creates subset of x value with mean/standard deviation measurements
wantedFeaturesLogical <- grepl("mean|std", features$feature)
wantedFeatures <- subset(features$feature, wantedFeaturesLogical)
xTest <- xTest[, wantedFeaturesLogical]
xTrain <- xTrain[, wantedFeaturesLogical]


## merges test and train data
test <- cbind(subjectTest, xTest, yTest)
train <- cbind(subjectTrain, xTrain, yTrain)
# assigns columns decriptive names 
colnames(test) <- c("subject", as.character(wantedFeatures), "activity")
colnames(train) <- c("subject", as.character(wantedFeatures), "activity")

data <- rbind(test, train)


## groups by subject and activity and calculates the mean for all the other measurements 
tidyData <- aggregate(. ~subject + activity, data, mean)
write.table(tidyData, "tidy data.txt")
