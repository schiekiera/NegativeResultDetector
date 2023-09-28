# Remove data
rm(list = ls())

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

# Naive Abstract length classification model
# Abbreviation: _tl
## create variables nword --> Number of Words of abstract
df_train$nword<-lengths(strsplit(df_train$text, ' '))
df_test$nword<-lengths(strsplit(df_test$text, ' '))
df_val1$nword<-lengths(strsplit(df_val1$text, ' '))
df_val2$nword<-lengths(strsplit(df_val2$text, ' '))


# model with text length as predictor
m_train_tl <- glm(label ~ nword, data = df_train, family = binomial)

# predict label
predictions_test_tl <-
  predict(m_train_tl, newdata = df_test, type = "response")
predictions_val1_tl <-
  predict(m_train_tl, newdata = df_val1, type = "response")
predictions_val2_tl <-
  predict(m_train_tl, newdata = df_val2, type = "response")

predicted_classes_test_tl <-
  ifelse(predictions_test_tl > 0.5, 1, 0)
predicted_classes_val1_tl <-
  ifelse(predictions_val1_tl > 0.5, 1, 0)
predicted_classes_val2_tl <-
  ifelse(predictions_val2_tl > 0.5, 1, 0)
