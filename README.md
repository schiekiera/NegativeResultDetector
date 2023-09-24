# PubBiasDetect
Documentation, code and data for the project "Publication Bias Research in Clincial Psychology Using Natural Language Processing" by Louis Schiekiera

## Table of Contents

- [Abstract](#abstract)
- [Results](#results)



## Abstract  
**Background:** To address the gap in machine learning tools for publication bias research, we classify scientific abstracts from clinical psychology and psychotherapy using natural language processing.

**Methods:** We annotated over 1,900 abstracts into two categories: "positive results only" and "mixed and negative results", and trained models using random forest and SciBERT. These models were validated against one in-domain and two out-of-domain data sets comprising psychotherapy abstracts. We compared model performance with three benchmarks: natural language indicators of result types, *p*-values, and abstract length. We then utilized the best-performing model to analyze trends in result types of over 21,000 psychotherapy abstracts. We hypothesized a linear increase in abstracts reporting solely positive results from 1990 to 2004, and a linear decrease from 2005 to 2023 due to methodological debates around false-positive results. We fitted logistic regression models to predict trends in result types.

**Results:** SciBERT outperformed all benchmarks and random forest in in-domain (accuracy: 0.86) and out-of-domain data (accuracy: 0.85-0.88). Results from the trend analysis revealed non-significant effects of publication year for both periods, yet significant positive linear and negative quadratic effects over the entire span. The "positive results only" proportion rose from the early 1990s to the early 2010s, declining slightly until the early 2020s. In line with this, we observed a similar pattern for "*p* > .05" and "*p* < .05", but no significant trend for natural language indicators.

**Discussion:** Machine learning models could be crucial in future efforts to understand and address publication bias.

 
   
## Results

![alt text](https://github.com/PsyCapsLock/PubBiasDetect/blob/main/img/barplot_results_models.jpg?raw=true)



|              | Accuracy | F1   | Recall | Precision | F1    | Recall | Precision |
|--------------|----------|------|--------|-----------|-------|--------|-----------|
| SciBERT      | 0.924    | 0.925| 0.925  | 0.925     | 0.923 | 0.923  | 0.923     |
| RF           | 0.811    | 0.821| 0.796  | 0.847     | 0.800 | 0.829  | 0.773     |
| Text Length  | 0.544    | 0.587| 0.621  | 0.557     | 0.490 | 0.459  | 0.525     |
