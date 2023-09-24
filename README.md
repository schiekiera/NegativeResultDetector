# PubBiasDetect
Documentation, code and data for the project "Publication Bias Research in Clincial Psychology Using Natural Language Processing" by Louis Schiekiera

![alt text](https://github.com/PsyCapsLock/PubBiasDetect/blob/main/img/inference_longitudinal_comparison.jpg?raw=true)


## Table of Contents

- [Abstract](#abstract)
- [Results](#results)



## Abstract  
**Background:** To address the gap in machine learning tools for publication bias research, we classify scientific abstracts from clinical psychology and psychotherapy using natural language processing.

**Methods:** We annotated over 1,900 abstracts into two categories: "positive results only" and "mixed and negative results", and trained models using random forest and SciBERT. These models were validated against one in-domain and two out-of-domain data sets comprising psychotherapy abstracts. We compared model performance with three benchmarks: natural language indicators of result types, *p*-values, and abstract length. We then utilized the best-performing model to analyze trends in result types of over 21,000 psychotherapy abstracts. We hypothesized a linear increase in abstracts reporting solely positive results from 1990 to 2004, and a linear decrease from 2005 to 2023 due to methodological debates around false-positive results. We fitted logistic regression models to predict trends in result types.

**Results:** SciBERT outperformed all benchmarks and random forest in in-domain (accuracy: 0.86) and out-of-domain data (accuracy: 0.85-0.88). Results from the trend analysis revealed non-significant effects of publication year for both periods, yet significant positive linear and negative quadratic effects over the entire span. The "positive results only" proportion rose from the early 1990s to the early 2010s, declining slightly until the early 2020s. In line with this, we observed a similar pattern for "*p* > .05" and "*p* < .05", but no significant trend for natural language indicators.

**Discussion:** Machine learning models could be crucial in future efforts to understand and address publication bias.

 
   
## Results

|                  | Accuracy <td colspan=3>triple Mixed & Negative Results <td colspan=3>triple Positive Results Only 
|                  |          | F1| Recall | Precision | F1| Recall | Precision |
| SciBERT          | **0.864**|**0.867**|**0.907**|**0.830**|**0.860**|**0.822**|**0.902**|
| Random Forest    | 0.803    | 0.810 | 0.856   | 0.769   | 0.796   | 0.752   | 0.844   |
| Extracted *p*-values | 0.515| 0.495 | 0.485   | 0.505   | 0.534   | 0.545   | 0.524   |
| Extracted NL Indicators | 0.530| 0.497 | 0.474   | 0.523   | 0.559   | 0.584   | 0.536   |
| Number of Words   | 0.475   | 0.441 | 0.423   | 0.461   | 0.505   | 0.525   | 0.486   |


Table: Different metric scores for model evaluation of test data from the annotated `MAIN` corpus, consisting of *n* = 198 abstracts authored by researchers affiliated with German clinical psychology departments and published between 2012 and 2023


![alt text](https://github.com/PsyCapsLock/PubBiasDetect/blob/main/img/barplot_results_models.jpg?raw=true)
Figure: Comparing model performances across in-domain and out-of-domain data; Colored bars represent different model types; Samples: `MAIN` test: n = 198 abstracts; `VAL1`: n = 150 abstracts; `VAL2`: n = 150 abstracts.