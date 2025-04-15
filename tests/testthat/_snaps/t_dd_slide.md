# Test table creation of t_dd_slide (death table)

    Code
      t_dd_slide(testdata$adsl, "TRT01A")
    Output
      Death table
      
      —————————————————————————————————————————————————————————————————————————————————
      N (%)                    A: Drug X    B: Placebo    C: Combination   All Patients
      —————————————————————————————————————————————————————————————————————————————————
      All Deaths              25 (18.66%)   23 (17.16%)    22 (16.67%)     70 (17.50%) 
                                                                                       
        Progressive Disease     8 (32%)      6 (26.1%)      6 (27.3%)       20 (28.6%) 
        Adverse Events          9 (36%)      7 (30.4%)      10 (45.5%)      26 (37.1%) 
        Other                   8 (32%)     10 (43.5%)      6 (27.3%)       24 (34.3%) 

---

    Code
      t_dd_slide(testdata$adsl, "TRT01A", split_by_study = TRUE)
    Output
      Death table
      
      ———————————————————————————————————————————————————————————————————————————————————————————————————————————————
                                              AB12345-1                                    AB12345-2                 
      N (%)                    A: Drug X    B: Placebo    C: Combination    A: Drug X    B: Placebo    C: Combination
      ———————————————————————————————————————————————————————————————————————————————————————————————————————————————
      All Deaths              12 (19.35%)   13 (17.57%)     7 (10.94%)     13 (18.06%)   10 (16.67%)    15 (22.06%)  
                                                                                                                     
        Progressive Disease    4 (33.3%)     3 (23.1%)      3 (42.9%)       4 (30.8%)      3 (30%)        3 (20%)    
        Adverse Events         5 (41.7%)     5 (38.5%)      2 (28.6%)       4 (30.8%)      2 (20%)       8 (53.3%)   
        Other                   3 (25%)      5 (38.5%)      2 (28.6%)       5 (38.5%)      5 (50%)       4 (26.7%)   

---

    Code
      t_dd_slide(testdata$adsl, "TRT01A", split_by_study = TRUE, side_by_side = "GlobalChina")
    Condition
      Warning in `build_table_header()`:
      split_by_study argument will be ignored
    Output
      Death table
      
      —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
                                                                                                                                                   
                                                Global                                                      China                                  
      N (%)                    A: Drug X    B: Placebo    C: Combination   All Patients    A: Drug X    B: Placebo    C: Combination   All Patients
      —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
      All Deaths              25 (18.66%)   23 (17.16%)    22 (16.67%)     70 (17.50%)    15 (20.27%)   15 (18.52%)     8 (12.50%)     38 (17.35%) 
                                                                                                                                                   
        Progressive Disease     8 (32%)      6 (26.1%)      6 (27.3%)       20 (28.6%)     5 (33.3%)      3 (20%)       3 (37.5%)       11 (28.9%) 
        Adverse Events          9 (36%)      7 (30.4%)      10 (45.5%)      26 (37.1%)      3 (20%)       6 (40%)       3 (37.5%)       12 (31.6%) 
        Other                   8 (32%)     10 (43.5%)      6 (27.3%)       24 (34.3%)     7 (46.7%)      6 (40%)        2 (25%)        15 (39.5%) 

# Test t_dd_slide table with expected Error

    Code
      t_dd_slide(adsl, "TRT")
    Condition
      Error in `fix_one_split_var()`:
      ! Split variable [TRT] not found in data being tabulated.

# Test table creation of with null_report

    Code
      t_dd_slide(testdata$adsl[0, ], "TRT01A")
    Output
                                                                                              
      ————————————————————————————————————————————————————————————————————————————————————————
         Null Report: No observations met the reporting criteria for inclusion in this output.

