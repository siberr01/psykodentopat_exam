# Codebook Revision Notes  

_Last updated: 2025-09-11_  
  
This document records all revisions made to the original codebook, including clarifications, category standardizations, and variable descriptions.

## Renaming variables  
* `preOp_gender` = `gender`  
* `preOp_smoking`= `smoking`  
* `BMI kg/m2` = `BMI`  
* `pacu30min_swallowPain`= `swallowPain`  
* `preOp_age` = `age`  
    
**Reason for change:**  
- The original names of the variables contained unessasary information 

---

## Removing collums  
* `1gender` 
* `month`
* `year`
* `pacu30min_cough`, `pacu90min_cough`, `postOp4hour_cough`, `pod1am_cough`
* `pacu30min_throatPain`, `pacu90min_throatPain`, `postOp4hour_throatPain`, `pod1am_throatPain`

  
**Reason for change:**    
- `1gender` variable was a duplicate of the original gender variable
- `month` and `year` variable was unessasary information for our analyes
-  The variables for registration of cough and throatpain at different timepoints was removed in the tidying prosess, turning the dataset into longer formate. See "New variables" - section.     

---

## New variables   
* `ASA`
  + **Description**  
    - American Society of Anesthesiologists (ASA) physical status, "healthy" = a normal healthy patient; "mild" = a patient with mild systemic disease; "severe" = a patient with severe systemic disease and
    - Type: factor
  + **Comments**
    - This was a part of the original variable `preOp_ASA_Mallampati`, coded as: 1 = a normal healthy patient; 2 = a patient with mild systemic disease; 3 = a patient with severe systemic disease
      
* `mallampati`
  + **Description**    
    - Mallampati score, with increasing difficulty of intubation, "soft palate, fauces, uvula, pillars visible"; "soft palate, fauces, uvula visible"; "soft palate, base of uvula visible"; "soft palate not visible at all"  
    - Type: factor   
  + **Comments**
    - This was a part of the original variable `preOp_ASA_Mallampati`, coded as: 1 = soft palate, fauces, uvula, pillars visible; 2 = soft palate, fauces, uvula visible; 3 = soft palate, base of uvula visible; 4 = soft palate not visible at all

  * `throat_pain_change`
  + **Description**    
    - Change in severity of throat pain from "pacu30min" to "pod1am", "increased" = pod1am > pacu30min; "decreased" = pod1am < pacu30min; "no_change" =  pod1am == pacu30min
    - Type: factor   
  
 * `cough_change`
  + **Description**      
    - Change in severity of cough from "pacu30min" to "pod1am", "no change" = (no extubation_cough  == no cough at pod1am); "more_cough" =(extubation_cough < cough at pod1am);  "cough_resolved" = (cough at pod1am > extubation_cough); "persistent_cough" = (extubation_cough  == cough at pod1am)  
    - Type: factor  
   

### Pivot into long format
During the data tidying process, the dataset was reshaped from **wide format** (one row per patient with multiple time-point columns) to **long format** (one row per patient per time point). This transformation created three new variables:     

* `cough`
  + **Description**    
    - Amount of coughing, No; Mild; Moderate; Severe  
    - Type: factor
      
* `throatPain`
  + **Description**      
    - Sore throat pain score at rest, 11 point Likert scale, 0=no pain, 10 = worst pain   
    - Type: numeric  
  
* `time`  
  + **Description**      
    - Indicates the time point of measurement, pacu30min = 30 minutes after arrival in PACU; pacu90min = 90 minutes after arrival in PACU; postOp4hour = 4 hours after surgery; pod1am = first postoperative morning  
    - Type: factor  
  
