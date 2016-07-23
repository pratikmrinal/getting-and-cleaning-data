# getting-and-cleaning-data

This is the project work done for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, executes the following steps in order to accomplish the required data cleaning activity:


1. It checks for the dataset in the working directory and downloads the dataset if it does not already exist.
2. Load the activity and feature info

3. Loads both the training and test datasets and keeps only those columns which
 reflect a mean or standard deviation

4. The script then loads the activity and subject data for each dataset, and merges those
   columns with the dataset

5. Finally it merges the two datasets

6. The script then converts the `activity` and `subject` columns into factors

7. Lastly it creates a tidy dataset that consists of the average (mean) value of each
  variable for each subject and activity pair.

The end result is stored in the file `tidy.txt`.
