#----Analysis----####
# Date: 2025-09-10
# Author: psykodentopat
# File name: 2025-09-10_analysis.R
# Description: R script for statistical analysis of exam data.
#
#
# Project: psykodentopat_exam.Rproj

# Setup ----
library(tidyverse)
library(here)
library(ggplot2)
library(patchwork)


# Load data
joined_exam_data <- read_delim(here("data","joined_exam_data_2025-09-09.txt"))

# Mutate from character to factor
joined_exam_data <- joined_exam_data %>% 
  mutate(across(where(is.character), as.factor))


# Exploring whether the treatment group depend on preoperative smoking
## Table of treatment (rows) by smoking (columns)
table(joined_exam_data$treat, joined_exam_data$smoking)

## Both variables treatment and smoking are categorical, standard test is Chi-squared test

chisq.test(table(joined_exam_data$treat, joined_exam_data$smoking))

## There is no evidence that treatment group assignment depended on preoperative smoking 
## (Chi-squared test, p = 0.9813).


# Exploring wether the treatment depend on the gender of the patient

tbl <- table(joined_exam_data$gender, joined_exam_data$treat)
tbl # 2x2 table showing how many female/male who recieved licorice/suger treatment

chisq.test(tbl) # Chi-square test 

## P-value is not significant, it does not seem to be a relationship between treatment and gender


 
#----End----####