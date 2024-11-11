#' Death table
#'
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01A" by default.
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side used for studies in China. "GlobalAsia" or "GlobalAsiaChina" to define
#' the side by side requirement.
#' @return rtables object
#' @inherit gen_notes note
#' @export
#' @examples
#'
#' adsl <- eg_adsl %>% preprocess_t_dd()
#' out1 <- t_dd_slide(adsl, "TRT01A")
#' print(out1)
#' generate_slides(out1, "dd.pptx")
#'
#' out2 <- t_dd_slide(adsl, "TRT01A", split_by_study = TRUE)
#' print(out2)
t_dd_slide <- function(adsl,
                       arm = "TRT01A",
                       split_by_study = FALSE,
                       side_by_side = NULL) {
  assert_that(has_name(adsl, "DTHCAT"))
  assert_that(has_name(adsl, "DTHFL"))

  anl <- adsl

  if (nrow(anl) == 0) {
    return(null_report())
  } else {
    lyt <- build_table_header(adsl, arm, split_by_study = split_by_study, side_by_side = side_by_side)

    lyt <- lyt %>%
      count_values(
        "DTHFL",
        values = "Y",
        denom = c("N_col"),
        .labels = c(count_fraction = "All Deaths")
      ) %>%
      analyze_vars(
        vars = "DTHCAT", .stats = "count_fraction",
        na_str = "<Missing>",
        var_labels = " ",
        na.rm = TRUE
      ) %>%
      # count_patients_with_flags(
      #   "USUBJID",
      #   flag_variables = var_labels(anl[,c("DTHCAT1", "DTHCAT2", "DTHCAT3")]),
      #   .indent_mods = 1L,
      #   .format = list(trim_perc1),
      #   denom = "n"
      # ) %>%
      append_topleft("N (%)")

    result <- lyt_to_side_by_side(lyt, anl, side_by_side)
    result@main_title <- "Death table"
    result
  }
}
