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
library(broom)

# Load data
joined_exam_data <- read_delim(here("data","joined_exam_data_2025-09-09.txt"))

# Mutate from character to factor
joined_exam_data <- joined_exam_data %>% 
  mutate(across(where(is.character), as.factor))

# Inspect the data
skimr::skim(joined_exam_data)
glimpse(joined_exam_data)

# According to the data, was the treatment with licorice gargle reducing the risk of post operative throat pain? ----

## Throat pain at pod1am
joined_exam_data %>% 
  filter(time == "pod1am") %>% 
  group_by(treat) %>% 
  summarise(
    mean_pain = mean(throatPain, na.rm = TRUE),
    median_pain = median(throatPain, na.rm = TRUE),
    n = n()
  )

## Throat pain at pacu30min
joined_exam_data %>% 
  filter(time == "pacu30min") %>% 
  group_by(treat) %>% 
  summarise(
    mean_pain = mean(throatPain, na.rm = TRUE),
    median_pain = median(throatPain, na.rm = TRUE),
    n = n()
  )

# NOTE: Median of throatPain is 0 in both Licorice and Sugar, indicating a skewed distribution. Due to this, a wilcox test might be appropriate.

## Wilcox test: Licorice vs sugar throatPain at pod1am
wilcox_result <- joined_exam_data %>% 
  filter(time == "pod1am") %>% 
  wilcox.test(throatPain ~ treat, data = .) %>% 
  tidy()

wilcox_result

# NOTE: p = 0.0016: Licorice significantly reduces throat pain at POD1AM, compared to sugar.

## Regression: Linear mixed model: Treatment and time effects on throat pain outcomes
library(lme4)
library(broom.mixed)

### Linear mixed effects model
throat_model <- lmer(throatPain ~ treat * time + (1|patient_id), 
                     data = joined_exam_data)

### Tidy results
tidy(throat_model, effects = "fixed")

### Check treatment effect
summary(throat_model)

# NOTE: treatSugar coefficient = 0.752: Sugar increases pain by 0.75 points
# NOTE: treatSugar:timepod1am = -0.422: Additional 0.42 point reduction at POD1AM

# Create a plot (sanity check)
## Reorder time levels in chronological order
joined_exam_data$time <- factor(joined_exam_data$time, 
                                levels = c("pacu30min", "pacu90min", "postOp4hour", "pod1am"))

## Calculate means and standard errors by treatment and time
summary_data <- joined_exam_data %>% 
  group_by(treat, time) %>% 
  summarise(
    mean_pain = mean(throatPain, na.rm = TRUE),
    se_pain = sd(throatPain, na.rm = TRUE) / sqrt(n()),
    n = n(),
    .groups = "drop"
  )

## Create the plot
ggplot(summary_data, aes(x = time, y = mean_pain, color = treat, group = treat)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = mean_pain - se_pain, ymax = mean_pain + se_pain), 
                width = 0.1) +
  labs(
    x = "Timepoint",
    y = "Mean throat pain",
    color = "Treatment",
    title = "Throat pain over time by treatment",
    subtitle = "Error bars show standard error"
  ) +
  theme_minimal() +
  scale_y_continuous(limits = c(0, NA))

#----End----####