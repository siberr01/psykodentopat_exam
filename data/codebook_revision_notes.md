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
-  The variables for registration of cough and throatpain at different timepoints was removed in the tidying prosess, turning the dataset into longer formate. See "New variables" section.     

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

* `cough`

* `throatPain`
