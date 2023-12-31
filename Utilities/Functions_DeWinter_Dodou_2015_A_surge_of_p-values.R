
## libraries
library(devtools)
library(rentrez)
library(stringr)
library(xml2)
library(tidyverse)
library(writexl)
library(readxl)
library(cld2)
library(dplyr)
library(tidyr)
library(report)
library(lme4)


# Text data
text_data <- c(
  '2. <0.001 ABS({p < 0.001} OR {p < .001} OR {p <= 0.001} OR {p <= .001} OR {p ≤ 0.001} OR {p ≤ .001}) SIG(positive) PARAMETER(TRUE)',
  '3. >0.001 ABS({p > 0.001} OR {p > .001}) SIG(negative) PARAMETER(TRUE)',
  '4. <0.01 ABS({p < 0.01} OR {p < .01} OR {p <= 0.01} OR {p <= .01} OR {p ≤ 0.01} OR {p ≤ .01}) SIG(positive) PARAMETER(TRUE)',
  '5. >0.01 ABS({p > 0.01} OR {p > .01}) SIG(negative) PARAMETER(TRUE)',
  '6. <0.05 ABS({p < 0.05} OR {p < .05} OR {p <= 0.05} OR {p <= .05} OR {p ≤ 0.05} OR {p ≤ .05}) SIG(positive) PARAMETER(TRUE)',
  '7. >0.05 ABS({p > 0.05} OR {p > .05}) SIG(negative) PARAMETER(TRUE)',
  '8. <0.10 ABS({p < 0.10} OR {p < .10} OR {p <= 0.10} OR {p <= .10} OR {p ≤ 0.10} OR {p ≤ .10}) SIG(positive) PARAMETER(TRUE)',
  '9. >0.10 ABS({p > 0.10} OR {p > .10}) SIG(negative) PARAMETER(TRUE)',
  '10. =0.001 ABS({p = 0.001} OR {p = .001}) SIG(positive) PARAMETER(TRUE)',
  '11. 0.002–0.005 ABS({p = 0.002} OR {p = .002} OR {p = 0.003} OR {p = .003} OR {p = 0.004} OR {p = .004} OR {p = 0.005} OR {p = .005}) SIG(positive) PARAMETER(TRUE)',
  '12. 0.006–0.009 ABS({p = 0.006} OR {p = .006} OR {p = 0.007} OR {p = .007} OR {p = 0.008} OR {p = .008} OR {p = 0.009} OR {p = .009}) SIG(positive) PARAMETER(TRUE)',
  '13. 0.011–0.019 ABS({p = 0.011} OR {p = .011} OR {p = 0.012} OR {p = .012} OR {p = 0.013} OR {p = .013} OR {p = 0.014} OR {p = .014} OR {p = 0.015} OR {p = .015} OR {p = 0.016} OR {p = .016} OR {p = 0.017} OR {p = .017} OR {p = 0.018} OR {p = .018} OR {p = 0.019} OR {p = .019}) SIG(positive) PARAMETER(TRUE)',
  '14. 0.021–0.029 ABS({p = 0.021} OR {p = .021} OR {p = 0.022} OR {p = .022} OR {p = 0.023} OR {p = .023} OR {p = 0.024} OR {p = .024} OR {p = 0.025} OR {p = .025} OR {p = 0.026} OR {p = .026} OR {p = 0.027} OR {p = .027} OR {p = 0.028} OR {p = .028} OR {p = 0.029} OR {p = .029}) SIG(positive) PARAMETER(TRUE)',
  '15. 0.031–0.039 ABS({p = 0.031} OR {p = .031} OR {p = 0.032} OR {p = .032} OR {p = 0.033} OR {p = .033} OR {p = 0.034} OR {p = .034} OR {p = 0.035} OR {p = .035} OR {p = 0.036} OR {p = .036}  OR {p = 0.037} OR {p = .037} OR {p = 0.038} OR {p = .038} OR {p = 0.039} OR {p = .039}) SIG(positive) PARAMETER(TRUE)',
  '16. 0.041–0.049 ABS({p = 0.041} OR {p = .041} OR {p = 0.042} OR {p = .042} OR {p = 0.043} OR {p = .043} OR {p = 0.044} OR {p = .044} OR {p = 0.045} OR {p = .045} OR {p = 0.046} OR {p = .046} OR {p = 0.047} OR {p = .047} OR {p = 0.048} OR {p = .048} OR {p = 0.049} OR {p = .049}) SIG(positive) PARAMETER(TRUE)',
  '17. 0.051–0.059 ABS({p = 0.051} OR {p = .051} OR {p = 0.052} OR {p = .052} OR {p = 0.053} OR {p = .053} OR {p = 0.054} OR {p = .054} OR {p = 0.055} OR {p = .055} OR {p = 0.056} OR {p = .056}  OR {p = 0.057} OR {p = .057} OR {p = 0.058} OR {p = .058} OR {p = 0.059} OR {p = .059}) SIG(negative) PARAMETER(TRUE)',
  '18. 0.061–0.069 ABS({p = 0.061} OR {p = .061} OR {p = 0.062} OR {p = .062} OR {p = 0.063} OR {p = .063} OR {p = 0.064} OR {p = .064} OR {p = 0.065} OR {p = .065} OR {p = 0.066} OR {p = .066} OR {p = 0.067} OR {p = .067} OR {p = 0.068} OR {p = .068} OR {p = 0.069} OR {p = .069}) SIG(negative) PARAMETER(TRUE)',
  '19. 0.071–0.079 ABS({p = 0.071} OR {p = .071} OR {p = 0.072} OR {p = .072} OR {p = 0.073} OR {p = .073} OR {p = 0.074} OR {p = .074} OR {p = 0.075} OR {p = .075} OR {p = 0.076} OR {p = .076} OR {p = 0.077} OR {p = .077} OR {p = 0.078} OR {p = .078} OR {p = 0.079} OR {p = .079}) SIG(negative) PARAMETER(TRUE)',
  '20. 0.081–0.089 ABS({p = 0.081} OR {p = .081} OR {p = 0.082} OR {p = .082} OR {p = 0.083} OR {p = .083} OR {p = 0.084} OR {p = .084} OR {p = 0.085} OR {p = .085} OR {p = 0.086} OR {p = .086} OR {p = 0.087} OR {p = .087} OR {p = 0.088} OR {p = .088} OR {p = 0.089} OR {p = .089}) SIG(negative) PARAMETER(TRUE)',
  '21. 0.091–0.099 ABS({p = 0.091} OR {p = .091} OR {p = 0.092} OR {p = .092} OR {p = 0.093} OR {p = .093} OR {p = 0.094} OR {p = .094} OR {p = 0.095} OR {p = .095} OR {p = 0.096} OR {p = .096} OR {p = 0.097} OR {p = .097} OR {p = 0.098} OR {p = .098} OR {p = 0.099} OR {p = .099}) SIG(negative) PARAMETER(TRUE)',
  '22. 0.01 ABS({p = 0.010} OR {p = .010} OR {p = 0.01} OR {p = .01}) SIG(positive) PARAMETER(TRUE)',
  '23. 0.02 ABS({p = 0.020} OR {p = .020} OR {p = 0.02} OR {p = .02}) SIG(positive) PARAMETER(TRUE)',
  '24. 0.03 ABS({p = 0.030} OR {p = .030} OR {p = 0.03} OR {p = .03}) SIG(positive) PARAMETER(TRUE)',
  '25. 0.04 ABS({p = 0.040} OR {p = .040} OR {p = 0.04} OR {p = .04}) SIG(positive) PARAMETER(TRUE)',
  '26. 0.05 ABS({p = 0.050} OR {p = .050} OR {p = 0.05} OR {p = .05}) SIG(negative) PARAMETER(TRUE)',
  '27. 0.06 ABS({p = 0.060} OR {p = .060} OR {p = 0.06} OR {p = .06}) SIG(negative) PARAMETER(TRUE)',
  '28. 0.07 ABS({p = 0.070} OR {p = .070} OR {p = 0.07} OR {p = .07}) SIG(negative) PARAMETER(TRUE)',
  '29. 0.08 ABS({p = 0.080} OR {p = .080} OR {p = 0.08} OR {p = .08}) SIG(negative) PARAMETER(TRUE)',
  '30. 0.09 ABS({p = 0.090} OR {p = .090} OR {p = 0.09} OR {p = .09}) SIG(negative) PARAMETER(TRUE)',
  '31. p = NS or p = N.S. ABS({p = NS} OR {p = N.S.}) SIG(negative) PARAMETER(TRUE)',
  '32. “significant difference(s)” ABS(({significant difference} OR {significant differences} OR {significantly different} OR {differed significantly}) AND NOT ({no significant difference} OR {no significant differences} OR {no statistically significant difference} OR {no statistically significant differences} OR {not significantly different} OR {did not differ significantly})) SIG(positive) PARAMETER(FALSE)',
  '33. “no significant difference(s)” ABS({no significant difference} OR {no significant differences} OR {no statistically significant difference} OR {no statistically significant differences} OR {not significantly different} OR {did not differ significantly}) SIG(negative) PARAMETER(FALSE)',
  '34. “significant effect(s)” ABS(({significant effect} OR {significant effects}) AND NOT ({no significant effect} OR {no significant effects} OR {no statistically significant effect} OR {no statistically significant effects} OR {not a significant effect} OR {not a statistically significant effect})) SIG(positive) PARAMETER(FALSE)',
  '35. “no significant effect(s)” ABS({no significant effect} OR {no significant effects} OR {no statistically significant effect} OR {no statistically significant effects} OR {not a significant effect} OR {not a statistically significant effect}) SIG(negative) PARAMETER(FALSE)',
  '36. “supports the hypothesis” ABS(({supports the hypothesis} OR {support the hypothesis} OR {supports our hypothesis} OR {support our hypothesis} ) AND NOT ({does not support the hypothesis} OR {do not support the hypothesis} OR {does not support our hypothesis} OR {do not support our hypothesis})) SIG(positive) PARAMETER(FALSE)',
  '37. “does not support the hypothesis” ABS({does not support the hypothesis} OR {do not support the hypothesis} OR {does not support our hypothesis} OR {do not support our hypothesis}) SIG(negative) PARAMETER(FALSE)',
  '38. “significantly higher/more” ABS({significantly higher} OR {significantly more}) SIG(positive) PARAMETER(FALSE)',
  '39. “significantly lower/less” ABS({significantly lower} OR {significantly less}) SIG(positive) PARAMETER(FALSE)',
  '40. “marginally significant” ABS(marginally significant) SIG(positive) PARAMETER(FALSE)',
  '41. “important finding” ABS(important finding OR important findings) SIG(positive) PARAMETER(FALSE)',
  '42. 0.1 ABS({p = 0.1} OR {p = .10} OR {p = .1}) SIG(negative) PARAMETER(TRUE)',
  '43. 0.2 ABS({p = 0.2} OR {p = .20} OR {p = .2}) SIG(negative) PARAMETER(TRUE)',
  '44. 0.3 ABS({p = 0.3} OR {p = .30} OR {p = .3}) SIG(negative) PARAMETER(TRUE)',
  '45. 0.4 ABS({p = 0.4} OR {p = .40} OR {p = .4}) SIG(negative) PARAMETER(TRUE)',
  '46. 0.5 ABS({p = 0.5} OR {p = .50} OR {p = .5}) SIG(negative) PARAMETER(TRUE)',
  '47. 0.6 ABS({p = 0.6} OR {p = .60} OR {p = .6}) SIG(negative) PARAMETER(TRUE)',
  '48. 0.7 ABS({p = 0.7} OR {p = .70} OR {p = .7}) SIG(negative) PARAMETER(TRUE)',
  '49. 0.8 ABS({p = 0.8} OR {p = .80} OR {p = .8}) SIG(negative) PARAMETER(TRUE)',
  '50. 0.9 ABS({p = 0.9} OR {p = .90} OR {p = .9}) SIG(negative) PARAMETER(TRUE)')

  

