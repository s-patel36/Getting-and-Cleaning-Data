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
# creates subset of x value with mean/standard deviation measurements
wantedFeaturesLogical <- grepl("mean|std", features$feature)
wantedFeatures <- subset(features$feature, wantedFeaturesLogical)
xTest <- xTest[, wantedFeaturesLogical]
xTrain <- xTrain[, wantedFeaturesLogical]


## merges test and train data
test <- cbind(subjectTest, yTest, xTest)
train <- cbind(subjectTrain, yTrain, xTrain)
# assigns columns decriptive names 
colnames(test) <- c("subject", "activity", as.character(wantedFeatures))
colnames(train) <- c("subject", "activity", as.character(wantedFeatures))

data <- rbind(test, train)


## groups by subject and activity and calculates the mean for all the other measurements 
tidyData <- aggregate(. ~subject + activity, data, mean)
write.table(tidyData, "tidy data.txt", row.names = FALSE)
