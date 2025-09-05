# Exam description

Practical task in groups (max.3 persons).

You will create a GitHub repository or use the one you have created during the
course. There, you need to collaborate, keep history of changes, push commits,
etc. The log will be evaluated by us to check that each of you worked on a part
of the final report.

The repository should contain:

- _any scripts you have been using during the course_ (choose one version or
create a new one based on everyone's versions)
- _any notes or log files you think were useful_
- _tidied dataset_
- _new codebook for tidy data_
- _nice folder structure_
- _final .Rmd report and the .html or .md output_

## Data

You will receive the dataset in two parts: `exam_data.txt` and
`exam_data_join.txt` file, as well as the codebook describing the dataset
(`codebook_exam_data.html`).

## Tasks

1. Create an RStudio project and GitHub repository

  - create a nice folder structure, e.g., data, scripts folders, and put the
  dataset in `data`, create a new R script file in `scripts`
  - write a README and update its content as you go on

2. Read and tidy the dataset.
_(try to divide this task between the group members)_

  - write all the commands and document!
  - _tips:_
  
      - some columns may need to be separated
      - some columns can be duplicated
      - some column names can contain spaces or start with numbers
      - some columns can include values from various features/measurements

3. Tidy, adjust, and explore.
_(try to divide this task between the group members)_

    - Remove unnecessary columns from your dataframe: `year, month`
    - Read and join the additional dataset to your main dataset.
    - Make necessary changes in variable types
    - Create a set of new columns:
_(each member of the group chooses one column)_
        - a column showing whether severity of cough changed from "extubation" to "pod1am"
        - a column showing whether severity of throat pain changed from "pacu30min" to "pod1am"
        - a column cutting BMI into quartiles (4 equal parts); HINT: cut() function
        - a column coding gender to "Male" and "Female" instead of "0"/"1"
    - Set the order of columns as: `patient_id, BMI, age, smoking, gender` and other columns
    - Arrange patient_id column of your dataset in order of increasing number or alphabetically.
  - Connect above steps with pipe.
  - Explore your data.
  - Explore and comment on the missing variables.
  - Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
  - Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use a pipe `%>%`!    
_(each member of the group chooses one column)_
    - Only for persons with BMI <25
    - Only for females
    - Only for persons older than 50 years of age
    - Only for persons who had experienced coughing at extubation
  - Use two categorical columns in your dataset to create a table (either with
  `table()`, `count()`, or `janitor::tabyl()`)

4. Create plots that would help answer these questions:
_(each person chooses one question)_

  - Are there any correlated measurements? (hint: `GGally::ggcorr` or search
  online for correlation matrix in R)
  - Does the age distribution depend on `treat`?
  - Does the age distribution of the patients depend on their sex (`gender`)?
  - Does the preoperative pain change with age of the patients?
  - Do BMI and age have a linear relationship?

5. Analyse the dataset and answer the following questions:    
_(each person chooses one question)_

    - Does the treatment depend on the preoperative smoking?
    - Does the treatment depend on the gender of the patient?
    - Does the treatment depend on whether the patient had a preoperative pain?
    - According to the data, was the treatment with licorice gargle reducing the risk of post operative throat pain?

6. Write a short report in an Rmd format.    
_(divide writing the report)_

General tips:

- document, track changes (commit often!)
- use descriptive names, don't cram the code on a small space
- be active with commiting, commenting, etc.
- you can have many short scripts - one per each task, or two-three longer 
scripts logically divided and neatly commented

## What can be used?

Everything! Google if you get stuck, use books, blogs, R-docs...!

_NB: if you have any technical issues, contact us!_

## Evaluation

- We expect a clean history of changes and a nice structure of files.
- Documentation of the scripts needs to be informative.
- The code style will not be evaluated, but might influence our mood while
performing evaluation ;)
- In the end, we would like to receive a repository that includes the files
listed on top of this document

## Grading

The project will be evaluated individually and you will get
an exhaustive description of your work, taking into account:

    - cleanliness of the files and file structure,
    - usage of the functions to complete the tasks described above,
    - the overall content of the final report.

