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

# Load data
joined_exam_data <- read_delim(here("data","joined_exam_data_2025-09-09.txt"))

# Mutate from character to factor
joined_exam_data <- joined_exam_data %>% 
  mutate(across(where(is.character), as.factor))

# Are there any correlated measures? ----
GGally::ggcorr(joined_exam_data)
joined_exam_data %>%
  select(-patient_id) %>% 
  ggcorr()
# Seems like throatPain and swallowPain are correlated, and also age and BMI. Also seems like Patient ID is correlated with swallowPain and throatPain, probably an artifact, could also be that that the patients recruited later had more pain...?

# Does the age distribution depend on treat? ----
ggplot(joined_exam_data, aes(x = age, fill = treat)) +
  geom_density(alpha = 0.5) +
  theme_gray() +
  labs(title = "Age distribution by treatment",
       x = "Patient age",
       fill = "Treatment:") +
  theme(legend.position = "bottom") +
  scale_fill_brewer(palette = "PuOr")

# Exploring whether the age distribution of patients differs by gender ----
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

# Does the preoperative pain change with age of the patients? ----
## Box-plot to show the distribution of age related to preOp pain

ggplot(joined_exam_data, aes(x = preOp_pain, y = age)) +
  geom_boxplot() +
  labs(
    x = "Preoperative pain (Yes/No)",       # The age-distribution seems to be quite similar in both gropus
    y = "Age"
  )

## Denisty-plot, can be more intuitive to read but can also give the wrong impression in this case
ggplot(joined_exam_data, aes(x = age, fill = preOp_pain)) +
  geom_density(alpha = 0.4) +
  labs(
    x = "Age",
    y = "Density"                 
  )

ggplot(joined_exam_data, aes(x = preOp_pain, y = age)) +
  geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 0.8,
               binwidth = 1) +
  labs(title = "Age by Pre-Op Pain Status",
       x = "Pre-Op Pain",
       y = "Age") +
  theme_minimal()

## Want to explore why we get these kind of "strange" results

### Exploring the variables
skimr::skim(joined_exam_data$age)
skimr::skim(joined_exam_data$preOp_pain)

# Only 2 patient experienced preOp pain, therefore the data is too limited to say anything about how preOp pain is related to age 

# T-tests (Welch Two Sample t-test) ----
t.test(age ~ treat, data = joined_exam_data)
t.test(age ~ preOp_pain, data = joined_exam_data)
t.test(age ~ gender, data = joined_exam_data)

#----End----####