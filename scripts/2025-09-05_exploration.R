#----Exploration of exam data----####
# Date: 2025-09-05
# Author: psykodentopat
# File name: 2025-09-05_exploration.R
# Description: This is a script for exploring exam_data.txt
#
#
# Project: psykodentopat_exam.Rproj

library(tidyverse)
library(here)

exam_data <- read_delim(here("data","exam_data.txt"))
exam_data

glimpse(exam_data)
view(exam_data)

# Tidying ----

# Gender is written as "preOp_gender" and "'1gender'" 
# We want to check if these two collums includes the same information
all(exam_data$preOp_gender == exam_data$`1gender`)

# The two collums contain the same information, therefore we remove one of the collums 
# and change the name 

exam_data <- exam_data %>% 
  select(-`1gender`)

# Adjusting the names of the collums 
exam_data <- exam_data %>%
  rename(
    gender = preOp_gender,
    smoking =preOp_smoking,
    age = preOp_age
  )


#Making the data into long version using pivot longer
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


#----End----####