# Create a dataframe
df <- data.frame(
  index = 1:length(text_data),
  tag = sub(" .*", "", text_data),
  # Extract the tag
  query = sub(".*? ABS\\((.*?)\\) SIG.*", "\\1", text_data),
  # Extract the query
  significance = sub(".*SIG\\((.*?)\\).*", "\\1", text_data),
  # Extract the significance
  parameter = sub(".*PARAMETER\\((.*?)\\)", "\\1", text_data) # Extract the parameter
)


## Processing
transform_query_vector <- function(input_vector) {
  # Split the input vector using " OR " or " AND NOT " as separators
  pattern_lists <- strsplit(input_vector, " OR | AND NOT ")
  
  # Unlist the resulting list to create a vector
  pattern_vector <- unlist(pattern_lists)
  
  # Remove "{" and "}" characters
  pattern_vector <- gsub("[{}]", "", pattern_vector)
  
  # Remove "(" and ")" characters
  pattern_vector <- gsub("[()]", "", pattern_vector)
  
  # Return the transformed pattern vector
  return(pattern_vector)
}


# extract all queries
pattern_vector <- transform_query_vector(df$query)

# para:
df_para <- df[df$parameter == TRUE,]
pattern_vector_para <- transform_query_vector(df_para$query)

# para: sig
df_para_sig <- df_para[df_para$significance == "positive", ]
pattern_vector_para_sig <- transform_query_vector(df_para_sig$query)

