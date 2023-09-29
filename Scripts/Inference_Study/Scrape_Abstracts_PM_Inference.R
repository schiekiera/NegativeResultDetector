# Remove data
rm(list = ls())

## libraries
library(devtools)
library(rentrez) 
library(stringr)
library(xml2)
library(tidyverse)
library(writexl)
library(readxl)
library(readr)
library(cld2)

## Vars
# API Key, Mail, Search Terms & tool
email <- "mail_adress@mail.com"
tool <- "tool_name"
api_key <- "api_key"

## search term overview
search_term_overview<-'(Psychotherapy[MeSH Terms]) AND ("1990"[Date - Publication]: "2022"[Date - Publication]) AND (Randomized Controlled Trial[Filter]) AND English[Language] NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'


## specific search terms
search_term1<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("1990"[Date - Publication] : "1995"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term2<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("1996"[Date - Publication] : "2000"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term3<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2001"[Date - Publication] : "2005"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term4<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2006"[Date - Publication] : "2010"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term5<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2011"[Date - Publication] : "2013"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term6<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2014"[Date - Publication] : "2015"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term7<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2016"[Date - Publication] : "2017"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term8<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2018"[Date - Publication] : "2019"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term9<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2020"[Date - Publication] : "2021"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'
search_term10<-'(Randomized Controlled Trial[Filter]) AND  English[Language] AND (Psychotherapy[MeSH Terms]) AND ("2022"[Date - Publication] : "2022"[Date - Publication]) NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'

## SEARCH TERM:
## '(Psychotherapy[MeSH Terms]) AND ("1990"[Date - Publication]: "2022"[Date - Publication]) AND (Randomized Controlled Trial[Filter]) AND English[Language] NOT ((protocol[Title/Abstract]) OR (will[Title/Abstract]))'

## Return
q_overview <- entrez_search(db="pubmed", term=search_term_overview,
                            api_key = api_key,tool = tool, email = email)
print(q_overview$count)
## count: 20862


# search data bases
q1 <- entrez_search(db="pubmed", term=search_term1, use_history=TRUE, 
                    api_key = api_key,tool = tool, email = email, retmax=9999)
Sys.sleep(1)
q2 <- entrez_search(db="pubmed", term=search_term2, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email, retmax=9999)
Sys.sleep(1)
q3 <- entrez_search(db="pubmed", term=search_term3, use_history=TRUE, 
                    api_key = api_key,tool = tool, email = email, retmax=9999)
Sys.sleep(1)
q4 <- entrez_search(db="pubmed", term=search_term4, use_history=TRUE, 
                    api_key = api_key,tool = tool, email = email,retmax=9999)
Sys.sleep(1)
q5 <- entrez_search(db="pubmed", term=search_term5, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email, retmax=9999)
Sys.sleep(1)
q6 <- entrez_search(db="pubmed", term=search_term6, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email,retmax=9999)
Sys.sleep(1)
q7 <- entrez_search(db="pubmed", term=search_term7, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email,retmax=9999)
Sys.sleep(1)
q8 <- entrez_search(db="pubmed", term=search_term8, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email,retmax=9999)
Sys.sleep(1)
q9 <- entrez_search(db="pubmed", term=search_term9, use_history=TRUE,
                    api_key = api_key,tool = tool, email = email,retmax=9999)
Sys.sleep(1)
q10 <- entrez_search(db="pubmed", term=search_term10, use_history=TRUE,
                     api_key = api_key,tool = tool, email = email,retmax=9999)

print(sum(q1$count,
          q2$count,
          q3$count,
          q4$count,
          q5$count,
          q6$count,
          q7$count,
          q8$count,
          q9$count,
          q10$count
))


# fetch data
list_q1<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q1$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q2<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q2$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q3<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q3$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q4<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q4$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q5<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q5$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q6<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q6$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q7<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q7$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q8<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q8$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q9<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                       web_history=q9$web_history, 
                                       rettype="XML"))
Sys.sleep(5)
list_q10<-parse_pubmed_xml(entrez_fetch(db="pubmed",
                                        web_history=q10$web_history, 
                                        rettype="XML"))

# Data Saving
### STEP 1 ###
list_entries <- c(list_q1,
                  list_q2,
                  list_q3,
                  list_q4,
                  list_q5,
                  list_q6,
                  list_q7,
                  list_q8,
                  list_q9,
                  list_q10)
## count: 22278
## including duplicates



# Create an empty list to store the values
rows <- list()

