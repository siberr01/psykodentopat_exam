#----Visualization----####
# Date: 2025-09-09
# Author: psykodentopat
# File name: 2025-09-09_visualization.R
# Description: Script for visualization of exam data for psykodentopat.
#
#
# Project: psykodentopat_exam.Rproj

# Setup ----
library(tidyverse)
library(here)
library(ggplot2)
library(patchwork)

# Read the data ----
joined_exam_data <- read_delim(here("data","joined_exam_data_2025-09-09.txt")) %>% 
  mutate(across(where(is.character), as.factor))


# Check the data ----
## joined_exam_data
joined_exam_data
glimpse(joined_exam_data)
str(joined_exam_data)
head(joined_exam_data)
tail(joined_exam_data)
skimr::skim(joined_exam_data)


# Questions for the dataset 

## Does the preoperative pain change with age of the patients?

# Making a box-plot to show the distribution of age related to preOp pain

ggplot(joined_exam_data, aes(x = preOp_pain, y = age)) +
  geom_boxplot() +
  labs(
    x = "Preoperative pain (Yes/No)",       # The age-distribution seems to be quite similar in both gropus
    y = "Age"
  )

# Making a denisty-plot, can be more intuitive to read
ggplot(joined_exam_data, aes(x = age, fill = preOp_pain)) +
  geom_density(alpha = 0.4) +
  labs(
    x = "Age",
    y = "Density"                 
  )

# Both groups seem to have two “age clusters” – one around 35–45 and one around 65–70 
# Can indicate that we have different age-cohorts in the dataset 

# Exploring the variables
skimr::skim(joined_exam_data$age)
skimr::skim(joined_exam_data$preOp_pain)

# Only 2 patient experienced preOp pain, therefore the data is to limited to say 
# anything about how preOp pain is related to age 


#----End----####