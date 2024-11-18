# Test table creation of t_ae_pt_slide (safety summary table)

    Code
      t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 2)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)     46 (34.8%)     119 (29.8%) 
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)     48 (36.4%)     112 (28.0%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)     40 (30.3%)     112 (28.0%) 
      dcd B.1.1.1.1                    38 (28.4%)   37 (27.6%)     36 (27.3%)     111 (27.8%) 
      dcd C.1.1.1.3                    36 (26.9%)   34 (25.4%)     36 (27.3%)     106 (26.5%) 

# Test table creation of t_ae_pt_slide (safety summary table) prune by total 28

    Code
      t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 28, prune_by_total = TRUE)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)     46 (34.8%)     119 (29.8%) 
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)     48 (36.4%)     112 (28.0%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)     40 (30.3%)     112 (28.0%) 

# Test table creation of t_ae_pt_slide (safety summary table) prune by total 30

    Code
      t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 30, prune_by_total = TRUE)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 

# Test table creation of t_ae_pt_soc_slide (safety summary table)

    Code
      t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 2)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class                                                               
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                  
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      cl B.1                                                                                  
      dcd B.1.1.1.1                    38 (28.4%)   37 (27.6%)     36 (27.3%)     111 (27.8%) 
      cl B.2                                                                                  
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)     46 (34.8%)     119 (29.8%) 
      cl C.1                                                                                  
      dcd C.1.1.1.3                    36 (26.9%)   34 (25.4%)     36 (27.3%)     106 (26.5%) 
      cl C.2                                                                                  
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)     48 (36.4%)     112 (28.0%) 
      cl D.1                                                                                  
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)     40 (30.3%)     112 (28.0%) 
      cl D.2                                                                                  
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 

# Test table creation of t_ae_pt_soc_slide (safety summary table) prune by total 28

    Code
      t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 28, prune_by_total = TRUE)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class                                                               
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                  
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      cl B.2                                                                                  
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      dcd B.2.1.2.1                    39 (29.1%)   34 (25.4%)     46 (34.8%)     119 (29.8%) 
      cl C.2                                                                                  
      dcd C.2.1.2.1                    28 (20.9%)   36 (26.9%)     48 (36.4%)     112 (28.0%) 
      cl D.1                                                                                  
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 
      dcd D.1.1.4.2                    38 (28.4%)   34 (25.4%)     40 (30.3%)     112 (28.0%) 
      cl D.2                                                                                  
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 

# Test table creation of t_ae_pt_soc_slide (safety summary table) prune by total 30

    Code
      t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 30, prune_by_total = TRUE)
    Output
      Adverse Events table
      
      ————————————————————————————————————————————————————————————————————————————————————————
      MedDRA System Organ Class                                                               
         MedDRA Preferred Term N (%)   A: Drug X    B: Placebo   C: Combination   All Patients
      ————————————————————————————————————————————————————————————————————————————————————————
      cl A.1                                                                                  
      dcd A.1.1.1.1                    45 (33.6%)   31 (23.1%)     52 (39.4%)     128 (32.0%) 
      dcd A.1.1.1.2                    41 (30.6%)   39 (29.1%)     42 (31.8%)     122 (30.5%) 
      cl B.2                                                                                  
      dcd B.2.2.3.1                    38 (28.4%)   40 (29.9%)     45 (34.1%)     123 (30.8%) 
      cl D.1                                                                                  
      dcd D.1.1.1.1                    42 (31.3%)   32 (23.9%)     46 (34.8%)     120 (30.0%) 
      cl D.2                                                                                  
      dcd D.2.1.5.3                    37 (27.6%)   46 (34.3%)     50 (37.9%)     133 (33.2%) 

