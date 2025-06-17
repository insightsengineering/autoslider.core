default <- function(adsl,
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
