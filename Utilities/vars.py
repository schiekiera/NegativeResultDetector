import nltk
nltk.download('stopwords')
nltk.download('wordnet')

from nltk.corpus import stopwords

no_stop = ["no", "not", "nor"]
stopwords_start = stopwords.words('english')

stopwords_adjusted = [item for item in stopwords_start if item not in no_stop]