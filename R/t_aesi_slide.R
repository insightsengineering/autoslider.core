#' Table of AEs of Special Interest
#' adapted from https://insightsengineering.github.io/tlg-catalog/stable/tables/adverse-events/aet01_aesi.html
#' @param adsl ADSL data set, dataframe
#' @param adae ADAE data set, dataframe.
#' @param aesi AESI variable which will act as a filter to select the rows required to create the table.
#' An example of AESI variable is CQ01NAM.
#' @param arm Arm variable, character, `"ACTARM"` by default.
#' @param grad_var Grading variable, character, `"AETOXGR"` by default.
#'
#' @return rtables object
#' @export
#' @author Kai Xiang Lim (`limk43`)
#'
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl
#' adae <- eg_adae
#' adae_atoxgr <- adae %>% dplyr::mutate(ATOXGR = AETOXGR)
#' t_aesi_slide(adsl, adae, aesi = "CQ01NAM")
#' t_aesi_slide(adsl, adae, aesi = "CQ01NAM", arm = "ARM", grad_var = "AESEV")
#' t_aesi_slide(adsl, adae_atoxgr, aesi = "CQ01NAM", grad_var = "ATOXGR")
#'
t_aesi_slide <- function(adsl, adae, aesi, arm = "ACTARM", grad_var = "AETOXGR") {
  assert_that(has_name(adsl, arm))
  assert_that(has_name(adae, "AEACN"))
  assert_that(has_name(adae, "AEOUT"))
  assert_that(has_name(adae, "AECONTRT"))
  assert_that(has_name(adae, "AESER"))
  assert_that(has_name(adae, "AEREL"))
  assert_that(has_name(adae, grad_var))
  assert_that(has_name(adae, "AECONTRT"))

  aesi_sym <- rlang::sym(aesi)


  adae2 <- filter(adae, is.na(!!aesi_sym))

  adsl <- df_explicit_na(adsl)
  adae2 <- df_explicit_na(adae2)

  # Merge ADAE with ADSL and ensure character variables are converted to factors and empty
  # strings and NAs are explicit missing levels.
  adae2 <- adsl %>%
    inner_join(adae2, by = c("USUBJID", "TRT01A", "TRT01P", "ARM", "ARMCD", "ACTARM", "ACTARMCD")) %>%
    df_explicit_na()

  not_resolved <- adae2 %>%
    filter(!(AEOUT %in% c("RECOVERED/RESOLVED", "FATAL", "RECOVERED/RESOLVED WITH SEQUELAE"))) %>%
    distinct(USUBJID) %>%
    mutate(NOT_RESOLVED = "Y")

  adae2 <- adae2 %>%
    left_join(not_resolved, by = c("USUBJID")) %>%
    mutate(
      ALL_RESOLVED = formatters::with_label(
        is.na(NOT_RESOLVED),
        "Total number of patients with all non-fatal AESIs resolved"
      ),
      NOT_RESOLVED = formatters::with_label(
        !is.na(NOT_RESOLVED),
        "Total number of patients with at least one unresolved or ongoing non-fatal AESI"
      )
    )

  adae2 <- adae2 %>%
    mutate(
      AEDECOD = as.character(AEDECOD),
      WD = formatters::with_label(
        AEACN == "DRUG WITHDRAWN", "Total number of patients with study drug withdrawn due to AESI"
      ),
      DSM = formatters::with_label(
        AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
        "Total number of patients with dose modified/interrupted due to AESI"
      ),
      CONTRT = formatters::with_label(AECONTRT == "Y", "Total number of patients with treatment received for AESI"),
      SER = formatters::with_label(AESER == "Y", "Total number of patients with at least one serious AESI"),
      REL = formatters::with_label(AEREL == "Y", "Total number of patients with at least one related AESI"),
      ALL_RESOLVED_WD = formatters::with_label(
        WD == TRUE & ALL_RESOLVED == TRUE,
        "No. of patients with study drug withdrawn due to resolved AESI"
      ),
      ALL_RESOLVED_DSM = formatters::with_label(
        DSM == TRUE & ALL_RESOLVED == TRUE,
        "No. of patients with dose modified/interrupted due to resolved AESI"
      ),
      ALL_RESOLVED_CONTRT = formatters::with_label(
        CONTRT == TRUE & ALL_RESOLVED == TRUE,
        "No. of patients with treatment received for resolved AESI"
      ),
      NOT_RESOLVED_WD = formatters::with_label(
        WD == TRUE & NOT_RESOLVED == TRUE,
        "No. of patients with study drug withdrawn due to unresolved or ongoing AESI"
      ),
      NOT_RESOLVED_DSM = formatters::with_label(
        DSM == TRUE & NOT_RESOLVED == TRUE,
        "No. of patients with dose modified/interrupted due to unresolved or ongoing AESI"
      ),
      NOT_RESOLVED_CONTRT = formatters::with_label(
        CONTRT == TRUE & NOT_RESOLVED == TRUE,
        "No. of patients with treatment received for unresolved or ongoing AESI"
      ),
      SERWD = formatters::with_label(
        AESER == "Y" & AEACN == "DRUG WITHDRAWN",
        "No. of patients with study drug withdrawn due to serious AESI"
      ),
      SERCONTRT = formatters::with_label(
        AECONTRT == "Y" & AESER == "Y",
        "No. of patients with dose modified/interrupted due to serious AESI"
      ),
      SERDSM = formatters::with_label(
        AESER == "Y" & AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
        "No. of patients with treatment received for serious AESI"
      ),
      RELWD = formatters::with_label(
        AEREL == "Y" & AEACN == "DRUG WITHDRAWN",
        "No. of patients with study drug withdrawn due to related AESI"
      ),
      RELDSM = formatters::with_label(
        AEREL == "Y" & AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
        "No. of patients with dose modified/interrupted due to related AESI"
      ),
      RELCONTRT = formatters::with_label(
        AECONTRT == "Y" & AEREL == "Y",
        "No. of patients with treatment received for related AESI"
      ),
      RELSER = formatters::with_label(AESER == "Y" & AEREL == "Y", "No. of patients with serious, related AESI")
    )

  if (grad_var %in% c("AETOXGR", "ATOXGR")) {
    adae2 <- adae2 %>%
      mutate(
        {{ grad_var }} := forcats::fct_recode(get(grad_var),
          "Grade 1" = "1",
          "Grade 2" = "2",
          "Grade 3" = "3",
          "Grade 4" = "4",
          "Grade 5 (fatal outcome)" = "5"
        )
      )
  } else if (grad_var %in% c("AESEV", "ASEV")) {
    adae2 <- adae2 %>%
      mutate(
        {{ grad_var }} := forcats::fct_recode(stringr::str_to_title(get(grad_var), locale = "en"))
      )
  }

  aesi_vars <- c("WD", "DSM", "CONTRT", "ALL_RESOLVED", "NOT_RESOLVED", "SER", "REL")

  lyt_adae <- basic_table(show_colcounts = TRUE) %>%
    split_cols_by(arm) %>%
    count_patients_with_event(
      vars = "USUBJID",
      filters = c("ANL01FL" = "Y"),
      denom = "N_col",
      .labels = c(count_fraction = "Total number of patients with at least one AESI")
    ) %>%
    count_values(
      "ANL01FL",
      values = "Y",
      .stats = "count",
      .labels = c(count = "Total number of AESIs"),
      table_names = "total_aes"
    ) %>%
    count_occurrences_by_grade(
      var = grad_var,
      var_labels = "Total number of patients with at least one AESI by worst grade",
      show_labels = "visible"
    ) %>%
    count_patients_with_flags("USUBJID", flag_variables = aesi_vars, denom = "N_col")

  result <- build_table(lyt_adae, df = adae2, alt_counts_df = adsl)


  result
}
