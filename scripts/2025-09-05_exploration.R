#----Exploration of exam data----####
# Date: 2025-09-05
# Author: psykodentopat
# File name: 2025-09-05_exploration.R
# Description: This is a script for exploring exam_data.txt
#
#
# Project: psykodentopat_exam.Rproj

# Setup
library(tidyverse)
library(here)

# Reading data
exam_data <- read_delim(here("data", "exam_data.txt"))

# Checking data
exam_data

glimpse(exam_data)
skimr::skim(exam_data)
str(exam_data)

# Observations
## Two gender columns: preOp_gender and 1gender


## month og year = tidspunkt for inngrep?

## Codebook: 236 patients enrolled, 265 rows

exam_data %>%
  count(patient_id) %>%
  filter(n > 1)

exam_data %>%
  filter(duplicated(patient_id) | duplicated(patient_id, fromLast = TRUE)) %>%
  arrange(patient_id)

# Endre kolonnenavn
exam_data <- exam_data %>% 
  rename(BMI = `BMI kg/m2`)
str(exam_data)

## Several columns have two variables (time+pain) --> separating these
# data_long <- data %>%
  pivot_longer(
   


#----End----####