# Iterate over each entry in the list
for (entry in list_entries) {
  # Extract the values from the entry
  authors <- ifelse("authors" %in% names(entry) && !is.null(entry$authors), 
                    ifelse(length(entry$authors) > 1, 
                           paste0(entry$authors, collapse = " "), entry$authors),
                    "NA")
  year <- ifelse("year" %in% names(entry) && !is.null(entry$year), 
                 ifelse(length(entry$year) > 1,
                        paste0(entry$year, collapse = " "), entry$year), 
                 "NA")
  title <- ifelse("title" %in% names(entry) && !is.null(entry$title), 
                  ifelse(length(entry$title) > 1,
                         paste0(entry$title, collapse = " "), entry$title),
                  "NA")
  abstract <- ifelse("abstract" %in% names(entry) && !is.null(entry$abstract), 
                     ifelse(length(entry$abstract) > 1,
                            paste0(entry$abstract, collapse = " "), entry$abstract),
                     "NA")
  journal <- ifelse("journal" %in% names(entry) && !is.null(entry$journal), 
                    ifelse(length(entry$journal) > 1,
                           paste0(entry$journal, collapse = " "), entry$journal),
                    "NA")
  keywords <- ifelse("key_words" %in% names(entry) && !is.null(entry$key_words), 
                     ifelse(length(entry$key_words) > 1,
                            paste0(entry$key_words, collapse = "; "), entry$key_words),
                     "NA")
  doi <- ifelse("doi" %in% names(entry) && !is.null(entry$doi), 
                ifelse(length(entry$doi) > 1,
                       paste0(entry$doi, collapse = " "), entry$doi),
                "NA")
  pmid <- ifelse("pmid" %in% names(entry) && !is.null(entry$pmid), 
                 ifelse(length(entry$pmid) > 1,
                        paste0(entry$pmid, collapse = " "), entry$pmid),
                 "NA")
  
  # Add the values to the list
  rows[[length(rows) + 1]] <- c(authors, year, title, abstract, journal, keywords, doi, pmid)
}

# Convert the list into a dataframe
df_inference <- data.frame(do.call(rbind, rows), stringsAsFactors = FALSE)

# Set the column names
colnames(df_inference) <- c("authors", "year", "title", "abstract", "journal","keywords", "doi", "pmid")



authors_vec <- character(nrow(df_inference))
year_vec <- character(nrow(df_inference))
title_vec <- character(nrow(df_inference))
abstract_vec <- character(nrow(df_inference))
journal_vec <- character(nrow(df_inference))
keywords_vec <- character(nrow(df_inference))
doi_vec <- character(nrow(df_inference))
pmid_vec <- character(nrow(df_inference))

for (i in 1:nrow(df_inference)) {
  authors_vec[i] <- if (length(df_inference[[1]][[i]]) > 0) df_inference[[1]][[i]] else NA
  year_vec[i] <- if (length(df_inference[[2]][[i]]) > 0) df_inference[[2]][[i]] else NA
  title_vec[i] <- if (length(df_inference[[3]][[i]]) > 0) df_inference[[3]][[i]] else NA
  abstract_vec[i] <- if (length(df_inference[[4]][[i]]) > 0) df_inference[[4]][[i]] else NA
  journal_vec[i] <- if (length(df_inference[[5]][[i]]) > 0) df_inference[[5]][[i]] else NA
  keywords_vec[i] <- if (length(df_inference[[6]][[i]]) > 0) df_inference[[6]][[i]] else NA
  doi_vec[i] <- if (length(df_inference[[7]][[i]]) > 0) df_inference[[7]][[i]] else NA
  pmid_vec[i] <- if (length(df_inference[[8]][[i]]) > 0) df_inference[[8]][[i]] else NA
}


### STEP 2 ###
## Join data.frame
df_inference_joined <- data.frame(
  authors = authors_vec,
  year = year_vec,
  title = title_vec,
  abstract = abstract_vec,
  journal = journal_vec,
  keywords = keywords_vec,
  doi = doi_vec,
  pmid = pmid_vec,
  stringsAsFactors = FALSE
)
dim(df_inference_joined)
## rows: 22728    cols: 8

### STEP 3 ###
## remove duplicates
df_duplicates_deleted<-df_inference_joined[!duplicated(df_inference_joined$pmid),]
dim(df_duplicates_deleted)
## rows: 20862    cols: 8
## matches the results given by print(q_overview$count)

### STEP 4 ###
## remove entries without abstracts
df_abstracts<-df_duplicates_deleted[!is.na(df_duplicates_deleted$abstract),]
dim(df_abstracts)
## rows: 20587    cols: 9

### STEP 5 ###
## remove non-english abstracts
df_abstracts$language<-cld2::detect_language(df_abstracts$abstract)
df_abstracts_en<-df_abstracts[df_abstracts$language=="en",]
df_abstracts_language<-df_abstracts_en[is.na(df_abstracts_en$language)==FALSE,]
dim(df_abstracts_language)
## rows: 20494    cols: 9

### STEP 6 ###
#  remove all rows where year is a missing value
df_abstracts_year<-df_abstracts_language[is.na(df_abstracts_language$year)==FALSE,]
dim(df_abstracts_year)
## rows: 20433    cols: 9

### STEP 7 ###
#  Keep all rows where year is smaller than 2023
df_final<-df_abstracts_year[df_abstracts_year$year<2023,]
## rows: 20212    cols: 9



#########################
## Track Preprocessing ##
#########################
step3<-20862
step4<-20587
step5<-20494
step6<-20433
step7<-20212

# Subtract
step3-step4
step4-step5
step6-step5
step7-step6

# Removed
## 275 without abstracts
## 93 non-english
## 61 without publication year
## 221 with year greater than 2023
