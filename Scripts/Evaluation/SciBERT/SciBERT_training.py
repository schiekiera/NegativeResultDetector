# Transformers installation
!pip install transformers datasets evaluate
!pip install transformers[torch]


## huggingface hub login
from huggingface_hub import notebook_login
notebook_login()

## load data
from datasets import load_dataset

## github urls
url_train =       'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/train_2023-07-26.csv?raw=true'
url_dev =         'https://github.com/PsyCapsLock/PubBiasDetect/blob/main/Data/Train_Test_Dev/dev_2023-07-26.csv?raw=true'


## load datasets
dataset = load_dataset('csv', data_files={'train': url_train,
                                          'dev': url_dev})

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
update_dataset_features("train")
update_dataset_features("dev")

## load tokenizer
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained('allenai/scibert_scivocab_uncased')

## preprocess function
def preprocess_function(examples):
    return tokenizer(examples["text"],
                     truncation=True,
                     max_length=512,
                     padding='max_length'
                     )

## map preprocess function to dataset 
tokenized_full = dataset.map(preprocess_function, batched=True)

## load data collator
from transformers import DataCollatorWithPadding
data_collator = DataCollatorWithPadding(tokenizer=tokenizer)

## load accuracy
import evaluate
accuracy = evaluate.load("accuracy")

## metrics
from sklearn.metrics import precision_recall_fscore_support, accuracy_score
import numpy as np
def compute_metrics(eval_pred):
    predictions, labels = eval_pred
    predictions = np.argmax(predictions, axis=1)

    precision, recall, f1, _ = precision_recall_fscore_support(predictions, labels, average="weighted")
    acc = accuracy_score(labels, predictions)

    return {
        "accuracy": acc,
        "f1": f1,
        "precision": precision,
        "recall": recall
    }

# load model
from transformers import AutoModelForSequenceClassification
model = AutoModelForSequenceClassification.from_pretrained(
    "allenai/scibert_scivocab_uncased", num_labels=2, id2label=id2label, label2id=label2id
)

# training arguments
from transformers import TrainingArguments, Trainer

# Grid Search Parameters
learning_rates = [5e-6, 1e-5, 2e-5, 5e-5]
batch_sizes = [4, 8, 16]
random_seed = [1, 21, 42]

# Initialize best model variable and metric
count=0
best_model = None
best_accuracy = 0

for lr in learning_rates:
    for bs in batch_sizes:
        for rs in random_seed:

          # Set model name and add 1 to count
          count += 1
          model_name=f"NegativeResultDetector{count}_lr_{lr}_bs_{bs}_rs_{rs}"
          print(model_name)

          # Initialize the training arguments with the current learning rate and batch size
          training_args = TrainingArguments(
            output_dir=model_name,
            ## hyperparameters
            learning_rate=lr,
            per_device_train_batch_size=bs,
            per_device_eval_batch_size=bs,
            seed=rs,
            num_train_epochs=3,
            eval_steps=100,
            logging_steps=20,
            weight_decay=0.01,
            evaluation_strategy="epoch",
            save_strategy="epoch",
            fp16=True,
            save_total_limit=2,
            load_best_model_at_end=True,
            push_to_hub=True,
          )

          # Initialize the trainer with the current training arguments
          trainer = Trainer(
            model=model,
            args=training_args,
            train_dataset=tokenized_full["train"],
            eval_dataset=tokenized_full["dev"],
            tokenizer=tokenizer,
            data_collator=data_collator,
            compute_metrics=compute_metrics,
          )

          # Train the model
          trainer.train()

          # Evaluate the model
          metrics = trainer.evaluate()
          eval_acc=metrics['eval_accuracy']
          if eval_acc > best_accuracy:
              best_accuracy = eval_acc
              best_model = model_name

          # Check if the current model is better than the previous best model
          print(f"Current accuracy: {eval_acc};\nBest accuracy: {best_accuracy}\n")
          print(f"The best model is {best_model}\n")