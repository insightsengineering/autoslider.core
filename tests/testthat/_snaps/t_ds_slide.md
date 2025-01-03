# Test table creation of t_ds_slide

    Code
      t_ds_slide(adsl = testdata$adsl)
    Output
      Discontinue table
      
      ————————————————————————————————————————————————————————————————————————————————————————————————
                                          A: Drug X      B: Placebo     C: Combination   All Patients 
      ————————————————————————————————————————————————————————————————————————————————————————————————
      Received Treatment                134 (100.00%)   134 (100.00%)   132 (100.00%)    400 (100.00%)
      On-study Status                     3 (2.2%)        2 (1.5%)         4 (3.0%)        9 (2.2%)   
        On Treatment                          0               0               0                0      
        In Follow-up                      3 (2.2%)        2 (1.5%)          4 (3%)         9 (2.2%)   
      Discontinued the study             42 (31.3%)      40 (29.9%)       38 (28.8%)      120 (30.0%) 
        Adverse Event                     3 (2.2%)        6 (4.5%)         5 (3.8%)        14 (3.5%)  
        Death                            25 (18.7%)      23 (17.2%)       22 (16.7%)      70 (17.5%)  
        Lack Of Efficacy                  2 (1.5%)        2 (1.5%)         3 (2.3%)        7 (1.8%)   
        Physician Decision                2 (1.5%)        3 (2.2%)         2 (1.5%)        7 (1.8%)   
        Protocol Violation                5 (3.7%)        3 (2.2%)          4 (3%)          12 (3%)   
        Withdrawal By Parent/Guardian      4 (3%)         2 (1.5%)         1 (0.8%)        7 (1.8%)   
        Withdrawal By Subject             1 (0.7%)        1 (0.7%)         1 (0.8%)        3 (0.8%)   

---

    Code
      t_ds_slide(adsl = testdata$adsl, side_by_side = TRUE)
    Output
      Discontinue table
      
      ————————————————————————————————————————————————————————————————————————————————————————————————
                                          A: Drug X      B: Placebo     C: Combination   All Patients 
      ————————————————————————————————————————————————————————————————————————————————————————————————
      Received Treatment                134 (100.00%)   134 (100.00%)   132 (100.00%)    400 (100.00%)
      On-study Status                     3 (2.2%)        2 (1.5%)         4 (3.0%)        9 (2.2%)   
        On Treatment                          0               0               0                0      
        In Follow-up                      3 (2.2%)        2 (1.5%)          4 (3%)         9 (2.2%)   
      Discontinued the study             42 (31.3%)      40 (29.9%)       38 (28.8%)      120 (30.0%) 
        Adverse Event                     3 (2.2%)        6 (4.5%)         5 (3.8%)        14 (3.5%)  
        Death                            25 (18.7%)      23 (17.2%)       22 (16.7%)      70 (17.5%)  
        Lack Of Efficacy                  2 (1.5%)        2 (1.5%)         3 (2.3%)        7 (1.8%)   
        Physician Decision                2 (1.5%)        3 (2.2%)         2 (1.5%)        7 (1.8%)   
        Protocol Violation                5 (3.7%)        3 (2.2%)          4 (3%)          12 (3%)   
        Withdrawal By Parent/Guardian      4 (3%)         2 (1.5%)         1 (0.8%)        7 (1.8%)   
        Withdrawal By Subject             1 (0.7%)        1 (0.7%)         1 (0.8%)        3 (0.8%)   

---

    Code
      t_ds_slide(adsl = testdata$adsl, split_by_study = TRUE)
    Output
      Discontinue table
      
      —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
                                                         AB12345-1                                      AB12345-2                  
                                         A: Drug X      B: Placebo    C: Combination    A: Drug X      B: Placebo    C: Combination
      —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
      Received Treatment                62 (100.00%)   74 (100.00%)    64 (100.00%)    72 (100.00%)   60 (100.00%)    68 (100.00%) 
      On-study Status                     2 (3.2%)       0 (0.0%)        1 (1.6%)        1 (1.4%)       2 (3.3%)        3 (4.4%)   
        On Treatment                         0              0               0               0              0               0       
        In Follow-up                      2 (3.2%)          0            1 (1.6%)        1 (1.4%)       2 (3.3%)        3 (4.4%)   
      Discontinued the study             19 (30.6%)     24 (32.4%)      15 (23.4%)      23 (31.9%)     16 (26.7%)      23 (33.8%)  
        Adverse Event                     2 (3.2%)       4 (5.4%)        4 (6.2%)        1 (1.4%)       2 (3.3%)        1 (1.5%)   
        Death                            12 (19.4%)     13 (17.6%)      7 (10.9%)       13 (18.1%)     10 (16.7%)      15 (22.1%)  
        Lack Of Efficacy                  1 (1.6%)       2 (2.7%)           0            1 (1.4%)          0            3 (4.4%)   
        Physician Decision                2 (3.2%)       2 (2.7%)           0               0           1 (1.7%)        2 (2.9%)   
        Protocol Violation                1 (1.6%)       2 (2.7%)        2 (3.1%)        4 (5.6%)       1 (1.7%)        2 (2.9%)   
        Withdrawal By Parent/Guardian     1 (1.6%)       1 (1.4%)        1 (1.6%)        3 (4.2%)       1 (1.7%)           0       
        Withdrawal By Subject                0              0            1 (1.6%)        1 (1.4%)       1 (1.7%)           0       

---

    Code
      t_ds_slide(adsl = testdata$adsl, split_by_study = TRUE, side_by_side = TRUE)
    Condition
      Warning in `build_table_header()`:
      split_by_study argument will be ignored
    Output
      Discontinue table
      
      ————————————————————————————————————————————————————————————————————————————————————————————————
                                          A: Drug X      B: Placebo     C: Combination   All Patients 
      ————————————————————————————————————————————————————————————————————————————————————————————————
      Received Treatment                134 (100.00%)   134 (100.00%)   132 (100.00%)    400 (100.00%)
      On-study Status                     3 (2.2%)        2 (1.5%)         4 (3.0%)        9 (2.2%)   
        On Treatment                          0               0               0                0      
        In Follow-up                      3 (2.2%)        2 (1.5%)          4 (3%)         9 (2.2%)   
      Discontinued the study             42 (31.3%)      40 (29.9%)       38 (28.8%)      120 (30.0%) 
        Adverse Event                     3 (2.2%)        6 (4.5%)         5 (3.8%)        14 (3.5%)  
        Death                            25 (18.7%)      23 (17.2%)       22 (16.7%)      70 (17.5%)  
        Lack Of Efficacy                  2 (1.5%)        2 (1.5%)         3 (2.3%)        7 (1.8%)   
        Physician Decision                2 (1.5%)        3 (2.2%)         2 (1.5%)        7 (1.8%)   
        Protocol Violation                5 (3.7%)        3 (2.2%)          4 (3%)          12 (3%)   
        Withdrawal By Parent/Guardian      4 (3%)         2 (1.5%)         1 (0.8%)        7 (1.8%)   
        Withdrawal By Subject             1 (0.7%)        1 (0.7%)         1 (0.8%)        3 (0.8%)   
