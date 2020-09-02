library(dplyr) #cargar paquetes necesarios

#Cargar los df
features <- read.table("features.txt", col.names = c("n","functions"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features$functions)
y_test <- read.table("test/y_test.txt", col.names = "code")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$functions)
y_train <- read.table("train/y_train.txt", col.names = "code")


#Merge the test and train sets

x<-rbind(x_train ,x_test)#Merge the rows of the x set
y<-rbind(y_train,y_test)#Merge the rows of the y set
subjectset<-rbind(subject_train,subject_test)#Merge the rows of the subject set
merged_data <- cbind(subjectset, y, x)#Merge by columns the 3 previous sets

#Extracts only the measurements on the mean and standard deviation for each measurement

tidydata <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set

tidydata$code <- activities[tidydata$code, 2]

#Appropriately labels the data set with descriptive variable names
names(tidydata)[2] = "activity"
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "Time", names(tidydata))
names(tidydata)<-gsub("^f", "Frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "TimeBody", names(tidydata))
names(tidydata)<-gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "Angle", names(tidydata))
names(tidydata)<-gsub("gravity", "Gravity", names(tidydata))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

finaldata <- tidydata %>%group_by(subject, activity) %>%summarise_all(funs(mean))
write.table(finaldata, "finaldata.txt", row.name=FALSE)



