# Remove data
rm(list = ls())

## libraries
library(tidyverse)
library(report)

# read data and functions

# github urls
url_function = 'https://github.com/PsyCapsLock/NegativeResultDetector/blob/main/Utilities/Functions.R?raw=true'
url_inference = 'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Results/predictions_all_approaches_inference.csv?raw=true'

# functions
source(url_function)

# data
df<-read_csv(url_inference)
## load 20,212 cases


# add quadratic and cubic terms
df$year_inverted<- -(df$year^2)
df$year_cubic<- df$year^3


# MODEL1: Hypothesis 1. Model Linear Term Year: 1990 - 2005
df1 <- df[df$year <= 2005, ]
model_1990_2005<-glm(scibert_predictions ~ year, data = df1, family = binomial())
report(model_1990_2005)

# MODEL2: Hypothesis 2. Model Linear Term Year: 2005 - 2022
df2 <- df[df$year >= 2005, ]
model_2005_2022<-glm(scibert_predictions ~ year, data = df2, family = binomial())
report(model_2005_2022)


# MODEL3a:  Base Model Linear Term: 1990 - 2022
model_1990_2022 <- glm(scibert_predictions ~ year, data = df, family = binomial())
report(model_1990_2022)
AIC(model_1990_2022)

# MODEL3b:  Quadratic Model : 1990 - 2022
model_1990_2022_quadratic<-glm(scibert_predictions ~ year + year_inverted , data = df, family = binomial(link="logit"))
report(model_1990_2022_quadratic)
AIC(model_1990_2022_quadratic)
BIC(model_1990_2022_quadratic)

# MODEL3c: Cubic + Quadratic Model : 1990 - 2022
model_1990_2022_cubic<-glm(scibert_predictions ~ year + year_inverted+ year_cubic , data = df, family = binomial(link="logit"))
report(model_1990_2022_cubic)
AIC(model_1990_2022_cubic)

# MODEL3d: Cubic + without Quadratic Model : 1990 - 2022
model_1990_2022_cubic_without_quadratic<-glm(scibert_predictions ~ year + year_cubic , data = df, family = binomial(link="logit"))
report(model_1990_2022_cubic_without_quadratic)
AIC(model_1990_2022_cubic_without_quadratic)
BIC(model_1990_2022_cubic_without_quadratic)

# Automated Approaches: Predicting detections of rule-based indicators

# MODEL4a: model_parameter_positive_result
model_parameter_positive_result<-glm(parameter_positive_result ~ year + year_inverted , data = df, family = binomial(link="logit"))
report(model_parameter_positive_result)

# MODEL4b: model_parameter_negative_result
model_parameter_negative_result<-glm(parameter_negative_result ~ year + year_inverted , data = df, family = binomial(link="logit"))
report(model_parameter_negative_result)

# MODEL4c:  model_natural_language_positive_result
model_natural_language_positive_result<-glm(natural_language_positive_result ~ year + year_inverted , data = df, family = binomial(link="logit"))
report(model_natural_language_positive_result)

# MODEL4d: model_natural_language_negative_result
model_natural_language_negative_result<-glm(natural_language_negative_result ~ year + year_inverted , data = df, family = binomial(link="logit"))
report(model_natural_language_negative_result)