# Test data snapshot

    Code
      dim(get(datai))
    Output
      [1] 1934   93

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 93
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-134 BRA-1     47 YEARS M     WHITE NOT H~ BRA     Y    
      2 AB12345-2 AB12345-~ id-134 BRA-1     47 YEARS M     WHITE NOT H~ BRA     Y    
      3 AB12345-2 AB12345-~ id-134 BRA-1     47 YEARS M     WHITE NOT H~ BRA     Y    
      4 AB12345-2 AB12345-~ id-134 BRA-1     47 YEARS M     WHITE NOT H~ BRA     Y    
      5 AB12345-1 AB12345-~ id-141 BRA-1     35 YEARS F     WHITE NOT H~ BRA     N    
      6 AB12345-1 AB12345-~ id-141 BRA-1     35 YEARS F     WHITE NOT H~ BRA     N    
      # i 82 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 13600    88

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 88
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      # i 77 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 6400   79

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 79
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      # i 68 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 8400  102

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 102
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      # i 91 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 3200   65

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 65
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      # i 54 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 400  56

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 56
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-1 AB12345-~ id-128 CHN-3     32 YEARS M     ASIAN HISPA~ CHN     Y    
      2 AB12345-2 AB12345-~ id-262 CHN-15    35 YEARS M     BLAC~ NOT H~ CHN     N    
      3 AB12345-1 AB12345-~ id-378 RUS-3     30 YEARS F     ASIAN NOT H~ RUS     N    
      4 AB12345-2 AB12345-~ id-220 CHN-11    26 YEARS F     ASIAN NOT H~ CHN     N    
      5 AB12345-1 AB12345-~ id-267 CHN-7     40 YEARS M     ASIAN NOT H~ CHN     N    
      6 AB12345-2 AB12345-~ id-201 CHN-15    49 YEARS M     ASIAN NOT H~ CHN     Y    
      # i 45 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 2800   76

