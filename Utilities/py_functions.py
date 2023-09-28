import os
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.colors import ListedColormap
import numpy as np
from sklearn.utils import resample
import re

def paste_and_list(path_x, pattern_x):
    files = [f for f in os.listdir(path_x) if os.path.isfile(os.path.join(path_x, f)) and pattern_x in f]
    pasted_path = [os.path.join(path_x, f) for f in files]
    pasted_path = re.sub(r"\\", "/", pasted_path[0])
    return pasted_path

def function1(x):
    y=x-1
    return y

# K-Fold Cross-Validation
from sklearn.model_selection import cross_validate
def cross_validation(model, _X, _y, _cv=5):
      '''Function to perform 5 Folds Cross-Validation
       Parameters
       ----------
      model: Python Class, default=None
              This is the machine learning algorithm to be used for training.
      _X: array
           This is the matrix of features.
      _y: array
           This is the target variable.
      _cv: int, default=5
          Determines the number of folds for cross-validation.
       Returns
       -------
       The function returns a dictionary containing the metrics 'accuracy', 'precision',
       'recall', 'f1' for both training set and validation set.
      '''
      _scoring = ['accuracy', 'precision', 'recall', 'f1']
      results = cross_validate(estimator=model,
                               X=_X,
                               y=_y,
                               cv=_cv,
                               scoring=_scoring,
                               return_train_score=True)
      
      return {"Training Accuracy scores": results['train_accuracy'],
              "Mean Training Accuracy": results['train_accuracy'].mean()*100,
              "Training Precision scores": results['train_precision'],
              "Mean Training Precision": results['train_precision'].mean(),
              "Training Recall scores": results['train_recall'],
              "Mean Training Recall": results['train_recall'].mean(),
              "Training F1 scores": results['train_f1'],
              "Mean Training F1 Score": results['train_f1'].mean(),
              "Validation Accuracy scores": results['test_accuracy'],
              "Mean Validation Accuracy": results['test_accuracy'].mean()*100,
              "Validation Precision scores": results['test_precision'],
              "Mean Validation Precision": results['test_precision'].mean(),
              "Validation Recall scores": results['test_recall'],
              "Mean Validation Recall": results['test_recall'].mean(),
              "Validation F1 scores": results['test_f1'],
              "Mean Validation F1 Score": results['test_f1'].mean()
              }


# Grouped Bar Chart for both training and validation data
def plot_result(x_label, y_label, plot_title, train_data, val_data):
        '''Function to plot a grouped bar chart showing the training and validation
          results of the ML model in each fold after applying K-fold cross-validation.
         Parameters
         ----------
         x_label: str, 
            Name of the algorithm used for training e.g 'Decision Tree'
          
         y_label: str, 
            Name of metric being visualized e.g 'Accuracy'
         plot_title: str, 
            This is the title of the plot e.g 'Accuracy Plot'
         
         train_result: list, array
            This is the list containing either training precision, accuracy, or f1 score.
        
         val_result: list, array
            This is the list containing either validation precision, accuracy, or f1 score.
         Returns
         -------
         The function returns a Grouped Barchart showing the training and validation result
         in each fold.
        '''
        
        # Set size of plot
        plt.figure(figsize=(12,6))
        labels = ["1st Fold", "2nd Fold", "3rd Fold", "4th Fold", "5th Fold"]
        X_axis = np.arange(len(labels))
        ax = plt.gca()
        plt.ylim(0.40000, 1)
        plt.bar(X_axis-0.2, train_data, 0.4, color='blue', label='Training')
        plt.bar(X_axis+0.2, val_data, 0.4, color='red', label='Validation')
        plt.title(plot_title, fontsize=30)
        plt.xticks(X_axis, labels)
        plt.xlabel(x_label, fontsize=14)
        plt.ylabel(y_label, fontsize=14)
        plt.legend()
        plt.grid(True)
        plt.show()



def balanced_class_size_data_set(df, vec):
    # Determine the minimum class size
    min_class_size = df[vec].value_counts().min()
    
    # Create a list of indices for the smallest class
    smallest_class_indices = df[df[vec] == df[vec].value_counts().idxmin()].index.tolist()
    
    # Create a dictionary of indices for all other classes
    class_indices = {}
    for class_label in df[vec].unique():
        if class_label != df[vec].value_counts().idxmin():
            class_indices[class_label] = df[df[vec] == class_label].index.tolist()
    
    # Randomly sample from each class to create a balanced dataset
    sample_indices = smallest_class_indices.copy()
    for class_label, indices in class_indices.items():
        sample_indices += np.random.choice(indices, size=min_class_size, replace=False).tolist()
    
    # Create a new dataframe using the sampled indices
    df2 = df.loc[sample_indices].reset_index(drop=True)
    
    return df2


def plot_decision_regions(X, y, classifier, resolution=0.02):

    # setup marker generator and color map
    markers = ('o', 's', '^', 'v', '<')
    colors = ('red', 'blue', 'lightgreen', 'gray', 'cyan')
    cmap = ListedColormap(colors[:len(np.unique(y))])

    # plot the decision surface
    x1_min, x1_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    x2_min, x2_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx1, xx2 = np.meshgrid(np.arange(x1_min, x1_max, resolution),
                           np.arange(x2_min, x2_max, resolution))
    lab = classifier.predict(np.array([xx1.ravel(), xx2.ravel()]).T)
    lab = lab.reshape(xx1.shape)
    plt.contourf(xx1, xx2, lab, alpha=0.3, cmap=cmap)
    plt.xlim(xx1.min(), xx1.max())
    plt.ylim(xx2.min(), xx2.max())

    # plot class examples
    for idx, cl in enumerate(np.unique(y)):
        plt.scatter(x=X[y == cl, 0], 
                    y=X[y == cl, 1],
                    alpha=0.8, 
                    c=colors[idx],
                    marker=markers[idx], 
                    label=f'Class {cl}', 
                    edgecolor='black')



## downsampling
def downsampling(df, target_col):
    class_0_indices = np.where(df[target_col] == 0)[0]
    class_1_indices = np.where(df[target_col] == 1)[0]
    
    if len(class_0_indices) > len(class_1_indices):
        downsampled_indices = resample(class_0_indices, replace=False, n_samples=len(class_1_indices))
        downsampled_indices = np.concatenate((downsampled_indices, class_1_indices))
    elif len(class_1_indices) > len(class_0_indices):
        downsampled_indices = resample(class_1_indices, replace=False, n_samples=len(class_0_indices))
        downsampled_indices = np.concatenate((downsampled_indices, class_0_indices))
    else:
        return df
    
    downsampled_df = df.iloc[downsampled_indices]
    print(downsampled_df[target_col].value_counts())
    return downsampled_df

## oversampling
def oversampling(df, target_col):
    class_0_indices = np.where(df[target_col] == 0)[0]
    class_1_indices = np.where(df[target_col] == 1)[0]
    
    if len(class_0_indices) > len(class_1_indices):
        oversampled_indices = resample(class_1_indices, replace=True, n_samples=len(class_0_indices))
        oversampled_indices = np.concatenate((oversampled_indices, class_0_indices))
    elif len(class_1_indices) > len(class_0_indices):
        oversampled_indices = resample(class_0_indices, replace=True, n_samples=len(class_1_indices))
        oversampled_indices = np.concatenate((oversampled_indices, class_1_indices))
    else:
        return df
    
    oversampled_df = df.iloc[oversampled_indices]
    print(oversampled_df[target_col].value_counts())
    return oversampled_df



def get_files(path):
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file