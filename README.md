# gettingandcleandata
#1
First I upload the files into dataframes with the function read.table
Next I merged the x sets by rows(the train and the test) and create a new x set with all the rows 
Then I do the same with the y sets and the simulation set
Finally I merged the 3 previous sets by columns and create a new set called merged_data
#2
For this part I use the function "select" to select only the columns with names that contains the characters "mean" or "std", I also keep the columns subject and code.
#3
I change the code for the activities with a descriptive name for each activity 
#4
In this part I change the names of the columns(variables)
#5
Finally,I generate a 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file finaldata.txt.
