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
    
**Reason for change:**    
- `1gender` variable was a duplicate of the original gender variable
- `month` and `year` variable was unessasary information for our analyes    

---

## New variables   
* `ASA`
  + **Description**  
    - American Society of Anesthesiologists (ASA) physical status, 1 = a normal healthy patient; 2 = a patient with mild systemic disease
  + **Comments**
    - This was a part of the original variable `preOp_ASA_Mallampati`
      
* `mallampati`
  + **Description**  
    - Mallampati score, with increasing difficulty of intubation, 1 = soft palate, fauces, uvula, pillars visible; 2 = soft palate, fauces, uvula visible; 3 = soft palate, base of uvula visible; 4 = soft palate not visible at all
  + **Comments**
    - This was a part of the original variable `preOp_ASA_Mallampati`

