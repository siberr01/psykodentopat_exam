#----Join and tidy exam data----####
# Date: 2025-09-08
# Author: psykodentopat
# File name: 2025-09-08_join_and_tidy_exam_data.R
# Description: A script for joining additional data with previous
# exam_data_clean and additional tidying.
#
# Project: psykodentopat_exam.Rproj

# Setup ----
library(tidyverse)
library(here)

# Read the data ----
exam_data_clean <- read_delim(here("data","exam_data_clean_2025-09-08.txt"))

exam_data_join <- read_delim(here("data","exam_data_join.txt"))

# Check the data ----
## Exam data clean
exam_data_clean
glimpse(exam_data_clean)
str(exam_data_clean)
head(exam_data_clean)
tail(exam_data_clean)
skimr::skim(exam_data_clean)

## Exam data join
exam_data_join
glimpse(exam_data_join)
str(exam_data_join)
head(exam_data_join)
tail(exam_data_join)
skimr::skim(exam_data_join)

## Change variables from numeric to factor 

### Surgery size
exam_data_join <- exam_data_join %>%             
  mutate(intraOp_surgerySize = factor(                    
    intraOp_surgerySize, 
    levels = c(1,2,3),
    labels = c("small", "medium","large")
  )
  ) 

### Extubation cough
exam_data_join <- exam_data_join %>%             
  mutate(extubation_cough = factor(                    
    extubation_cough, 
    levels = c(0,1,2,3),
    labels = c("no cough","mild", "moderate","severe")
  )
  )

### Sanity check
skimr::skim(exam_data_join)

## Checking for duplicates in both data sets
### exam data clean
nrow(exam_data_clean)
distinct(exam_data_clean)

exam_data_clean <- exam_data_clean %>% 
  distinct()

nrow(exam_data_clean)

### exam data join
nrow(exam_data_join)
distinct(exam_data_join)

exam_data_join <- exam_data_join %>% 
  distinct()

nrow(exam_data_join)

# Join the dataframes ----
joined_exam_data <- exam_data_clean %>% 
  left_join(exam_data_join)

glimpse(joined_exam_data)

## Tidy new dataframe

### Changing name of variables
joined_exam_data <- joined_exam_data %>%
  rename(
    surgerySize = intraOp_surgerySize,
  )

glimpse(joined_exam_data)

### ASA and Mallampati to factors
joined_exam_data <- joined_exam_data %>%             
  mutate(ASA = factor(                    
    ASA, 
    levels = c(1,2,3),
    labels = c("healthy", "mild","severe")
  )
  ) 

joined_exam_data <- joined_exam_data %>%             
  mutate(mallampati = factor(                    
    mallampati, 
    levels = c(1,2,3,4),
    labels = c("soft palate, fauces, uvula, pillars visible", "soft palate, fauces, uvula visible","soft palate, base of uvula visible","soft palate not visible at all")
  )
  )

### Changing from chr to factor
joined_exam_data <- joined_exam_data %>% 
  mutate(across(where(is.character), as.factor))

glimpse(joined_exam_data)


# Create new columns ----
## Create both change variables first

### Throat pain change
throat_pain_change <- joined_exam_data %>% 
  select(patient_id, time, throatPain) %>% 
  filter(time %in% c("pacu30min", "pod1am")) %>% 
  pivot_wider(names_from = time, values_from = throatPain) %>% 
  mutate(throat_pain_change = case_when(
    pod1am > pacu30min ~ "increased",
    pod1am < pacu30min ~ "decreased", 
    pod1am == pacu30min ~ "no_change"
  )) %>% 
  select(patient_id, throat_pain_change)

### Cough change
cough_change <- joined_exam_data %>% 
  filter(time == "pod1am") %>% 
  mutate(cough_change = case_when(
    extubation_cough == "no cough" & cough == "no" ~ "no_change",
    extubation_cough == "no cough" & cough %in% c("mild", "moderate", "severe") ~ "more_cough",
    extubation_cough %in% c("mild", "moderate", "severe") & cough == "no" ~ "cough_resolved",
    extubation_cough %in% c("mild", "moderate", "severe") & cough %in% c("mild", "moderate", "severe") ~ "persistent_cough"
  )) %>% 
  select(patient_id, cough_change)

# One pipe for joining throat pain, cough, BMI categories, selecting columns, and arranging by ID
joined_exam_data <- joined_exam_data %>% 
  left_join(throat_pain_change, by = "patient_id") %>% 
  left_join(cough_change, by = "patient_id") %>% 
  mutate(BMI_category = cut(BMI, breaks = c(-Inf, 18.5, 25, 30, Inf), 
                            labels = c("Underweight", "Normal weight", "Overweight", "Obese"), 
                            right = FALSE)) %>% 
  select(patient_id, BMI, age, smoking, gender, everything()) %>%
  arrange(patient_id)

# Exploring the new data
skimr::skim(joined_exam_data)


# Exploring missing data
joined_exam_data %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%   # Showing were we have missing values
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "n_missing") %>%
  arrange(desc(n_missing))

# It appears as we have 8 missing values in swallowPain, cough, throatPain and extubation_cough
# Since we have a long formate, this is only missing values for two individuals 


# Stratify data ----
## Stratify by gender
joined_exam_data %>% 
  group_by(gender) %>% 
  summarise(
    min = min(swallowPain, na.rm = TRUE),
    max = max(swallowPain, na.rm = TRUE),
    mean = mean(swallowPain, na.rm = TRUE),
    sd = sd(swallowPain, na.rm = TRUE),
    n_missing = sum(is.na(swallowPain)),
    n_total = n()
  )

## Report min, max, mean, sd
#gender   min   max  mean    sd
#<fct>  <dbl> <dbl> <dbl> <dbl>
#1 F          0     9 0.613  1.62
#2 M          0    10 0.993  1.88

## Throat pain day after by treatment (for females)
joined_exam_data %>% 
  filter(gender == "F" & time == "pod1am") %>% 
  group_by(treat) %>% 
  summarise(
    min = min(throatPain, na.rm = TRUE),
    max = max(throatPain, na.rm = TRUE),
    mean = mean(throatPain, na.rm = TRUE),
    sd = sd(throatPain, na.rm = TRUE),
    n = n()
  ) %>% 
  knitr::kable(digits = 2, caption = "Throat Pain at POD1AM by Treatment (Females Only)")

## Stratifying cater. column gender for persons with BMI <25
joined_exam_data %>%
  filter(BMI < 25) %>%
  group_by(gender) %>%
  summarise(
    min_BMI  = min(BMI, na.rm = TRUE),
    max_BMI  = max(BMI, na.rm = TRUE),
    mean_BMI = mean(BMI, na.rm = TRUE),
    sd_BMI   = sd(BMI, na.rm = TRUE)
  )

## Difference in swallow pain stratified by gender, only for persons older than 50 years of age
joined_exam_data %>%
  filter(age > 50) %>%
  group_by(gender) %>%
  summarise(
    swallowPain_min = min(swallowPain, na.rm = TRUE),
    swallowPain_max = max(swallowPain, na.rm = TRUE),
    swallowPain_mean = mean(swallowPain, na.rm = TRUE),
    swallowPain_sd = sd(swallowPain, na.rm = TRUE),
    .groups = "drop"
  )

# Create a table with two categorical columns
janitor::tabyl(joined_exam_data, gender, treat)

#----End----####