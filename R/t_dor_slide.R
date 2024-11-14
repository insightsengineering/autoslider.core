#' DOR table
#' @param adsl ADSL dataset
#' @param adtte ADTTE dataset
#' @param arm Arm variable, character, "`TRT01P" by default.
#' @param refgroup Reference group
#' @inherit gen_notes note
#'
#' @export
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl %>%
#'   dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
#' adtte <- eg_adtte %>%
#'   dplyr::filter(PARAMCD == "OS") %>%
#'   dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
#' out <- t_dor_slide(adsl, adtte)
#' print(out)
#' generate_slides(out, "dor.pptx")
t_dor_slide <- function(adsl, adtte, arm = "TRT01P", refgroup = NULL) {
  assert_that(has_name(adsl, arm))
  assert_that(has_name(adtte, "CNSR"))
  assert_that(has_name(adtte, "EVNTDESC"))
  assert_that(has_name(adtte, "AVALU"))
  assert_that(has_name(adtte, "AVAL"))
  assert_that(all(!is.na(adtte[["AVALU"]])))

  slref_arm <- sort(unique(adsl[[arm]]))
  anl_arm <- sort(unique(adtte[[arm]]))
  assert_that(identical(slref_arm, anl_arm),
    msg = "The adsl and the analysis datasets should have the same treatment arm levels"
  )


  time_unit <- unique(adtte[["AVALU"]])
  assert_that(length(time_unit) == 1)

  if (toupper(time_unit) == "DAYS") {
    adtte <- adtte %>%
      dplyr::mutate(AVAL = day2month(AVAL))
  } else if (toupper(time_unit) == "YEARS") {
    adtte <- adtte %>%
      dplyr::mutate(AVAL = AVAL * 12)
  }

  adtte_f <- adtte %>%
    dplyr::mutate(
      is_event = CNSR == 0,
      is_not_event = CNSR == 1,
      EVNT1 = factor(
        case_when(
          is_event == TRUE ~ "Responders with subsequent event (%)",
          is_event == FALSE ~ "Responders without subsequent event (%)"
        )
      ),
      EVNTDESC = factor(EVNTDESC)
    ) %>%
    semi_join(., adsl, by = c("STUDYID", "USUBJID")) %>%
    select(STUDYID, USUBJID, {{ arm }}, AVAL, is_event, is_not_event, EVNT1, EVNTDESC) %>%
    df_explicit_na(char_as_factor = FALSE)

  lyt_02 <- basic_table() %>%
    split_cols_by(
      var = arm,
      ref_group = refgroup
    ) %>%
    add_colcounts() %>%
    count_values(
      vars = "USUBJID",
      values = unique(adtte$USUBJID),
      .labels = "Responders",
      .stats = "count"
    ) %>%
    analyze_vars(
      vars = "is_event",
      .stats = "count_fraction",
      .labels = c(count_fraction = "With subsequent event (%)"),
      .indent_mods = c(count_fraction = 1L),
      show_labels = "hidden",
    ) %>%
    analyze(
      vars = "AVAL",
      afun = s_surv_time_1,
      extra_args = list(is_event = "is_event"),
      table_names = "est_prop",
      format = format_xx("xx.x (xx.x, xx.x)"),
      show_labels = "hidden",
      indent_mod = 1
    )

  result <- build_table(lyt_02, df = adtte_f, alt_counts_df = adsl)
  result@main_title <- "DOR slide"
  result
}
