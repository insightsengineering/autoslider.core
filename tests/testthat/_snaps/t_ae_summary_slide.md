# Test table creation of t_ae_summ_slide (safety summary table)

    Code
      t_ae_summ_slide(testdata$adsl, testdata$adae, arm = "TRT01A",
      dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
      dose_adjust_labels = c("DRUG WITHDRAWN", "DOSE REDUCED", "DRUG INTERRUPTED"),
      gr34_highest_grade_only = TRUE)
    Condition
      Warning:
      Non-unique sibling analysis table names. Using Labels instead. Use the table_names argument to analyze to avoid this when analyzing the same variable multiple times.
      	occured at (row) path: root
    Output
      AE summary table
      
      ———————————————————————————————————————————————————————————————————————————————————
                                  A: Drug X    B: Placebo   C: Combination   All Patients
                                   (N=134)      (N=134)        (N=132)         (N=400)   
      ———————————————————————————————————————————————————————————————————————————————————
      All grade AEs, any cause   100 (74.6%)   98 (73.1%)    103 (78.0%)     301 (75.2%) 
        Related                  86 (64.2%)    85 (63.4%)     92 (69.7%)     263 (65.8%) 
      Grade 3-4 AEs              26 (19.4%)    31 (23.1%)     29 (22.0%)      86 (21.5%) 
        Related                   13 (9.7%)    18 (13.4%)     15 (11.4%)      46 (11.5%) 
      Grade 5 AE                 64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
        Related                  64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
      SAEs                       85 (63.4%)    80 (59.7%)     87 (65.9%)     252 (63.0%) 
        Related                  64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
      DRUG WITHDRAWN             22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 
      DOSE REDUCED               22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 
      DRUG INTERRUPTED           22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 

---

    Code
      t_ae_summ_slide(testdata$adsl, testdata$adae, arm = "TRT01A",
      dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
      dose_adjust_labels = c("DRUG WITHDRAWN", "DOSE REDUCED", "DRUG INTERRUPTED"),
      gr34_highest_grade_only = FALSE)
    Condition
      Warning:
      Non-unique sibling analysis table names. Using Labels instead. Use the table_names argument to analyze to avoid this when analyzing the same variable multiple times.
      	occured at (row) path: root
    Output
      AE summary table
      
      ———————————————————————————————————————————————————————————————————————————————————
                                  A: Drug X    B: Placebo   C: Combination   All Patients
                                   (N=134)      (N=134)        (N=132)         (N=400)   
      ———————————————————————————————————————————————————————————————————————————————————
      All grade AEs, any cause   100 (74.6%)   98 (73.1%)    103 (78.0%)     301 (75.2%) 
        Related                  86 (64.2%)    85 (63.4%)     92 (69.7%)     263 (65.8%) 
      Grade 3-4 AEs              72 (53.7%)    70 (52.2%)     77 (58.3%)     219 (54.8%) 
        Related                  36 (26.9%)    34 (25.4%)     36 (27.3%)     106 (26.5%) 
      Grade 5 AE                 64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
        Related                  64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
      SAEs                       85 (63.4%)    80 (59.7%)     87 (65.9%)     252 (63.0%) 
        Related                  64 (47.8%)    52 (38.8%)     64 (48.5%)     180 (45.0%) 
      DRUG WITHDRAWN             22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 
      DOSE REDUCED               22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 
      DRUG INTERRUPTED           22 (16.4%)    21 (15.7%)     28 (21.2%)      71 (17.8%) 

# Test t_ae_summ_slide with expected Error

    Code
      t_ae_summ_slide(testdata$adsl, testdata$adae, arm = "TRT01A",
      dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
      dose_adjust_labels = c("DRUG WITHDRAWN", "DOSE REDUCED", "DRUG INTERRUPTED"),
      gr34_highest_grade_only = "FALSE")
    Condition
      Error:
      ! gr34_highest_grade_only is not a flag (a length one logical vector).

# Test t_ae_summ_slide with null_report

    Code
      t_ae_summ_slide(testdata$adsl[1, ], testdata$adae[1, ])
    Output
                                                                                              
      ————————————————————————————————————————————————————————————————————————————————————————
         Null Report: No observations met the reporting criteria for inclusion in this output.

