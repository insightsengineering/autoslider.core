#' Adverse Events listing
#' adapted from https://insightsengineering.github.io/tlg-catalog/stable/listings/adverse-events/ael02.html
#' @param adsl ADSL data
#' @param adae ADAE data
#' @export
#' @examples
#' library(dplyr)
#' library(rlistings)
#' adsl <- eg_adsl
#' adae <- eg_adae
#'
#' l_ae_slide(adsl = adsl, adae = adae)
l_ae_slide <- function(adsl, adae) {
  assert_that(has_name(adae, c(
    "SITEID", "SUBJID", "AGE", "SEX", "RACE", "TRTSDTM", "AETOXGR",
    "AENDY", "ASTDY", "AESER", "AEREL", "AEOUT", "AECONTRT", "AEACN"
  )))

  # Preprocess data
  adsl_f <- adsl %>%
    df_explicit_na()

  adae_f <- adae %>%
    semi_join(., adsl_f, by = c("STUDYID", "USUBJID")) %>%
    df_explicit_na() %>%
    mutate(
      CPID = paste(SITEID, SUBJID, sep = "/"),
      ASR = paste(AGE, SEX, RACE, sep = "/"),
      Date_First = toupper(format(as.Date(TRTSDTM), "%d%b%Y")),
      Duration = AENDY - ASTDY + 1,
      Serious = ifelse(AESER == "Y", "Yes", ifelse(AESER == "N", "No", "")),
      Related = ifelse(AEREL == "Y", "Yes", ifelse(AEREL == "N", "No", "")),
      Outcome = case_when(
        AEOUT == "FATAL" ~ 1,
        AEOUT == "NOT RECOVERED/NOT RESOLVED" ~ 2,
        AEOUT == "RECOVERED/RESOLVED" ~ 3,
        AEOUT == "RECOVERED/RESOLVED WITH SEQUELAE" ~ 4,
        AEOUT == "RECOVERING/RESOLVING" ~ 5,
        AEOUT == "UNKNOWN" ~ 6
      ),
      Treated = ifelse(AECONTRT == "Y", "Yes", ifelse(AECONTRT == "N", "No", "")),
      Action = case_when(
        AEACN == "DOSE INCREASED" ~ 1,
        AEACN == "DOSE NOT CHANGED" ~ 2,
        AEACN == "DOSE REDUCED" | AEACN == "DOSE RATE REDUCED" ~ 3,
        AEACN == "DRUG INTERRUPTED" ~ 4,
        AEACN == "DRUG WITHDRAWN" ~ 5,
        AEACN == "NOT APPLICABLE" | AEACN == "NOT EVALUABLE" ~ 6,
        AEACN == "UNKNOWN" ~ 7
      )
    ) %>%
    select(
      CPID,
      # ASR,
      # TRT01A,
      AEDECOD,
      Date_First,
      # ASTDY,
      # Duration,
      Serious,
      # AESEV,
      Related,
      # Outcome,
      # Treated,
      AETOXGR,
      Action
    )


  formatters::var_labels(adae_f) <- c(
    CPID = "Center/Patient ID", # keep
    # ASR = "Age/Sex/Race",
    # TRT01A = "Treatment",                                      #keep
    AEDECOD = "Adverse\nEvent MedDRA\nPreferred Term", # keep
    Date_First = "Date of\nFirst Study\nDrug\nAdministration", # keep
    # ASTDY = "Study\nDay of\nOnset",
    # Duration = "AE\nDuration\nin Days",
    Serious = "Serious", # keep
    # AESEV = "Most\nExtreme\nIntensity",
    Related = "Caused by\nStudy\nDrug", # keep
    # Outcome = "Outcome\n(1)",
    # Treated = "Treatment\nfor AE",
    AETOXGR = "Analysis Toxicity Grade", # keep
    Action = "Action\nTaken\n(2)" # keep
  )

  # Set up listing

  lsting <- as_listing(
    adae_f,
    key_cols = c("CPID"),
    disp_cols = names(adae_f)
  )

  lsting
}
