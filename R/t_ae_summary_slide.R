#' Adverse event summary table
#'
#' @param adsl ADSL dataset, dataframe
#' @param adae ADAE dataset, dataframe
#' @param arm Arm variable, character, "`TRT01A" by default.
#' @param dose_adjust_flags Character or a vector of characters. Each character is a variable
#'  name in adae dataset. These variables are Logical vectors which flag AEs
#'  leading to dose adjustment, such as drug discontinuation, dose interruption
#'  and reduction. The flag can be related to any drug, or a specific drug.
#' @param dose_adjust_labels Character or a vector of characters. Each character represents
#'  a label displayed in the AE summary table (e.g. AE leading to discontinuation
#'  from drug X). The order of the labels should match the order of variable
#'  names in \code{dose_adjust_flags}.
#' @param gr34_highest_grade_only A logical value. Default is TRUE, such that
#'  only patients with the highest AE grade as 3 or 4 are included for the count of the "Grade 3-4 AE" and
#'  "Treatment-related Grade 3-4 AE" ; set it to FALSE if
#'  you want to include patients with the highest AE grade as 5.
#'
#' @return an rtables object
#' @export
#'
#' @examples
#' ADSL <- eg_adsl
#' ADAE <- eg_adae
#'
#' ADAE <- ADAE %>%
#'   dplyr::mutate(ATOXGR = AETOXGR)
#' t_ae_summ_slide(adsl = ADSL, adae = ADAE)
#'
#' # add flag for ae leading to dose reduction
#' ADAE$reduce_flg <- ifelse(ADAE$AEACN == "DOSE REDUCED", TRUE, FALSE)
#' t_ae_summ_slide(
#'   adsl = ADSL, adae = ADAE,
#'   dose_adjust_flags = c("reduce_flg"),
#'   dose_adjust_labels = c("AE leading to dose reduction of drug X")
#' )
#' # add flgs for ae leading to dose reduction, drug withdraw and drug interruption
#' ADAE$withdraw_flg <- ifelse(ADAE$AEACN == "DRUG WITHDRAWN", TRUE, FALSE)
#' ADAE$interrup_flg <- ifelse(ADAE$AEACN == "DRUG INTERRUPTED", TRUE, FALSE)
#' out <- t_ae_summ_slide(
#'   adsl = ADSL, adae = ADAE, arm = "TRT01A",
#'   dose_adjust_flags = c("withdraw_flg", "reduce_flg", "interrup_flg"),
#'   dose_adjust_labels = c(
#'     "AE leading to discontinuation from drug X",
#'     "AE leading to drug X reduction",
#'     "AE leading to drug X interruption"
#'   )
#' )
#' print(out)
#' generate_slides(out, "ae_summary.pptx")
t_ae_summ_slide <- function(adsl, adae, arm = "TRT01A",
                            dose_adjust_flags = NA,
                            dose_adjust_labels = NA,
                            gr34_highest_grade_only = TRUE) {
  # The gr3-4 only count the patients whose highest ae grade is 3 or 4
  assert_that(has_name(adae, "TRT01A"))
  assert_that(has_name(adae, "AEDECOD"))
  assert_that(has_name(adae, "AEBODSYS"))
  assert_that(has_name(adae, "ATOXGR"))
  assert_that(has_name(adae, "AEREL"))
  assert_that(has_name(adae, "ANL01FL"))
  assert_that(has_name(adae, "SAFFL"))
  assert_that(has_name(adae, "TRTEMFL"))
  assert_that(has_name(adae, "AESER"))
  assert_that(length(dose_adjust_flags) == length(dose_adjust_labels))
  assert_that(assertthat::is.flag(gr34_highest_grade_only))


  if (sum(is.na(dose_adjust_flags)) == 0 & sum(is.na(dose_adjust_labels)) == 0) {
    for (txt in dose_adjust_flags) {
      assert_that(all(unlist(adae[txt]) %in% c(TRUE, FALSE)))
      assert_that(has_name(adae, txt))
    }
  }

  adsl1 <- adsl %>%
    select("STUDYID", "USUBJID", "TRT01A")

  pts_gr5 <- adae %>% filter(ATOXGR %in% c(5))

  anl <- adae %>%
    mutate_at(
      c("AEDECOD", "AEBODSYS"),
      ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
    ) %>%
    mutate(
      ATOXGR = sas_na(ATOXGR) %>% as.factor(),
      ATOXGR2 = case_when(
        ATOXGR %in% c(1, 2) ~ "1 - 2",
        ATOXGR %in% c(3, 4) ~ "3 - 4",
        ATOXGR %in% c(5) ~ "5",
      ) %>% as.factor(),
      TRT01A = sas_na(TRT01A) %>% as.factor()
    ) %>%
    semi_join(., adsl1, by = c("STUDYID", "USUBJID")) %>%
    filter(ANL01FL == "Y" & TRTEMFL == "Y" & SAFFL == "Y") %>%
    var_relabel(
      ATOXGR2 = "AE Grade 3 groups",
      ATOXGR = "AE Grade",
      TRT01A = "Actual Treatment 01"
    ) %>%
    # ---------- ADAE: Treatment related flags ---------
    mutate(
      TMPFL1_REL0 = AEREL == "Y"
    ) %>%
    var_relabel(
      TMPFL1_REL0 = "Any treatment"
    ) %>%
    # ---------- ADAE: Grade 5 and related flags ---------
    mutate(
      TMPFL1_G5 = ATOXGR %in% c(5),
      TMPFL1_G5_REL = ATOXGR %in% c(5) & AEREL == "Y"
    ) %>%
    var_relabel(
      TMPFL1_G5 = "Grade 5 AE",
      TMPFL1_G5_REL = "Treatment-related Grade 5 AE"
    ) %>%
    # ---------- ADAE: SAE and related flags ---------
    mutate(
      TMPFL1_SER = AESER == "Y",
      TMPFL1_SER_REL = AESER == "Y" & AEREL == "Y"
    ) %>%
    var_relabel(
      TMPFL1_SER = "Serious AE",
      TMPFL1_SER_REL = "Treatment-related Serious AE"
    )

  # ---------- ADAE: Grade 3/4 and related flags ---------
  if (gr34_highest_grade_only == TRUE) {
    anl <- anl %>%
      mutate(
        TMPFL1_G34 = ATOXGR %in% c(3, 4) & !(USUBJID %in% pts_gr5$USUBJID), # Only count the highest grade is 3 or 4
        TMPFL1_G34_REL = ATOXGR %in% c(3, 4) & AEREL == "Y" & !(USUBJID %in% pts_gr5$USUBJID)
      ) %>%
      var_relabel(
        TMPFL1_G34 = "Grade 3-4 AE",
        TMPFL1_G34_REL = "Treatment-related Grade 3-4 AE"
      )
  } else {
    anl <- anl %>%
      mutate(
        TMPFL1_G34 = ATOXGR %in% c(3, 4),
        TMPFL1_G34_REL = ATOXGR %in% c(3, 4) & AEREL == "Y"
      ) %>%
      var_relabel(
        TMPFL1_G34 = "Grade 3-4 AE",
        TMPFL1_G34_REL = "Treatment-related Grade 3-4 AE"
      )
  }

  if (nrow(anl) == 0) {
    return(null_report())
  } else {
    lyt <- basic_table() %>%
      split_cols_by(arm, split_fun = add_overall_level("All Patients", first = FALSE)) %>%
      add_colcounts() %>%
      count_patients_with_event(
        vars = "USUBJID",
        table_names = "U",
        filters = c("SAFFL" = "Y"),
        denom = "N_col",
        .stats = "count_fraction",
        .labels = c(count_fraction = "All grade AEs, any cause")
        # .formats = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_REL0 = "Related"),
        denom = "N_col",
        .indent_mods = 1L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_G34 = "Grade 3-4 AEs"),
        denom = "N_col",
        .indent_mods = 0L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_G34_REL = "Related"),
        denom = "N_col",
        .indent_mods = 1L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_G5 = "Grade 5 AE"),
        denom = "N_col",
        .indent_mods = 0L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_G5_REL = "Related"),
        denom = "N_col",
        .indent_mods = 1L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_SER = "SAEs"),
        denom = "N_col",
        .indent_mods = 0L
        # .format = list(trim_perc1)
      ) %>%
      count_patients_with_flags(
        "USUBJID",
        flag_variables = c(TMPFL1_SER_REL = "Related"),
        denom = "N_col",
        .indent_mods = 1L
        # .format = list(trim_perc1)
      )

    if (sum(is.na(dose_adjust_flags)) == 0 & sum(is.na(dose_adjust_labels)) == 0) {
      for (i in 1:length(dose_adjust_flags)) {
        text <- paste0(
          '     lyt <- lyt %>%
       count_patients_with_flags(
         "USUBJID",
         flag_variables = c(', dose_adjust_flags[i], "='", dose_adjust_labels[i],
          "'),
                    denom = 'N_col',
         .indent_mods = 0L)"
        )
        eval(parse(text = text))
      }
    }

    result <- build_table(
      lyt,
      df = anl,
      alt_counts_df = adsl
    )
    result@main_title <- "AE summary table"
  }

  return(result)
}
