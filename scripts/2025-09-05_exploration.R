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

exam_data <- exam_data %>% 
  rename (
    age = preOp_age
  )
glimpse(exam_data)


# Changing the dataset form wide to long formate
# Trying first on cough variable

exam_data_long1 <- exam_data %>%  
  pivot_longer(
    cols = c(pacu30min_cough,pacu90min_cough,postOp4hour_cough,pod1am_cough), 
    names_to = "time", 
    values_to = "cough"
    
  )
view(exam_data_long1)

# Want to do the same with throat-pain 
exam_data_long1 <- exam_data_long1 %>%  
  pivot_longer(
    cols = c(pacu30min_throatPain,pacu90min_throatPain,postOp4hour_throatPain,pod1am_throatPain), 
    names_to = "time1", 
    values_to = "throatPain"
    
  )
view(exam_data_long1)

exam_data <- exam_data_long1 %>%
  mutate(obs_time = time) %>%  
  select(-time, -time1)           

exam_data <- exam_data %>% 
  rename(time = obs_time)

view(exam_data)

#----End----####