---

    Code
      head(get(datai))
    Output
          STUDYID              USUBJID SUBJID SITEID AGE  AGEU SEX
      1 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
      2 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
      3 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
      4 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
      5 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
      6 AB12345-2 AB12345-BRA-1-id-105 id-105  BRA-1  38 YEARS   M
                             RACE             ETHNIC COUNTRY DTHFL        INVID
      1 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
      2 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
      3 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
      4 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
      5 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
      6 BLACK OR AFRICAN AMERICAN HISPANIC OR LATINO     BRA     N INV ID BRA-1
               INVNAM       ARM ARMCD    ACTARM ACTARMCD    TRT01P    TRT01A
      1 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
      2 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
      3 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
      4 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
      5 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
      6 Dr. BRA-1 Doe A: Drug X ARM A A: Drug X    ARM A A: Drug X A: Drug X
                TRT02P    TRT02A       REGION1 STRATA1 STRATA2   BMRKR1 BMRKR2 ITTFL
      1 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
      2 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
      3 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
      4 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
      5 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
      6 C: Combination A: Drug X South America       B      S1 4.156914 MEDIUM     Y
        SAFFL BMEASIFL BEP01FL AEWITHFL     RANDDT             TRTSDTM
      1     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
      2     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
      3     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
      4     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
      5     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
      6     Y        Y       Y        N 2020-03-08 2020-03-08 05:39:28
                    TRTEDTM           TRT01SDTM           TRT01EDTM
      1 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
      2 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
      3 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
      4 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
      5 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
      6 2022-02-14 20:58:26 2020-03-08 05:39:28 2021-02-14 14:58:26
                  TRT02SDTM           TRT02EDTM            AP01SDTM
      1 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
      2 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
      3 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
      4 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
      5 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
      6 2021-02-14 14:58:26 2022-02-14 20:58:26 2020-03-08 05:39:28
                   AP01EDTM            AP02SDTM            AP02EDTM       EOSSTT
      1 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
      2 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
      3 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
      4 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
      5 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
      6 2021-02-14 14:58:26 2021-02-14 14:58:26 2022-02-14 20:58:26 DISCONTINUED
              EOTSTT      EOSDT EOSDY            DCSREAS DTHDT DTHCAUS DTHCAT
      1 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
      2 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
      3 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
      4 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
      5 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
      6 DISCONTINUED 2022-02-14   709 PROTOCOL VIOLATION  <NA>    <NA>   <NA>
        LDDTHELD LDDTHGR1   LSTALVDT DTHADY ADTHAUT AGEGR1  TRTDURD DCSREAS_GRP
      1       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
      2       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
      3       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
      4       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
      5       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
      6       NA     <NA> 2022-03-09     NA    <NA>    <65 707.6382  Non-Safety
                                          PARAM PARAMCD                AVISIT AVISITN
      1 Sum of Longest Diameter by Investigator  SLDINV POST-BASELINE MINIMUM     999
      2 Sum of Longest Diameter by Investigator  SLDINV      END OF INDUCTION     999
      3 Sum of Longest Diameter by Investigator  SLDINV              BASELINE       0
      4 Sum of Longest Diameter by Investigator  SLDINV         CYCLE 4 DAY 1       4
      5 Sum of Longest Diameter by Investigator  SLDINV             SCREENING      -1
      6 Sum of Longest Diameter by Investigator  SLDINV             FOLLOW UP     999
              ADTM  ADY   DTYPE     AVAL            AVALC AVALU     BASE ABLFL
      1 2021-06-19  468 MINIMUM 141.6140 141.614020702645    mm 167.4415      
      2 2021-06-19  468         141.6140 141.614020702645    mm 167.4415      
      3 2020-03-08    0               NA             <NA>    mm 167.4415     Y
      4 2021-07-27  506         195.2095 195.209453323539    mm 167.4415      
      5 2019-11-29 -100         171.4226 171.422566332973    mm 167.4415      
      6 2022-01-06  669         210.8322 210.832161998961    mm 167.4415      
              CHG      PCHG ONTRTFL ANL01FL ANL02FL ANL03FL
      1 -25.82752 -15.42480       Y                       Y
      2 -25.82752 -15.42480       Y       Y                
      3        NA        NA                       Y       Y
      4  27.76791  16.58365       Y       Y                
      5        NA        NA                                
      6  43.39062  25.91389               Y       Y        

---

    Code
      dim(get(datai))
    Output
      [1] 2000   67

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 67
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-134 BRA-1     47 YEARS M     WHITE NOT H~ BRA     Y    
      # i 56 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

---

    Code
      dim(get(datai))
    Output
      [1] 16800    87

---

    Code
      head(get(datai))
    Output
      # A tibble: 6 x 87
        STUDYID   USUBJID   SUBJID SITEID   AGE AGEU  SEX   RACE  ETHNIC COUNTRY DTHFL
        <chr>     <chr>     <chr>  <chr>  <int> <fct> <fct> <fct> <fct>  <fct>   <fct>
      1 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      2 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      3 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      4 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      5 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      6 AB12345-2 AB12345-~ id-105 BRA-1     38 YEARS M     BLAC~ HISPA~ BRA     N    
      # i 76 more variables: INVID <chr>, INVNAM <chr>, ARM <fct>, ARMCD <fct>,
      #   ACTARM <fct>, ACTARMCD <fct>, TRT01P <fct>, TRT01A <fct>, TRT02P <fct>,
      #   TRT02A <fct>, REGION1 <fct>, STRATA1 <fct>, STRATA2 <fct>, BMRKR1 <dbl>,
      #   BMRKR2 <fct>, ITTFL <fct>, SAFFL <fct>, BMEASIFL <fct>, BEP01FL <fct>,
      #   AEWITHFL <fct>, RANDDT <date>, TRTSDTM <dttm>, TRTEDTM <dttm>,
      #   TRT01SDTM <dttm>, TRT01EDTM <dttm>, TRT02SDTM <dttm>, TRT02EDTM <dttm>,
      #   AP01SDTM <dttm>, AP01EDTM <dttm>, AP02SDTM <dttm>, AP02EDTM <dttm>, ...

