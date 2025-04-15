# Test table creation of t_ae_pt_soc_diff_slide  (safety summary table)

    Code
      t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A")
    Output
      Adverse Events with Difference
      
      ———————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class                                              
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   All Patients
      ———————————————————————————————————————————————————————————————————————
      cl A.1                                                                 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)    80 (29.9%) 
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)    76 (28.4%) 
      cl B.1                                                                 
      dcd B.1.1.1.1                    38 (28.4%)   37 (27.6%)    75 (28.0%) 
      cl B.2                                                                 
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)    78 (29.1%) 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)    73 (27.2%) 
      cl C.1                                                                 
      dcd C.1.1.1.3                    36 (26.9%)   34 (25.4%)    70 (26.1%) 
      cl C.2                                                                 
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)    64 (23.9%) 
      cl D.1                                                                 
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)    74 (27.6%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)    72 (26.9%) 
      cl D.2                                                                 
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)    83 (31.0%) 

# Test table creation of t_ae_pt_soc_diff_slide  (safety summary table) prune by total 2

    Code
      t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A",
      2)
    Output
      Adverse Events with Difference
      
      ———————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class                                              
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   All Patients
      ———————————————————————————————————————————————————————————————————————
      cl A.1                                                                 
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)    76 (28.4%) 
      cl B.2                                                                 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)    73 (27.2%) 
      cl C.2                                                                 
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)    64 (23.9%) 
      cl D.1                                                                 
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)    74 (27.6%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)    72 (26.9%) 
      cl D.2                                                                 
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)    83 (31.0%) 

# Test table creation of t_ae_pt_soc_diff_slide (safety summary table) prune by total 2

    Code
      t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A",
      2, side_by_side = "GlobalAsia")
    Output
      Adverse Events with Difference
      
      ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
                                                                                                                      
      MedDRA System Organ Class                Global                                    Asia                         
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   All Patients   A: Drug X    B: Placebo   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                                          
        dcd A.1.1.1.1                  45 (33.6%)   31 (23.1%)    76 (28.4%)    29 (39.2%)   21 (25.9%)    50 (32.3%) 
      cl B.2                                                                                                          
        dcd B.2.1.2.1                  39 (29.1%)   34 (25.4%)    73 (27.2%)    23 (31.1%)   19 (23.5%)    42 (27.1%) 
      cl C.2                                                                                                          
        dcd C.2.1.2.1                  28 (20.9%)   36 (26.9%)    64 (23.9%)    20 (27.0%)   19 (23.5%)    39 (25.2%) 
      cl D.1                                                                                                          
        dcd D.1.1.1.1                  42 (31.3%)   32 (23.9%)    74 (27.6%)    29 (39.2%)   26 (32.1%)    55 (35.5%) 
        dcd D.1.1.4.2                  38 (28.4%)   34 (25.4%)    72 (26.9%)    21 (28.4%)   19 (23.5%)    40 (25.8%) 
      cl D.2                                                                                                          
        dcd D.2.1.5.3                  37 (27.6%)   46 (34.3%)    83 (31.0%)    21 (28.4%)   26 (32.1%)    47 (30.3%) 

---

    Code
      t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A",
      2, split_by_study = TRUE)
    Output
      Adverse Events with Difference
      
      ——————————————————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class               AB12345-2                 AB12345-1       
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   A: Drug X    B: Placebo
      ——————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                            
      dcd A.1.1.1.2                    25 (34.7%)   18 (30.0%)   16 (25.8%)   21 (28.4%)
      dcd A.1.1.1.1                    27 (37.5%)   9 (15.0%)    18 (29.0%)   22 (29.7%)
      cl B.1                                                                            
      dcd B.1.1.1.1                    18 (25.0%)   12 (20.0%)   20 (32.3%)   25 (33.8%)
      cl B.2                                                                            
      dcd B.2.2.3.1                    22 (30.6%)   13 (21.7%)   16 (25.8%)   27 (36.5%)
      dcd B.2.1.2.1                    26 (36.1%)   11 (18.3%)   13 (21.0%)   23 (31.1%)
      cl C.2                                                                            
      dcd C.2.1.2.1                    16 (22.2%)   15 (25.0%)   12 (19.4%)   21 (28.4%)
      cl D.1                                                                            
      dcd D.1.1.1.1                    24 (33.3%)   12 (20.0%)   18 (29.0%)   20 (27.0%)
      dcd D.1.1.4.2                    21 (29.2%)   13 (21.7%)   17 (27.4%)   21 (28.4%)

---

    Code
      t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A",
      2, split_by_study = TRUE, side_by_side = "GlobalAsia")
    Condition
      Warning in `build_table_header()`:
      split_by_study argument will be ignored
    Output
      Adverse Events with Difference
      
      ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
                                                                                                                      
      MedDRA System Organ Class                Global                                    Asia                         
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   All Patients   A: Drug X    B: Placebo   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                                          
        dcd A.1.1.1.1                  45 (33.6%)   31 (23.1%)    76 (28.4%)    29 (39.2%)   21 (25.9%)    50 (32.3%) 
      cl B.2                                                                                                          
        dcd B.2.1.2.1                  39 (29.1%)   34 (25.4%)    73 (27.2%)    23 (31.1%)   19 (23.5%)    42 (27.1%) 
      cl C.2                                                                                                          
        dcd C.2.1.2.1                  28 (20.9%)   36 (26.9%)    64 (23.9%)    20 (27.0%)   19 (23.5%)    39 (25.2%) 
      cl D.1                                                                                                          
        dcd D.1.1.1.1                  42 (31.3%)   32 (23.9%)    74 (27.6%)    29 (39.2%)   26 (32.1%)    55 (35.5%) 
        dcd D.1.1.4.2                  38 (28.4%)   34 (25.4%)    72 (26.9%)    21 (28.4%)   19 (23.5%)    40 (25.8%) 
      cl D.2                                                                                                          
        dcd D.2.1.5.3                  37 (27.6%)   46 (34.3%)    83 (31.0%)    21 (28.4%)   26 (32.1%)    47 (30.3%) 

