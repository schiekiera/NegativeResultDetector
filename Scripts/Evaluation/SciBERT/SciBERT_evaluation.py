# Transformers installation
!pip install transformers datasets evaluate
!pip install transformers[torch]


## huggingface hub login
from huggingface_hub import notebook_login
notebook_login()

## load data
from datasets import load_dataset
 

## github urls
url_test =    'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/test_2023-07-26.csv?raw=true'
url_valid_1990 =  'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Validation/validation_1_1990-2012_2023-07-28.csv?raw=true'
url_valid_ng =  'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Validation/validation_2_nongerman_2023-07-28.csv?raw=true'


## load datasets
dataset = load_dataset('csv', data_files={'test': url_test,
                                          'valid_1990': url_valid_1990,
                                          'valid_ng': url_valid_ng})

## Preprocessing for Labels
# Mapping of labels to integer values
id2label = {0: "NEGATIVE", 1: "POSITIVE"}
label2id = {"NEGATIVE": 0, "POSITIVE": 1}

# Update dataset features for train, dev, test, valid_1990, and valid_ng
from datasets import ClassLabel, Value

def update_dataset_features(dataset_split):
    new_features = dataset[dataset_split].features.copy()
    new_features["label"] = Value("int64")
    new_features["label"] = ClassLabel(names=["negative", "positive"])
    dataset[dataset_split] = dataset[dataset_split].cast(new_features)

# Apply updates for each dataset split
update_dataset_features("test")
update_dataset_features("valid_1990")
update_dataset_features("valid_ng")

## load tokenizer
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained('allenai/scibert_scivocab_uncased')

## preprocess
def preprocess_function(examples):
    return tokenizer(examples["text"],
                     truncation=True,
                     max_length=512,
                     padding='max_length'
                     )

## map preprocess_function to tokenized_data
tokenized_full = dataset.map(preprocess_function, batched=True)

# 3. Load Model
from transformers import Trainer, AutoModelForSequenceClassification
NegativeResultDetector = AutoModelForSequenceClassification.from_pretrained("ClinicalMetaScience/NegativeResultDetector")

## Initialize the trainer with the model and tokenizer
trainer_best = Trainer(
    model=NegativeResultDetector,
    tokenizer=tokenizer,
  )


## Import Metrics
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay, classification_report
import numpy as np
import matplotlib.pyplot as plt

###############
## TEST DATA ##
###############
## predict test
predict_test = trainer_best.predict(tokenized_full["test"])
y_pred = np.argmax(predict_test.predictions, axis=1)
y_test = predict_test.label_ids

## Report metrics
cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm)
disp.plot()
plt.show()
print(classification_report(y_test, y_pred,
                      digits=3))



###############
## VAL1 DATA ##
###############
## predict val1
predict_val1 = trainer_best.predict(tokenized_full["valid_ng"])
y_pred = np.argmax(predict_val1.predictions, axis=1)
y_test = predict_val1.label_ids

## Report metrics
cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm)
disp.plot()
plt.show()
print(classification_report(y_test, y_pred,
                        digits=3))


###############
## VAL2 DATA ##
###############
## predict val2
predict_val2 = trainer_best.predict(tokenized_full["valid_1990"])
y_pred = np.argmax(predict_val2.predictions, axis=1)
y_test = predict_val2.label_ids

## Report metrics
cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm)
disp.plot()
plt.show()
print(classification_report(y_test, y_pred,
                        digits=3))

