#----Visualization----####
# Date: 2025-09-09
# Author: psykodentopat
# File name: 2025-09-09_visualization.R
# Description: Script for visualization of exam data for psykodentopat.
#
#
# Project: psykodentopat_exam.Rproj

# SETUP ----
library(here)
library(tidyverse)
library(patchwork)
library(ggplot2)

# Load data
joined_exam_data <- read_delim(here("data", "joined_exam_data_2025-09-09.txt"))

# Explore
glimpse(joined_exam_data)
skimr::skim(joined_exam_data)

# Changing from character to factor
joined_exam_data <- joined_exam_data %>% 
  mutate(across(where(is.character), as.factor))

# Exploring whether the age distribution of patients differs by gender
## Numerical summery
joined_exam_data %>%
  group_by(gender) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    sd_age   = sd(age, na.rm = TRUE),
    min_age  = min(age, na.rm = TRUE),
    max_age  = max(age, na.rm = TRUE),
    n        = n()
  )

## Box plot displaying age distribution by gender
plot_age_distribution_by_gender <- ggplot(joined_exam_data, 
    aes(x = gender, y = age, fill = gender)) +
  geom_boxplot() +
  labs(title = "Age distribution by gender") + 
  scale_fill_brewer(palette = "Pastel2")
plot_age_distribution_by_gender

## Density plot to visualize the full shape of the age distribution by gender
density_age_distribution_by_gender <- ggplot(joined_exam_data, 
                                          aes(x = age, fill = gender)) +
  geom_density(alpha = 0.5) +
  labs(title = "Age distribution by gender", 
       x = "Patient age", 
       fill = "Gender") +
  scale_fill_brewer(palette = "Pastel2")
density_age_distribution_by_gender
  
## T-test to see whether mean age differs between male and female patients (Welch two-sample t-test)
t.test(age ~ gender, data = joined_exam_data)
# p-value = 0.598: There is no statistically significant difference in mean age between genders.


#----End----####