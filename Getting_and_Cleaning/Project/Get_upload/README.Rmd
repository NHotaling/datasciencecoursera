---
title: "readme"
author: "Ravnus9"
date: "Sunday, April 26, 2015"
output: html_document
---
# run_analysis

## The R script "run_analysis.R" is explained in detail below:

1. The script installs the dplyr, plyr, and reshape2 packages.  These lines are commented out currently because once installed these packages do not need to be reinstalled.  The script then loads the library for dplyr, plyr, and reshape2. 
2. The scripts then checks for a folder called "data" in the working directory.  If no file exists it creats one.  
3. A zip file is then downloaded into a temporary directory from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
4. The zip file is then unzipped into the data folder of the working directory.
5. Subsequent files from the unzipped directory are then opened and loaded as tables and stored in memory as variable names.  
6. The feature names from the features table are then Converted into a vector for use later.
7. The column names for the variable containing the activities are then renamed for more informative column titles.  
8. The data tables are then checked to ensure their structure is as predicted.
9. The test data tables and the training data tables are then, separately, column bound together with the subject who did each measurement and the activity that was done to obtain each measure.
10. The combined test and train data are then row bound together.
11. The column names for the combined data table are then renamed to give them more informative names.
12. Column names that contain the strings "mean"" or "std"" are then subset from the total dataset
13. These columns are then column bound together along with the subject ID and activity
14. The activity column was only a numeric column previously; thus, a merge operation was performed in which a column was added that gave the activity name, not just number, every time it occurred in the data table.
15. The subsequent dataset are then transformed into a tall dataset that has the Activity Number, Test Subject, and Activity Name as the first three columns, the forth column contains all variables that had mean or std in their title, and the fifth column contains the values for each of those variables.
16. The data set is then transformed into a table that gives the mean value of each variable for each subject for each activity.  This can also be called the variable mean for the two way interaction between subject and activity.
17.  This tidy summary talbe is then saved as a .txt file in the data file of the working directory with commas separating each value. This is done for ease of opening in excel.

