# Remove data
rm(list = ls())

## set random seed for random guessing in NLI algorithms 
set.seed(2023)

# get predefined strings for p-value and NLI classification
url_DeWinter = 'https://github.com/PsyCapsLock/NegativeResultDetector/blob/main/Utilities/Functions_DeWinter_Dodou_2015_A_surge_of_p-values.R?raw=true'
source(url_DeWinter)


## load data
df_train <- read.csv('https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/train_2023-07-26.csv?raw=true')
df_dev <- read.csv('https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/dev_2023-07-26.csv?raw=true')
df_test <- read.csv('https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/test_2023-07-26.csv?raw=true')
df_val1 <- read.csv('https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Validation/validation_1_nongerman_2023-07-28.csv?raw=true')
df_val2 <- read.csv('https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Validation/validation_2_1990-2012_2023-07-28.csv?raw=true')

# bind data
df_full<-data.frame(rbind(df_test,df_train,df_dev))
df_train<-rbind(df_train,df_dev)


##################################
# probability of random guessing #
##################################
prob_df_train<-table(df_train$label)/nrow(df_train)


#############
# parameter #
#############

# 1. We check whether a p value greater than .05 is reported --> Mixed and Negative Results
# parameter_negative_result returns TRUE for p value above this threshold.
# 2. We check whether a p value smaller than .05 is reported --> Positive Results only
# parameter_positive_result returns TRUE for p value below this threshold, 
# 3. If no condition is met, we randomly sample a class label

algorithm_parameter<-function(text,prob){
  if(parameter_negative_result(text)==TRUE){
    result=0
  }else if(parameter_positive_result(text)==TRUE){
    result=1
  }else{
    result=sample(x=c(0,1),size=1, prob = prob)
  }
  return(result)
}

predicted_classes_test_para  <- unlist(lapply(df_test$text, function(txt) algorithm_parameter(txt, prob_df_train)))
  
predicted_classes_val1_para  <- unlist(lapply(df_val1$text, function(txt) algorithm_parameter(txt, prob_df_train)))

predicted_classes_val2_para  <- unlist(lapply(df_val2$text, function(txt) algorithm_parameter(txt, prob_df_train)))


####################
# natural language #
####################

# 1. We check whether a natural language indicator of negative results is 
# reported --> Mixed and Negative Results. parameter_negative_result returns
# TRUE for a list of predfined negative results
# 2. We check whether a natural language indicator of positive results is 
# reported --> Positive Results Only. Parameter_positive_result returns TRUE
# for a list of predfined positive results
# 3. If no condition is met, we randomly sample a class label

algorithm_natural_language<-function(text,prob){
  if(natural_language_negative_result(text)==TRUE){
    result=0
  }else if(natural_language_positive_result(text)==TRUE){
    result=1
  }else{
    result=sample(x=c(0,1),size=1, prob = prob)
  }
  return(result)
}

predicted_classes_test_nl  <- unlist(lapply(df_test$text, function(txt) algorithm_natural_language(txt, prob_df_train)))

predicted_classes_val1_nl  <- unlist(lapply(df_val1$text, function(txt) algorithm_natural_language(txt, prob_df_train)))

predicted_classes_val2_nl  <- unlist(lapply(df_val2$text, function(txt) algorithm_natural_language(txt, prob_df_train)))