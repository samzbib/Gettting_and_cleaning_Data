
library (dplyr)
library (lubridate)
library (RCurl)
library (XML)
library (httpuv)
library (data.table)
library(purrrlyr)
library (benchr) 

## this function is to return the second substring from a comma separated string. 
## this is usd to remove the numerals preceding the feature name when extracting the feature names

strsplit2 <- function  (x) 
{ res <- strsplit (x, " ") 
  ures <- unlist (res) 
  ures[2] 
} 



setwd ("C:\\Users\\sazbib\\OneDrive - Capgemini\\Desktop\\Training\\R Training\\Coursera-GettingAndCleaningData\\Project")

feat_DF <- read.table ("features.txt",header = FALSE,sep="\t",stringsAsFactors = FALSE)
names (feat_DF) <- "fname"
needed_cols <- unlist (which  (grepl("mean\\(|std\\(",feat_DF$fname)))


## feat_DF1 <- data.frame (unlist( lapply (feat_DF$fname, strsplit2)) )
## names (feat_DF1) <- "fname"






# augment the act_sub_DF with activity name 
 actName_DF <- data.frame ( "actCode" = c(1:6), "actName" =  c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING", "STADING","LAYING"))

# populate all locations into a DF for simple access 

ops_df = data.frame ("source" = c ("test","train"), 
                     "subject_loc" = c ("test\\subject_test.txt", "train\\subject_train.txt"), 
                     "act_loc" = c ("test\\y_test.txt", "train\\y_train.txt"),
                     "data_loc" = c ("test\\X_test.txt", "train\\X_train.txt"),stringsAsFactors = FALSE)





##--------------------- Test Data aggregation

## Construct a DF containing the test data sets 
sub_DF <- read.csv (ops_df [1,2],header = FALSE)
act_DF <- read.csv (ops_df [1,3],header = FALSE)
act_sub_DF  <- cbind (sub_DF, act_DF)
names (act_sub_DF) <- c ("subId","actCode")
actNSub_DF <- merge (act_sub_DF,actName_DF, all.x = TRUE)

# get the test data in a DF and add the Feature names to the Data frame
 testdata_DF <- read.table (ops_df [1,4],header = FALSE, stringsAsFactors = FALSE)
 names (testdata_DF) <- unlist(feat_DF$fname)

 mean_std_test_DF <-  select (testdata_DF, needed_cols)  
## augment test data with Subject and Activity Columns
complete_test_data_DF <- cbind (mean_std_test_DF [,],select (actNSub_DF,2-3))


##-------------------------------Redo all for train Data 

## Construct a DF containing the test data sets 
sub_DF <- read.csv (ops_df [2,2],header = FALSE)
act_DF <- read.csv (ops_df [2,3],header = FALSE)
act_sub_DF  <- cbind (sub_DF, act_DF)
names (act_sub_DF) <- c ("subId","actCode")
actNSub_DF <- merge (act_sub_DF,actName_DF, all.x = TRUE)

# get the test data in a DF and add the Feature names to the Data frame
 traindata_DF <- read.table (ops_df [2,4],header = FALSE, stringsAsFactors = FALSE)
 names (traindata_DF) <- unlist(feat_DF$fname) 

 mean_std_train_DF <-  select (traindata_DF, needed_cols)  
## augment test data with Subject and Activity Columns
complete_train_data_DF <- cbind (mean_std_train_DF [,],select (actNSub_DF,2-3))



##Step 4------------------------------- Combine train Data with test data into one dataframe

alldata_DF <- rbind ( complete_train_data_DF,  complete_test_data_DF)
write.csv (alldata_DF, "output_data.csv") 


##Step 5 ------------------------------- generate grouped summaries 

temres <- alldata_DF  %>% group_by (actName, subId) %>% summarise_all(funs(mean))
write.csv (temres, "summary_data.csv") 





## Examining summaries for a sample activity
 select (temres,c(1,2,3,4,5,65)) %>% filter (actName == "SITTING")


## examining  a subset of Summaries for a sample subject ID
 select (temres,c(1,2,3,4,5,34)) %>% filter (subId ==  2)


