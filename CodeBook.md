# Human Activity Recognition Using Smartphones Dataset - Ver 1.0

## Data 

The raw dataset for the Human Activity Recognition experiment is from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The tidy dataset can be retrieved by dowloading directly from the Github repository or running the run_analysis.R script. 

## Variables

The 3 main types of variables in this dataset are:

- The id of the participants
- The names of the activities (Eg: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", or "LAYING")
- Other scientific measurements (You can read more about it in the feature_info.txt included in the raw dataset)

The list of scientific variables after cleaning are: 

 [1] "time body accelerometer- mean-x_mean"                                    
 [2] "time body accelerometer- mean-y_mean"                                    
 [3] "time body accelerometer- mean-z_mean"                                    
 [4] "time body accelerometer- standard deviation-x_mean"                      
 [5] "time body accelerometer- standard deviation-y_mean"                      
 [6] "time body accelerometer- standard deviation-z_mean"                      
 [7] "time gravity accelerometer- mean-x_mean"                                 
 [8] "time gravity accelerometer- mean-y_mean"                                 
 [9] "time gravity accelerometer- mean-z_mean"                                 
[10] "time gravity accelerometer- standard deviation-x_mean"                   
[11] "time gravity accelerometer- standard deviation-y_mean"                   
[12] "time gravity accelerometer- standard deviation-z_mean"                   
[13] "time body accelerometer jerk- mean-x_mean"                               
[14] "time body accelerometer jerk- mean-y_mean"                               
[15] "time body accelerometer jerk- mean-z_mean"                               
[16] "time body accelerometer jerk- standard deviation-x_mean"                 
[17] "time body accelerometer jerk- standard deviation-y_mean"                 
[18] "time body accelerometer jerk- standard deviation-z_mean"                 
[19] "time body gyroscope- mean-x_mean"                                        
[20] "time body gyroscope- mean-y_mean"                                        
[21] "time body gyroscope- mean-z_mean"                                        
[22] "time body gyroscope- standard deviation-x_mean"                          
[23] "time body gyroscope- standard deviation-y_mean"                          
[24] "time body gyroscope- standard deviation-z_mean"                          
[25] "time body gyroscope jerk- mean-x_mean"                                   
[26] "time body gyroscope jerk- mean-y_mean"                                   
[27] "time body gyroscope jerk- mean-z_mean"                                   
[28] "time body gyroscope jerk- standard deviation-x_mean"                     
[29] "time body gyroscope jerk- standard deviation-y_mean"                     
[30] "time body gyroscope jerk- standard deviation-z_mean"                     
[31] "time body accelerometer magnitude- mean_mean"                            
[32] "time body accelerometer magnitude- standard deviation_mean"              
[33] "time gravity accelerometer magnitude- mean_mean"                         
[34] "time gravity accelerometer magnitude- standard deviation_mean"           
[35] "time body accelerometer jerk magnitude- mean_mean"                       
[36] "time body accelerometer jerk magnitude- standard deviation_mean"         
[37] "time body gyroscope magnitude- mean_mean"                                
[38] "time body gyroscope magnitude- standard deviation_mean"                  
[39] "time body gyroscope jerk magnitude- mean_mean"                           
[40] "time body gyroscope jerk magnitude- standard deviation_mean"             
[41] "frequency body accelerometer- mean-x_mean"                               
[42] "frequency body accelerometer- mean-y_mean"                               
[43] "frequency body accelerometer- mean-z_mean"                               
[44] "frequency body accelerometer- standard deviation-x_mean"                 
[45] "frequency body accelerometer- standard deviation-y_mean"                 
[46] "frequency body accelerometer- standard deviation-z_mean"                 
[47] "frequency body accelerometer jerk- mean-x_mean"                          
[48] "frequency body accelerometer jerk- mean-y_mean"                          
[49] "frequency body accelerometer jerk- mean-z_mean"                          
[50] "frequency body accelerometer jerk- standard deviation-x_mean"            
[51] "frequency body accelerometer jerk- standard deviation-y_mean"            
[52] "frequency body accelerometer jerk- standard deviation-z_mean"            
[53] "frequency body gyroscope- mean-x_mean"                                   
[54] "frequency body gyroscope- mean-y_mean"                                   
[55] "frequency body gyroscope- mean-z_mean"                                   
[56] "frequency body gyroscope- standard deviation-x_mean"                     
[57] "frequency body gyroscope- standard deviation-y_mean"                     
[58] "frequency body gyroscope- standard deviation-z_mean"                     
[59] "frequency body accelerometer magnitude- mean_mean"                       
[60] "frequency body accelerometer magnitude- standard deviation_mean"         
[61] "frequency bodybody accelerometer jerk magnitude- mean_mean"              
[62] "frequency bodybody accelerometer jerk magnitude- standard deviation_mean"
[63] "frequency bodybody gyroscope magnitude- mean_mean"                       
[64] "frequency bodybody gyroscope magnitude- standard deviation_mean"         
[65] "frequency bodybody gyroscope jerk magnitude- mean_mean"                  
[66] "frequency bodybody gyroscope jerk magnitude- standard deviation_mean"    

## Transformations

Here are the steps I take to clean the raw dataset: 

1. Row bind the "id", "activity" and "scientific value" columns from the train and test datasets
2. Merge the "activity" column with the label table to transform the "activity" column from numbers to characters
3. Column bind the "id", "activity" and "scientific" columns into a data frame
4. Search for the columns whose name contains "mean()" or "std()" phrases to retrieve only the mean and standard deviation values
5. Edit the names of all columns to remove acronyms and implement correct spacing
6. Group the data frame by "id" and "activity" and summarise the mean of all columns 