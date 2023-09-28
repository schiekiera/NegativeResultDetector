## standard libraries

import pandas as pd
import numpy as np
import re

# nltk
import nltk
from nltk.stem import WordNetLemmatizer
from nltk.corpus import wordnet
from nltk import pos_tag
from nltk.tokenize import word_tokenize
## download
nltk.download('wordnet')
nltk.download('averaged_perceptron_tagger')

def extract_results(df, column):
    # Start and end patterns
    start = ["RESULTS:", "INTERVENTIONS:", "MAIN OUTCOMES AND MEASURES:"]
    end = ["CONCLUSION:", "CONCLUSIONS:", "LIMITATIONS:",
           "DISCUSSION:", "DISCUSSION AND CONCLUSIONS:", "CONCLUSIONS AND RELEVANCE:",
           "DISCUSSION AND IMPLICATIONS:"]

    # Creating the list of patterns
    patterns = [f"{s}(.*?){e}" for s in start for e in end]

    # Find all matches for each pattern
    matches = [[re.findall(p, abstract, flags=re.IGNORECASE) for abstract in df[column]] for p in patterns]

    # Extract the matched substrings into a DataFrame
    df_results = pd.DataFrame(matches).transpose()

    # Creating a list of all results sections
    ls_check = df_results.apply(lambda row: [item for sublist in row for item in sublist if item], axis=1)

    # Store the shortest matching string in 'results' column of original DataFrame
    results = ls_check.apply(lambda x: min(x, key=len) if x else np.nan)
    
    return results


from nltk.corpus import wordnet
from nltk import pos_tag
from nltk.tokenize import word_tokenize

import nltk
nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')

def get_wordnet_pos(treebank_tag):
    """Map Treebank pos tags to WordNet pos tags"""
    if treebank_tag.startswith('J'):
        return wordnet.ADJ
    elif treebank_tag.startswith('V'):
        return wordnet.VERB
    elif treebank_tag.startswith('N'):
        return wordnet.NOUN
    elif treebank_tag.startswith('R'):
        return wordnet.ADV
    else:
        # Default to noun if the pos tag doesn't start with J, V, N, or R
        return wordnet.NOUN


def preprocess(X):
    documents = []
    lemmatizer = WordNetLemmatizer()

    for sen in range(0, len(X)):
        # Remove all the special characters
        document = re.sub(r'\W', ' ', str(X.iloc[sen]))

        # Remove single characters from the start
        document = re.sub(r'\^[a-zA-Z]\s+', ' ', document) 

        # Substituting multiple spaces with single space
        document = re.sub(r'\s+', ' ', document, flags=re.I)

        # Removing prefixed 'b'
        document = re.sub(r'^b\s+', '', document)

        # Converting to Lowercase
        document = document.lower()

        # Lemmatization
        # Tokenization and POS tagging
        tokens = word_tokenize(document)
        tagged_tokens = pos_tag(tokens)
        document = ' '.join([lemmatizer.lemmatize(word, get_wordnet_pos(pos)) for word, pos in tagged_tokens])

        documents.append(document)
        
    return documents


## functions for mapping notes to target values and raters

# Function to map notes to target values
def map_notes_to_target(note):
    if "neg" in note or "mix" in note:
        return 0
    elif "pos" in note:
        return 1
    else:
        return None
    

# Function to map notes to target values
def map_notes_to_target_tag(note):
    if "neg" in note or "mix" in note:
        return "MNR"
    elif "pos" in note:
        return "PRO"
    else:
        return None

# Function to map notes to target values
def map_notes_to_rater(note):
    if "Louis" in note:
        return "LS"
    elif "Jonathan" in note:
        return "JD"
    else:
        return None