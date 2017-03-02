### Getting and Cleaning Data Course Project

## Introduction

The purpose of this project is to demostrate my ability to collect, work with and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Data

One of the most exciting areas in all of data science right now is wearable computing - see for example this article: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Requirements

The script must be placed in the same directory as the unzipped content from the url above. 


## Code

The following files are extracted from the test & train directories:
* "subject_test.txt"
* "X_test.txt"
* "y_test.txt"
They are both merged into the same data table. The "features.txt" and the "activity_labels.txt" file contain the variable names for the x and y fields respectively. The x values are actually a table in itself containing values for different measurements seperated by columns. These were filtered out to only get the measurements that take the mean or standard deviation. 

Finally, we group the data by subject and activity and get the means of the values for each measurement and write the output to a file, "tiny data.txt". 