# para: nsig
df_para_nsig <- df_para[df_para$significance == "negative", ]
pattern_vector_para_nsig <- transform_query_vector(df_para_nsig$query)

# natural language
df_nl <- df[df$parameter == FALSE, ]

# nl: sig
df_nl_sig <- df_nl[df_nl$significance == "positive", ]
pattern_vector_nl_sig <- transform_query_vector(df_nl_sig$query)
pattern_vector_nl_sig_part_nsig <-
  pattern_vector_nl_sig[str_detect(pattern_vector_nl_sig, "no |not ") == TRUE]
pattern_vector_nl_sig_part_sig <-
  pattern_vector_nl_sig[str_detect(pattern_vector_nl_sig, "no |not ") == FALSE]

# nl: nsig
df_nl_nsig <- df_nl[df_nl$significance == "negative", ]
pattern_vector_nl_nsig <- transform_query_vector(df_nl_nsig$query)



###############
## Functions ##
###############


####################################
## parameter extraction functions ##
####################################
# apply to single string
parameter_positive_result_scalar <- function(string) {
  check <- any(str_detect(string = string,
                          pattern = regex(pattern_vector_para_sig,
                                          ignore_case = TRUE)))
  return(check)
}
parameter_negative_result_scalar <- function(string) {
  check <- any(str_detect(string = string,
                          pattern = regex(pattern_vector_para_nsig,
                                          ignore_case = TRUE)))
  return(check)
}
# output functions: apply scalar "check" to whole list --> turn into vector
parameter_positive_result <- function(input_vector) {
  output_vector <-
    unlist(lapply(input_vector, parameter_positive_result_scalar))
  return(output_vector)
}
parameter_negative_result <- function(input_vector) {
  output_vector <-
    unlist(lapply(input_vector, parameter_negative_result_scalar))
  return(output_vector)
}



