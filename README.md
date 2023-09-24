# PubBiasDetect
Documentation, code and data for the project "Publication Bias Research in Clincial Psychology Using Natural Language Processing" by Louis Schiekiera.


## Table of Contents


- [Abstract](#abstract)
- [Results](#results)
- [Model](#model)



## Abstract  
**Background:** To address the gap in machine learning tools for publication bias research, we classify scientific abstracts from clinical psychology and psychotherapy using natural language processing.

**Methods:** We annotated over 1,900 abstracts into two categories: "positive results only" and "mixed and negative results", and trained models using random forest and SciBERT. These models were validated against one in-domain and two out-of-domain data sets comprising psychotherapy abstracts. We compared model performance with three benchmarks: natural language indicators of result types, *p*-values, and abstract length. We then utilized the best-performing model to analyze trends in result types of over 21,000 psychotherapy abstracts. We hypothesized a linear increase in abstracts reporting solely positive results from 1990 to 2004, and a linear decrease from 2005 to 2023 due to methodological debates around false-positive results. We fitted logistic regression models to predict trends in result types.

**Results:** SciBERT outperformed all benchmarks and random forest in in-domain (accuracy: 0.86) and out-of-domain data (accuracy: 0.85-0.88). Results from the trend analysis revealed non-significant effects of publication year for both periods, yet significant positive linear and negative quadratic effects over the entire span. The "positive results only" proportion rose from the early 1990s to the early 2010s, declining slightly until the early 2020s. In line with this, we observed a similar pattern for "*p* > .05" and "*p* < .05", but no significant trend for natural language indicators.

**Discussion:** Machine learning models could be crucial in future efforts to understand and address publication bias.

 
   
## Results

<table>
    <thead>
        <tr>
            <th rowspan="2"></th>
            <th rowspan="2">Accuracy</th>
            <th colspan="3">Mixed &amp; Negative Results</th>
            <th colspan="3">Positive Results Only</th>
        </tr>
        <tr>
            <th>F1</th>
            <th>Recall</th>
            <th>Precision</th>
            <th>F1</th>
            <th>Recall</th>
            <th>Precision</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SciBERT</td>
            <td><strong>0.864</strong></td>
            <td><strong>0.867</strong></td>
            <td><strong>0.907</strong></td>
            <td><strong>0.830</strong></td>
            <td><strong>0.860</strong></td>
            <td><strong>0.822</strong></td>
            <td><strong>0.902</strong></td>
        </tr>
        <tr>
            <td>Random Forest</td>
            <td>0.803</td>
            <td>0.810</td>
            <td>0.856</td>
            <td>0.769</td>
            <td>0.796</td>
            <td>0.752</td>
            <td>0.844</td>
        </tr>
        <tr>
            <td>Extracted <em>p</em>-values</td>
            <td>0.515</td>
            <td>0.495</td>
            <td>0.485</td>
            <td>0.505</td>
            <td>0.534</td>
            <td>0.545</td>
            <td>0.524</td>
        </tr>
        <tr>
            <td>Extracted NL Indicators</td>
            <td>0.530</td>
            <td>0.497</td>
            <td>0.474</td>
            <td>0.523</td>
            <td>0.559</td>
            <td>0.584</td>
            <td>0.536</td>
        </tr>
        <tr>
            <td>Number of Words</td>
            <td>0.475</td>
            <td>0.441</td>
            <td>0.423</td>
            <td>0.461</td>
            <td>0.505</td>
            <td>0.525</td>
            <td>0.486</td>
        </tr>
    </tbody>
</table>

**Table**: Different metric scores for model evaluation of test data from the annotated `MAIN` corpus, consisting of *n* = 198 abstracts authored by researchers affiliated with German clinical psychology departments and published between 2012 and 2023

<br>

![alt text](https://github.com/PsyCapsLock/PubBiasDetect/blob/main/img/barplot_results_models.jpg?raw=true)
**Figure**: Comparing model performances across in-domain and out-of-domain data; Colored bars represent different model types; Samples: `MAIN` test: n = 198 abstracts; `VAL1`: n = 150 abstracts; `VAL2`: n = 150 abstracts.

## Model
Model is available at [HuggingFace](https://huggingface.co/PsyCapsLock/PubBiasDetect).
