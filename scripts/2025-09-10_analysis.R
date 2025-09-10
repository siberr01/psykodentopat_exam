#----Analysis----####
# Date: 2025-09-10
# Author: psykodentopat
# File name: 2025-09-10_analysis.R
# Description: R script for statistical analysis of exam data.
#
#
# Project: psykodentopat_exam.Rproj


#  Does the treatment depend on the gender of the patient?

tbl <- table(joined_exam_data$gender, joined_exam_data$treat)
tbl # 2x2 table showing how many female/male who recieved licorice/suger treatment

chisq.test(tbl) # Chi-square test 

# P-value is not significant, it does not seem to be a relationship between treatment and gender


 
#----End----####