# Test DOR table when time unit is 'DAYS'

    Code
      t_dor_slide(adsl, adtte)
    Output
      DOR slide
      
      ——————————————————————————————————————————————————————————————————————————
                                     A: Drug X      B: Placebo    C: Combination
                                      (N=134)        (N=134)         (N=132)    
      ——————————————————————————————————————————————————————————————————————————
      Responders                        134            134             132      
        With subsequent event (%)    58 (43.3%)     58 (43.3%)      69 (52.3%)  
        Median (Months, 95% CI)     NA (9.3, NA)   NA (9.4, NA)   9.4 (7.6, NA) 

# Test DOR table when time unit is 'YEARS'

    Code
      t_dor_slide(adsl, adtte)
    Output
      DOR slide
      
      —————————————————————————————————————————————————————————————————————————————————————
                                       A: Drug X        B: Placebo        C: Combination   
                                        (N=134)           (N=134)             (N=132)      
      —————————————————————————————————————————————————————————————————————————————————————
      Responders                          134               134                 132        
        With subsequent event (%)     58 (43.3%)        58 (43.3%)          69 (52.3%)     
        Median (Months, 95% CI)     NA (3397.7, NA)   NA (3447.1, NA)   3439.6 (2784.8, NA)

