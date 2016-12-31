library(reshape2)

# Get Activities and Features
# Alert! You need to be in the same directory where you unzipped the dataset
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Subset only mean and std features
subfeats <- grep(".*mean.*|.*std.*", features[,2])
subfeatures <- features[subfeats,2]
subfeatures = gsub('-mean', 'Mean', subfeatures)
subfeatures = gsub('-std', 'Std', subfeatures)
subfeatures <- gsub('[-()]', '', subfeatures)


# Get Train & Test datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[subfeats]
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainY, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[subfeats]
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testY, test)

# combine both train ans tests into one dataset, include correct names for variables
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", subfeatures)

# factor in act & subject
allData$activity <- factor(allData$activity, levels = activities[,1], labels = activities[,2])
allData$subject <- as.factor(allData$subject)

#prepare data to apply mean, and apply with dcast
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "result.txt", row.names = FALSE, quote = FALSE)