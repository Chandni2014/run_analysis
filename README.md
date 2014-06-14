run_analysis
============

Samsung galaxy data analysed

1. Reading all the files in R. I have unzipped the files manually and then reading the individual files in R. All   

  the files were saved at "C:/MYprograms/train/....." on my machine. 

data tables		    files

X_train 			 X_train.txt
y_train 			 y_train.txt
X_test 			 X_test.txt
y_test       		 y_test.txt
subject_train 		 subject_train.txt
subject_test                       subject_test.txt
features                             features.txt

2. Naming the columns of all the datatables appropriately.

data tables		columns

features			1. number, 2. Descrp
X_train			names taken from Descrp
X_test			names taken from Descrp
y_train			1. Activity
y_test			1. Activity
subject_train                  	sub1
subject_test		sub1
X_train_msd 		has only coloumns with 'mean' and 'std'
X_test_msd		has only columns with 'mean' and 'std'
mergeddata		combining test and train data together.


3. Combining the X and y of test/train datatables using cbind.

4. 
Searching for column names with 'Mean' and 'std' using grep.

5. X_train_msd - data table which has only the columns with 'mean' and 'std' in their variable name.
    X_test_msd -  data table which has only the columns with 'mean' and 'std' in their variable name.

6. Inserting a column "Subject" in X_train_msd and X_test_msd which has the character 'training' and 

'testing'  respectivley. This will help me to merge the test and train datatables later.

7. Naming the columns of subject_train/subject_test as "sub1".

8. Combining the 'X_train_msd' with 'subject_train'.  Combining the 'X_test_msd' with 'subject_test.

9. Merging the X_ data of both train and test together using rbind.

10. In mergeddata, substituting activity number for the activity name.

11. This is an additional step, where I am dropping some of the columns which I felt are not relevant as it 

had freq mean and so on.

12. Here I am tidying up the column names of the mergeddata by rempving "()" using gsub.

13. Creating a temp datatable with the name "tmpdata" dropping the character columns of the mergeddata 

so that it can be used in aggregate function.

14. "s1" is a variable which has the data from "sub1" column of the mergeddata. So that it can be used in 

aggregate function for grouping.

15. "act" is a variable which has the data from "Activity" column of the mergeddata, to be used in the 

aggregate function.

16. Finally, using the aggregate function to create the "newtidydata" which has the mean of all the 

variables grouped by activity and subject(variable 'sub1' in my code).
