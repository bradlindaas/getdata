## Getting and Cleaning Data (getdata-004)

### Summary
This repo contains my solution to the class project for the Getting and Cleaning Data course (getdata-004) from John Hopkins University. The following files are located in the repo:

- `README.md` this file
- `run_analysis.R` data processing script. I have created a series of helper functions to segment my code in the case I needed to alter certain aspects of the data transformation workflow. I hope that doesn't make it complex to follow. But it certainly makes code management easier for me.
- `tidy-mean.txt` result of processing script and compliance with Part 5 of the assignment
- `CodeBook.md` description of resulting dataset `tidy-mean.txt` including variables and how the data was transformed.

### Purpose
The purpose of the project is "to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis." The data used in this project was collected from the accelerometers from the Samsung Galaxy S smartphone. [A full description is available at the site where the data was obtained](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data represents movement, acceleration, etc for a range of activity (walking, sitting etc). 

### The `run_analysis.R` script has the following package dependencies:
- `data.table`
- `reshape2`

### Objective and approach of `run_analysis.R`
The assignment required me to consolidate several files into a single, tidy data file. In order to combine the files, I had to:
- Merge two files (`X_test.txt` and `Y_test.txt`) into a single file.
- For each of the two files, I had to insert descriptive column names for the variables, found in the `features.txt` file.
- Each file contained a column with a code to represent the type activity measured in the observation. I mapped those code to human readable names found in the `activity_labels.txt` file
- Once the data files were merged and tidied, the script names it `mergedData` and it has dimensions of 10299 rows and 563 variables.
- The assignment requires us to focus on only variables that concern mean or standard deviation data. So all other varibales are dropped, and the script stores that data frame as `tidyData` and it has dimensions of 10299 rows and 81 columns.
- Lastly, the assignment required me to summarize the data (via mean) for each combination of `subject` and `activty`. The result of that summary is stored as `averageTidyData`. It has dimensions of 180 rows and 81 columns. This data is exported to txt file to submit as part of the assignment, and is named `tidy-mean.txt`

>**Note:** The CodeBook.md file has additional details on the tidy data set called `tidy-mean.txt`

You can access the file by using the following command in your script:

```r
source("{path_2_folder}/run_analysis.R")
```

>**Caution:** The script `run_analysis.R` expects the assignment data to be extracted in your working directory. If it is not found (it checks for existance of `UCI HAR Dataset` folder), it will download the data and extract it.

Once you run the script, you will find the file `tidy-mean.txt` in your working directory. This is the file that was uploaded as part of the submission. You can load the dataframe into R using the following command (assumes file in in working directory)

```r
averageTidyData <- read.csv("tidy-mean.txt")
```

###Assignment Rubric
In an effort to ensure those that mark my submission are aware of my alignment to the rubric, please note the following:
- **Why do I feel this is Tidy Data?** First, each row in `tidy-mean.txt` corresponds to a single measurement combination of `subject` and `activity`. There are 30 subjects and 6 activities. Notice my dataset has 180 rows. You can check this with the following code: `nrow(averageTidyData)`. Each column corresponds to a single variable. The table contains measurements of only one type: means of activites for 30 subjects.


>**Why do I feel I covered the items in the rubric?** Consider the following justifications for each item in the rubric

- **Has the student submitted a tidy data set?** Please see attached file `tidy-mean.txt` with 180 rows and 81 columns.
- **Did the student submit a Github repo with the required scripts?** Please refer to my GitHub repo, with the `run_analysis.R` script.
- **Please submit a code book that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information.** Please refer to the `CodeBook.md` also included in this repo. 
- **I was able to follow the README in the directory that explained what the analysis files did.** This file has attempted to walk the grader through each step of the process.
- **As far as you can determine, does it appear that the work submitted for this project is the work of the student who submitted it?** I have signed the Coursera Honor Code, and I hope that this detailed outline as well as the comments I have in `run_analysis.R` show this is work I wrote and fully understand.
