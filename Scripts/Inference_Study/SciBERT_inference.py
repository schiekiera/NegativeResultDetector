# Transformers installation
!pip install transformers datasets evaluate
!pip install transformers[torch]

## load datasets
from datasets import load_dataset

## github urls
url_inference = 'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Inference/inference_2023-09-28.csv?raw=true'

## load datasets
dataset_inf = load_dataset('csv',data_files={'inference': url_inference})

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
tokenized_full_inf = dataset_inf.map(preprocess_function, batched=True)

# Load Model
from transformers import AutoModelForSequenceClassification, Trainer
model = AutoModelForSequenceClassification.from_pretrained(f"ClinicalMetaScience/NegativeResultDetector")

# Initialize the trainer
trainer_best = Trainer(
    model=model,
    tokenizer=tokenizer,
)

## Predict test data
predict_inf=trainer_best.predict(tokenized_full_inf["inference"])

predictions_inf=np.argmax(predict_inf.predictions, axis=1)
predict_inf.predictions

data_pred_inf = {
    'text': dataset_inf["inference"]["text"],
    'predictions_proba_0': predict_inf.predictions[:,0],
    'predictions_proba_1': predict_inf.predictions[:,1],
    'predictions_binary': predictions_inf
}