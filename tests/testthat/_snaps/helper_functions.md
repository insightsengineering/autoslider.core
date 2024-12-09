# Test some functions in helper_functions.R

    Code
      mutate_actarm(adsl)
    Output
      # A tibble: 400 x 63
         STUDYID   USUBJID  SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
         <chr>     <chr>    <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
       1 AB12345-1 AB12345~ id-128 CHN-3     32 YEARS M     ASIAN HISPA~ CHN     Y    
       2 AB12345-2 AB12345~ id-262 CHN-15    35 YEARS M     BLAC~ NOT H~ CHN     N    
       3 AB12345-1 AB12345~ id-378 RUS-3     30 YEARS F     ASIAN NOT H~ RUS     N    
       4 AB12345-2 AB12345~ id-220 CHN-11    26 YEARS F     ASIAN NOT H~ CHN     N    
       5 AB12345-1 AB12345~ id-267 CHN-7     40 YEARS M     ASIAN NOT H~ CHN     N    
       6 AB12345-2 AB12345~ id-201 CHN-15    49 YEARS M     ASIAN NOT H~ CHN     Y    
       7 AB12345-1 AB12345~ id-45  USA-1     34 YEARS F     ASIAN NOT H~ USA     N    
       8 AB12345-2 AB12345~ id-261 USA-1     32 YEARS F     ASIAN NOT H~ USA     N    
       9 AB12345-1 AB12345~ id-173 NGA-11    24 YEARS F     BLAC~ NOT H~ NGA     N    
      10 AB12345-2 AB12345~ id-307 CHN-1     24 YEARS M     ASIAN NOT H~ CHN     Y    
      # i 390 more rows
      # i 52 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>, ...

