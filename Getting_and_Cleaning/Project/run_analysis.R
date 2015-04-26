## setwd("C:/Users/nah1/OneDrive/R/datasciencecoursera/Getting_and_Cleaning/Project")
## install.packages('dplyr')
## install.packages('plyr')
## install.packages('reshape2')
run_analysis<-function(){
     library(dplyr)
     library(plyr)
     library(reshape2)

## Checks for a file called data in your working directory and creates that folder 
## if it does not already exist.

if(!file.exists("data")) {
     dir.create("data")
}

## Downloads the zip file from the link into a temporary file called temp()
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     temp <- tempfile()
     download.file(fileurl,temp)
     
          ## unzips the selected files, in this case all of them, to the data folder of your 
          ## working directory
          unzip(temp, exdir = "./data")
               unlink(temp)
     
     ## Reads each of the unzipped files into a table     
     act_dat_testx <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
     act_dat_testy <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
     act_dat_trainx <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
     act_dat_trainy <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
     act_features_total <- read.table("./data/UCI HAR Dataset/features.txt")
     act_activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
     act_testsub <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
     act_trainsub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

          ## Converts the names of the features into a vector for use later
          act_features <- as.vector(act_features_total[,2])
          act_features
          
          ## Renames the activity column names into more descriptive names
          colnames(act_activity) <- c("Activity_num", "Activity_name")
          act_activity
          

          ## examines data to make sure it looks the way we expect it to
          head(act_dat_testx)
          head(act_dat_testy)
               max(act_dat_testy)
          head(act_dat_trainx)
          head(act_dat_trainy)
               max(act_dat_trainy)
     
     ## Combines the test data into one large file with the test subjects as the first column and 
     ## y_test (activity) variable as the second column in that dataset.
          act_test <- cbind(act_testsub, act_dat_testy, act_dat_testx)
               head(act_test[,1:5])

     ## Combines the train data into one large file with the train subjects as the first column and 
     ## y_train (activity) variable as the second column in that dataset.
          act_train <- cbind(act_trainsub, act_dat_trainy, act_dat_trainx)
               head(act_train[,1:5])

     ## Merges test and train into one large table
          act_data <- rbind(act_train, act_test)
     
     ## Rename column headers to a more informative header for the total dataset
               colnames(act_data) <- c("Test_Subject", "Activity", act_features)
               colnames(act_data[1:10])
                    head(act_data[,1:5])
                    tail(act_data[,70:80])
     
     ## segments the total dataset into a subset of the original data set that contains only 
     ## columns with names that contain the words mean or std  
     
     mean_value <- "mean"
     std_value <- "std"
     
     act_data_means <- act_data[,grepl(mean_value, colnames(act_data))]
          colnames(act_data_means)
     act_data_stds <- act_data[,grepl(std_value, colnames(act_data))]
          colnames(act_data_stds)
     
     ## The data tables of mean and std are then combined along with subjects and activity
     act_mean_sd <- cbind(act_data[,1:2],act_data_means,act_data_stds)
          XX <- c(1:3,80,81)
          head(act_mean_sd[,XX])
     
     ## Merges activity vector names with subset data
     act_merge <- merge(act_mean_sd,act_activity, by.x = "Activity", by.y = "Activity_num", all = TRUE)
          XX2 <- c(1:3,81,82)
          head(act_merge[,XX2])
          all_vars <- colnames(act_merge[3:81])
               
     
     ## Changes the dataset into a long tall dataset with only activity, test subject, and activity
     ## name as columns with another column called  "variable" which is all of the column names  
     ## that represented activity variables from the act_merge data set and their subsequent value 
     ## in the "value" column.   
     
     act_melt <- melt(act_merge, id= c("Activity","Test_Subject","Activity_name"), measure.vars= all_vars)
     head(act_melt)
     
          ## Recasts the act_melt data as a tiday dataset of means for the two way interaction 
          ## between the variables, Activity and Test_Subject.  
          act_melt_summary <- dcast(act_melt, variable ~ Activity_name*Test_Subject,mean)
               head(act_melt_summary)
                  
          write.table(act_melt_summary, file = "./data/tidy_data.csv", sep = ",")
               act_melt_summary
}     
