#' Discontinue table
#' @param adsl ADSL data
#' @param arm Arm variable, character, "`TRT01P" by default.
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side "GlobalAsia" or "GlobalAsiaChina" to define the side by side requirement
#' @inherit gen_notes note
#' @export
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl %>%
#'   mutate(DISTRTFL = sample(c("Y", "N"), size = nrow(eg_adsl), replace = TRUE, prob = c(.1, .9))) %>%
#'   preprocess_t_ds()
#' out1 <- t_ds_slide(adsl, "TRT01P")
#' print(out1)
#' generate_slides(out1, "ds.pptx")
#'
#' out2 <- t_ds_slide(adsl, "TRT01P", split_by_study = TRUE)
#' print(out2)
#'
t_ds_slide <- function(adsl, arm = "TRT01P",
                       split_by_study = FALSE,
                       side_by_side = NULL) {
  assert_that(has_name(adsl, arm))
  assert_that(has_name(adsl, "SAFFL"))
  assert_that(has_name(adsl, "STDONS"),
    msg = "`STDONS` variable is needed for this output, please use `preprocess_t_ds` function to derive."
  )
  assert_that(has_name(adsl, "DCSREAS"))
  assert_that(length(levels(adsl$STDONS)) <= 3)

  adsl1 <- adsl %>%
    mutate(
      STDONS = factor(explicit_na(sas_na(STDONS)),
        levels = c("Alive: On Treatment", "Alive: In Follow-up", "<Missing>"),
        labels = c("On Treatment", "In Follow-up", "<Missing>")
      ),
      DCSREAS = str_to_title(factor(sas_na(DCSREAS))),
      DCSflag = ifelse(is.na(DCSREAS), "N", "Y"),
      STDONSflag = ifelse(STDONS == "<Missing>", "N", "Y")
    ) %>%
    mutate_at(c("STDONS", "DCSREAS"), ~ as.factor(explicit_na(.))) %>%
    var_relabel(
      STDONS = "On-study Status",
      DCSflag = "Discontinued the study"
    )

  lyt <- build_table_header(adsl1, arm, split_by_study = split_by_study, side_by_side = side_by_side)

  lyt <- lyt %>%
    count_values("SAFFL",
      values = "Y",
      .labels = c(count_fraction = "Received Treatment")
    ) %>%
    split_rows_by(
      "STDONSflag",
      split_fun = keep_split_levels("Y"),
    ) %>%
    summarize_row_groups(label_fstr = "On-study Status") %>%
    analyze_vars(
      "STDONS",
      .stats = "count_fraction",
      denom = "N_col",
      na.rm = TRUE,
      # var_labels =  var_labels(adsl1)["STDONS"]
    ) %>%
    split_rows_by(
      "DCSflag",
      split_fun = keep_split_levels("Y"),
    ) %>%
    summarize_row_groups(label_fstr = "Discontinued the study") %>%
    analyze_vars(
      "DCSREAS",
      .stats = "count_fraction",
      denom = "N_col"
    )

  result <- lyt_to_side_by_side(lyt, adsl1, side_by_side)
  result@main_title <- "Discontinue table"
  return(result)
}
