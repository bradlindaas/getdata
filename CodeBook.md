##CodeBook for `tidy-mean.txt` submission

###Summary
This codebook describes the variables, the data, and transformations that I performed to clean up the data for this assignment.

###Data Source
The data came from the `UCI HAR Dataset` – Human Activity Recognition Using Smartphones. The data used in this project was collected from the accelerometers from the Samsung Galaxy S smartphone. [A full description is available at the site where the data was obtained](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data represents movement, acceleration, etc for a range of activity (walking, sitting etc). 

###Varaibles (columns)

| column index | column name | description |
|----|---|---|
|1 | subject | id number of test subject|
|2  | activity  | a descriptive name of activity |
|3:81  | | mean and std of various movement measurements  |

###Transformations
The original data set had over 500 colums containing measurements that were not the subject of this assignment. Additionally, for each `subject` in the data set, there were multiple measurements for each `activity'. The goal of this summarized tidy data was to aggregate the data to find the mean value of each variable of interest, for each `subject` and `activity` pair.

There are 30 unique subjects in the data set
- `subject` is a numeric from 1 to 30

There are 6 unique activities that are measured
- `LAYING`
- `SITTING`
- `STANDING`
- `WALKING`
- `WALKING_DOWNSTAIRS`
- `WALKING_UPSTAIRS`

Because there is an mean of each `subject` and `activity` pair, the final tidy data will be have 180 rows. (30 X 6)

The following transformation steps were taken:

1. merge the data sets `X_test.txt` and `X_train.txt`
  * performed within function `getXData()`

2. add the `activity` column using human readable names from `activity_labels.txt`
  * performed within function `getActivityData()`

3. add the `subject` column from the `y_test.txt` and `y_train.txt` files
  * performed within function `getSubjectData()`
 
4. clean up the variable column names
  * performed within function `getFeatureLabels()`

5. subset the data to keep only variables that measure mean and standard deviation
  * performed using `grepl` and this dataframe is called `tidyData'

6. summarized the variables for each `activity` and `subject` pair
  * performed with `melt` and `dcast` and this dataframe is called `averageTidyData`

7. export the `averageTidyData` dataframe to CSV for submission.

