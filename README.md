# PubBiasDetect
Documentation, code and data for the project "Publication Bias Research in Clincial Psychology Using Natural Language Processing" by Louis Schiekiera

## Table of Contents

- [Abstract](#abstract)
- [Preliminary Results](#results)




 


## Abstract
> **Background:** Publication bias (PB) leads to the overrepresentation of positive results in psychological science, creating issues like inflated effect sizes and replication problems. Although awareness about this bias has increased in the wake of the replication crisis, the prevalence of negative or mixed results hasn't been thoroughly explored. This study aims to fill this gap and facilitate research synthesis using Natural Language Processing (NLP) tools, rather than relying on time and resource-consuming manual classification.
> **Methods:** We will classify and evaluate 2,469 abstracts from clinical psychology research using supervised machine learning models like Random Forest and SciBERT, trained on human-annotated data. The performance of these models will be validated against other abstract sets. Using these models, we aim to predict the positivity of results in a large sample of unannotated abstracts dating from 1990 to 2023, helping us to explore if open science trends align with an increase in negative or mixed results.
> **Results:** Our preliminary results indicate that the SciBERT model outperforms the other models in accuracy, providing promising groundwork for further research and implementation.
 
   
## Preliminary Results
|              | Accuracy | F1   | Recall | Precision | F1    | Recall | Precision |
|--------------|----------|------|--------|-----------|-------|--------|-----------|
| SciBERT      | 0.924    | 0.925| 0.925  | 0.925     | 0.923 | 0.923  | 0.923     |
| RF           | 0.811    | 0.821| 0.796  | 0.847     | 0.800 | 0.829  | 0.773     |
| Text Length  | 0.544    | 0.587| 0.621  | 0.557     | 0.490 | 0.459  | 0.525     |
