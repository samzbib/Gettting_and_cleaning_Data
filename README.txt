==================================================================
Getting and Cleaing Data Course Project Submission
==================================================================
Contents:
1 - This README.txt (this file): provides an overview of each of the files in the sumission set 
2 - output_data.csv
3 - run_analysis.R : This is the R Script  whose function is displayed below 
4 - summary data.csv : This  is a summary Dataframe containing 
5 - feature_desc.csv 
==================================================================

Notes about the input data 
1- the file containing the feature variales ("features.txt")  contains dupicate field names which makes it difficult to run some scripts,
    exampe of duplicate field name is: "fBodyAcc-bandsEnergy()-1,16":  which was present at offses: 311,325 and 339
    in general, 42 such variables had the same problem.
    since the duplicate fields are neither mean nor std, this does not affect the results however it does affect the sequence of steps to load the data .
    for example you cannot assign duplaciate names to a data frame. 

 
 

==================================================================
Sequence of Steps executed by run_analysis.R: 
1 - Read feature names, these are the column lables from file features.txt
2-  determine which columns are needed and store the index of these columns in needed_cols
3 - Read subject, activity and Data Test set Dataframes, merge them into one Dataframe,  
4 - Read subject, activity and Data Training set Dataframes, merge them into one Dataframe, 
5 - Merge the Test and Traning Data 
6 - Combine train Data with test data into one dataframe
7 - generate grouped summaries 
 

==================================================================

