#' Demographic table
#'
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01P" by default.
#' @param vars Characters of variables
#' @param stats see `.stats` from [tern::analyze_vars()]
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side "GlobalAsia" or "GlobalAsiaChina" to define the side by side requirement
#' @return rtables object
#' @inherit gen_notes note
#' @export
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl
#' out1 <- t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"))
#' print(out1)
#' generate_slides(out1, paste0(tempdir(), "/dm.pptx"))
#'
#' out2 <- t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"),
#'   split_by_study = TRUE
#' )
#' print(out2)
#'
t_dm_slide <- function(adsl,
                       arm = "TRT01P",
                       vars = c("AGE", "SEX", "RACE"),
                       stats = c("median", "range", "count_fraction"),
                       split_by_study = FALSE,
                       side_by_side = NULL) {
  if (is.null(side_by_side)) {
    extra <- NULL
  } else {
    extra <- c("COUNTRY")
  }

  for (v in c(vars, extra)) {
    assert_that(has_name(adsl, v))
  }

  adsl1 <- adsl %>%
    select(all_of(c("STUDYID", "USUBJID", arm, vars, extra)))

  if (!is.null(side_by_side)) {
    adsl1$lvl <- "Global"
  }

  lyt <- build_table_header(adsl1, arm,
    split_by_study = split_by_study,
    side_by_side = side_by_side
  )

  lyt <- lyt %>%
    analyze_vars(
      na.rm = TRUE,
      .stats = stats,
      denom = "n",
      vars = vars,
      .formats = c(mean_sd = "xx.xx (xx.xx)", median = "xx.xx"),
      var_labels = formatters::var_labels(adsl1)[vars]
    )

  result <- lyt_to_side_by_side(lyt, adsl1, side_by_side)

  if (is.null(side_by_side)) {
    # adding "N" attribute
    arm <- col_paths(result)[[1]][1]

    n_r <- data.frame(
      ARM = toupper(names(result@col_info)),
      N = col_counts(result) %>% as.numeric()
    ) %>%
      `colnames<-`(c(paste(arm), "N")) %>%
      dplyr::arrange(get(arm))

    attr(result, "N") <- n_r
  }
  result@main_title <- "Demographic slide"
  result
}

#' Demographic table with gtsummary
#'
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01P" by default.
#' @param vars Characters of variables
#' @return gtsummary object
#' @inherit gen_notes note
#' @export
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl
#' out1 <- gt_t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"))
#' print(out1)
#' generate_slides(out1, paste0(tempdir(), "/dm.pptx"))
#'
gt_t_dm_slide <- function(adsl,
                          arm = "TRT01P",
                          vars = c("AGE", "SEX", "RACE")) {
  adsl |>
    select(all_of(c(vars, arm))) |>
    tbl_summary(by = all_of(arm)) |>
    modify_caption(caption = "Demographic slide") # Set default title
}
