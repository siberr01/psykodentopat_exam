<img src="./psykodentopat_image.png" alt="Alt text" width="500">

# README exam project for RMED901A
GitHub repository for group exam in RMED901A  
Group: psykodentopat

## Folders:   

### data:   
  * codebook.html  
    
  * exam_data.txt  
    + original dataset from mittuib  
      
    
 * exam_data_join.txt  
   + original dataset from mittuib  
     

 * exam_data_clean_2025-09-08.txt  
   + clean and tidy version of original exam_data.txt  
  
 * joined_exam_data_2025-09-09.txt
   + joined original exam_data.txt and exam_data_join.txt  
   + clean and tidy version  
   + this dataset is used for visualization and analyses  
 

### scripts:  
* 2025-09-05_exploration.R  
  + initial exploration and cleaning of original dataset exam_data.txt  
   
* 2025-09-08_join_and_tidy_exam_data.R  
  + exploration and cleaning of original dataset exam_data_join.txt
  + joining clean version of exam_data_join.txt to exam_data_clean_2025-09-08.txt
  + saving new dataset joined_exam_data_2025-09-09.txt
  + exploring joined_exam_data_2025-09-09.txt and performing simple stratifying of the data
 
 * 2025-09-09_visualization.R  
   + performing exam tasks on visualization using joined_exam_data_2025-09-09.txt
  
 * 2025-09-10_analysis.R
   + running exam tasks on analysis using joined_exam_data_2025-09-09.txt  
    
### results:
* **2025-09-10_markdown_report_psykodentopat_files**
  + folder containing RMarkdown report for this project

* correlation_matrix_2025-09-11_all_variables.png
  + correlation matrix visualizing any possible correlations of variables in the dataset (only numeric variables)  
        
* denistyplot_2025-09-11_age_gender.png
  + densityplot visualizing age distribution related to gender

* denistyplot_2025-09-11_age_preOp_pain.png
  + densityplot visualizing age distribution related to preoperative pain

* denistyplot_2025-09-11_age_treatment.png
  + densityplot visualizing age distribution related to treatment group 
  


