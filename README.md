# cleaning_data_project

RUN_ANALYSIS.R



package dependencies: data.table

STEP 0: Make sure the working directory is the directory containing the UCI HAR Dataset directory. 


SCRIPT DESCRIPTION
####################################

The test , train , feature and activity data is imported into R. 

Test and training data are combined into one file.

Subject, X and Y data are then merged into one table.

Data is then converted to data table; as data table is used to manipulate data in script.

First two columns are renamed 'subject' and 'activityID' and the remaining columns are named
according to features.txt file.

A search is done for field names matching the 'std' and 'mean()' strings using the grep function.

Only columns which are needed are kept: only the subject, activityID and mean and std fields are kept.

Activity names are merged on to add descriptive names to activites. Then the activityID field is removed.

In a new table, the average of each mean and std field are calculated; being grouped by activity and subject.

The table is then exported to a text file named 'tidydata.txt'
