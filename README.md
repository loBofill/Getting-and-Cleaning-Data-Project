# Getting and Cleaning Data Project

Final course project for Getting and Cleaning Data course (Coursera - John Hopkins University)
'run_analysis.R' is the code needed for the assignment, which performs the following actions:

0. It assumes you have already downloaded and unzipped the dataset (instructions did not request the code to do it!).
1. Get activities and features data, and subsets only features with mean or std in them. Also cleans names.
2. Load both the training and test datasets, excluding fetures not related to mean or std.
4. Load activity & subject data for each dataset, and combine those columns with them.
5. Combines test and train data.
6. Factorizes activity and subject columns.
7. Separes each feature in different rows to cast a mean on them, to later recombine into a table.
8. Saves result in a tidy dataset

You can check the result at 'result.txt'
