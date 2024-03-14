# NegativeResultDetector
Documentation, code and data for the study "Classifying Positive Results in Clinical Psychology Using Natural Language Processing" by Louis Schiekiera, Helen Niemeyer & Jonathan Diederichs. The preprint for is available on [PsyArxiv](https://osf.io/preprints/psyarxiv/uxyzh).

The best-performing model, SciBERT, was deployed under the name *'NegativeResultDetector'* on [HuggingFace](https://huggingface.co/ClinicalMetascience/NegativeResultDetector). It can be used directly via a graphical user interface for single abstract evaluations or for larger-scale inference by downloading the model files from HuggingFace, utilizing this [script](https://github.com/schiekiera/NegativeResultDetector/blob/main/Scripts/example_folder/Predict_Example_Abstracts_using_NegativeResultDetector.ipynb) from the GitHub repository.


## Table of Contents
- [Abstract](#abstract)
- [Results](#results)


## Abstract  
**Background:** This study addresses the gap in machine learning tools for positive results classification by evaluating the performance of SciBERT, a transformer model pretrained on scientific text, and random forest in clinical psychology abstracts. 

**Methods:** Over 1,900 abstracts were annotated into two categories: ‘positive results only’ and ‘mixed or negative results’. Model performance was evaluated on three benchmarks. The best-performing model was utilized to analyze trends in over 20,000 psychotherapy study abstracts.

**Results:** SciBERT outperformed all benchmarks and random forest in in-domain and out-of-domain data. The trend analysis revealed non-significant effects ofpublication year on positive results for 1990-2005, but a significant decrease in positive results between 2005-2022.  When examining the entire time-span, significant positive linear and negative quadratic effects were observed.

**Discussion:** Machine learning could support future efforts to understand patterns of positive results in large data sets. The fine-tuned SciBERT model was deployed for public use.

<br>

## Results
**Table 1** <br>
*Different metric scores for model evaluation of test data from the annotated `MAIN` corpus, consisting of *n* = 198 abstracts authored by researchers affiliated with German clinical psychology departments and published between 2012 and 2022*
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

<br>

**Figure 1** <br>
*Comparing model performances across in-domain and out-of-domain data; Colored bars represent different model types; Samples: `MAIN` test: n = 198 abstracts; `VAL1`: n = 150 abstracts; `VAL2`: n = 150 abstracts.*
![alt text](https://github.com/PsyCapsLock/NegativeResultDetector/blob/main/img/barplot_results_models.jpg?raw=true)

<br>

## Funding & Project
This study was conductet as part of the [PANNE Project](https://www.berlin-university-alliance.de/en/commitments/research-quality/project-list-20/panne/index.html) (German acronym for “publication bias analysis of non-publication and non-reception of results in a disciplinary comparison”) at Freie Universität Berlin and was funded by the Berlin University Alliance.