################################
## natural language functions ##
################################

# apply to single string
natural_language_positive_result_scalar <- function(string) {
  check <- any(str_detect(
    string = string,
    pattern = regex(pattern_vector_nl_sig_part_sig,
                    ignore_case = TRUE)
  )) &
    !any(str_detect(string = string,
                    regex(pattern = pattern_vector_nl_sig_part_nsig,
                          ignore_case = TRUE)))
  return(check)
}
natural_language_negative_result_scalar <- function(string) {
  check <- any(str_detect(string = string,
                          regex(pattern = pattern_vector_nl_nsig,
                                ignore_case = TRUE)))
  return(check)
}
# output functions: apply scalar "check" to whole list --> turn into vector
natural_language_positive_result <- function(input_vector) {
  output_vector <-
    unlist(lapply(input_vector, natural_language_positive_result_scalar))
  return(output_vector)
}
natural_language_negative_result <- function(input_vector) {
  output_vector <-
    unlist(lapply(input_vector, natural_language_negative_result_scalar))
  return(output_vector)
}

## Examples to show that functions work

#####################
# parameter example #
#####################
example_parameter<-c("P = 0.01","P = 0.09","P = 0.9","P = 0.009")

# parameter:positive
parameter_positive_result(example_parameter)

# parameter: negative
parameter_negative_result(example_parameter)


############################
# natural language example #
############################
example_natural_language<-c("No SiGNifIcant DiffErEnce",
                            "SiGNifIcant DiffErEnce",
                            "significantly different")

# parameter:positive
natural_language_positive_result(example_natural_language)

# parameter: negative
natural_language_negative_result(example_natural_language)
