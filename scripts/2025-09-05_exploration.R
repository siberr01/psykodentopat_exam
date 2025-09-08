#----Exploration of exam data----####
# Date: 2025-09-05
# Author: psykodentopat
# File name: 2025-09-05_exploration.R
# Description: This is a script for exploring exam_data.txt, and 
# tidying it accordingly.
#
# Project: psykodentopat_exam.Rproj


# Setup ----
library(tidyverse)
library(here)

# Reading the data ----
exam_data <- read_delim(here("data","exam_data.txt"))

# Checking the data ----
exam_data
glimpse(exam_data)
str(exam_data)
head(exam_data)
tail(exam_data)
skimr::skim(exam_data)
    
# Seems like: 
# - pre0p_ is unnecessary for gender, age, smoking, pain
# - there are two gender columns
# - gender can be written as m and f instead of 0 and 1 for clarity
# - can create long format: preop, pacu30min, pacu90min, postop4hour, pod1am --> time
# - long format: cough, throatpain
# - can rename some variables: BMI, 
# - split preOp_ASA_Mallampati: Contains two measures
# - month and year are not mentioned in the notebook, might refer to month/year of operation, but might be something else as well
# several of the columns are numerical, but are in fact factors

# Looking at the IDs ----
exam_data %>% 
  count(patient_id) %>% 
  distinct() # seems like even though there are 265 rows, there are 235 distinct patient_ids

exam_data %>% 
  count(patient_id) %>% 
  filter(n>1) # seems like 28 patient_ids are reported more than once

exam_data %>% 
  count(patient_id) %>% 
  filter(n>2) # ... and two ids counted three times

# Looking at the data of the IDs reported several times: Looks like they have been operated several times (due to different month/year)

exam_data %>% 
  count(patient_id) %>% 
  filter(n>1) %>% 
  pull(patient_id)

# Organizing columns ----
# Renaming collums 
exam_data <- exam_data %>%
  rename(
    gender = preOp_gender,
    smoking =preOp_smoking,
    age = preOp_age
  )

# Remove 1gender column ----
exam_data$gender == exam_data$`1gender` # Check if they are identical

exam_data <- exam_data %>% 
  select(-'1gender')

str(exam_data)

# Cleaning dataset to long format ----

# Making the data into long version using pivot longer
exam_data_clean <- exam_data %>%
  pivot_longer(
    cols = matches("cough|throatPain"), 
    names_to = c("time_final", "symptom"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = symptom,
    values_from = value
  )

exam_data_clean <- exam_data_clean %>%  
  rename(time = time_final)

# Checking the clean data
glimpse(exam_data_clean)
str(exam_data_clean)
head(exam_data_clean)
tail(exam_data_clean)
skimr::skim(exam_data_clean)

# Separating ASA_Mallampati to ASA and mallampati ----

exam_data_clean <- exam_data_clean %>%
  separate(preOp_ASA_Mallampati, 
           into = c("ASA", "mallampati"), 
           sep = "_")
  
exam_data_clean %>% 
  count(ASA, mallampati)

# Mutate from num to factor for ASA and mallampati
exam_data_clean %>% 
  mutate(
    ASA = factor(ASA, levels = 1:3),
    mallampati = factor(mallampati, levels = 1:4)
  )

exam_data_clean %>% 
  count(ASA, mallampati)

# Remove month and year
exam_data_clean <- exam_data_clean %>% 
  select(-month, -year)

glimpse(exam_data_clean)

# Save data ----
fileName <- paste0("exam_data_clean_", Sys.Date(), ".txt") 

write_delim(
  exam_data_clean,
  file = fileName,
  delim = "\t"
)

#----End----####