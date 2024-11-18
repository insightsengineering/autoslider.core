#' Adverse event table
#'
#' @param adae ADAE data set, dataframe
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01A" by default.
#' @param cutoff Cutoff threshold
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side "GlobalAsia" or "GlobalAsiaChina" to define the side by side requirement
#' @return rtables object
#' @inherit gen_notes note
#' @export
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl %>%
#'   dplyr::mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae <- eg_adae %>%
#'   dplyr::mutate(
#'     TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")),
#'     ATOXGR = AETOXGR
#'   )
#' out <- t_ae_pt_diff_slide(adsl, adae, "TRT01A", 2)
#' print(out)
#' generate_slides(out, paste0(tempdir(), "/ae_diff.pptx"))
t_ae_pt_diff_slide <- function(adsl, adae, arm = "TRT01A", cutoff = NA,
                               split_by_study = FALSE, side_by_side = NULL) {
  cutoff <- check_and_set_cutoff(adae, cutoff)
  result <- t_ae_pt_core(adsl, adae, arm, cutoff,
    diff = TRUE, soc = "NULL",
    prune_by_total = FALSE, split_by_study, side_by_side
  )
  result@main_title <- "Adverse Events with Difference"

  if (!all(dim(result@rowspans) == c(0, 0))) {
    if (is.null(side_by_side)) {
      # adding "N" attribute
      arm <- col_paths(result)[[1]][1]

      n_r <- data.frame(
        ARM = toupper(names(result@col_info)),
        N = col_counts(result) %>% as.numeric()
      ) %>%
        `colnames<-`(c(paste(arm), "N")) %>%
        arrange(get(arm))

      attr(result, "N") <- n_r
    }
  }

  result
}


t_ae_pt_core <- function(adsl, adae, arm, cutoff, diff = FALSE, soc = "NULL",
                         prune_by_total = FALSE,
                         split_by_study, side_by_side) {
  assert_that(has_name(adae, "AEDECOD"))
  assert_that(has_name(adae, "ATOXGR"))
  assert_that(has_name(adae, "AEBODSYS"))
  assert_that(has_name(adae, "ANL01FL"))
  assert_that((diff + prune_by_total) < 2)
  assert_that(cutoff <= 100 & cutoff >= 0)

  if (!is.null(side_by_side)) {
    assert_that(has_name(adsl, "RACE"))
    assert_that(has_name(adsl, "COUNTRY"))
  }

  slref_arm <- sort(unique(adsl[[arm]]))
  anl_arm <- sort(unique(adae[[arm]]))
  assert_that(identical(slref_arm, anl_arm),
    msg = "The adsl and the analysis datasets should have the same treatment arm levels"
  )

  if (is.null(side_by_side)) {
    adsl1 <- adsl %>%
      select("STUDYID", "USUBJID", all_of(arm))
  } else if (side_by_side != TRUE) {
    adsl1 <- adsl %>%
      select("STUDYID", "USUBJID", "RACE", "COUNTRY", all_of(arm))
  } else {
    adsl1 <- adsl %>%
      select("STUDYID", "USUBJID", all_of(arm))
  }

  anl <- adae %>%
    mutate_at(
      c("AEDECOD", "AEBODSYS"),
      ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
    ) %>%
    semi_join(., adsl1, by = c("STUDYID", "USUBJID")) %>%
    mutate(
      ATOXGR = sas_na(ATOXGR) %>% as.factor(),
      ATOXGR2 = case_when(
        ATOXGR %in% c(1, 2) ~ "1 - 2",
        ATOXGR %in% c(3, 4) ~ "3 - 4",
        ATOXGR %in% c(5) ~ "5",
      ) %>% as.factor()
    )

  if (soc == "soc") {
    anl <- anl %>%
      mutate(
        AEBODSYS = sas_na(AEBODSYS) %>% as.factor()
      )
  }

  anl <- anl %>%
    var_relabel(
      AEBODSYS = "MedDRA System Organ Class",
      AEDECOD = "MedDRA Preferred Term"
    ) %>%
    filter(ANL01FL == "Y")

  if (nrow(anl) == 0) {
    return(null_report())
  } else {
    lyt <- build_table_header(adsl1, arm, split_by_study = split_by_study, side_by_side = side_by_side)

    # lyt <- basic_table() %>%
    #   split_cols_by(var = arm, split_fun = add_overall_level("All Patients", first = FALSE)) %>%
    #   add_colcounts()

    if (soc == "soc") {
      lyt <- lyt %>%
        split_rows_by(
          "AEBODSYS",
          child_labels = "visible",
          nested = FALSE,
          indent_mod = -1L,
          split_fun = drop_split_levels
        ) %>%
        append_varlabels(anl, "AEBODSYS")
    }

    lyt <- lyt %>%
      count_occurrences(
        vars = "AEDECOD",
        .indent_mods = c(count_fraction = 1L)
        # , .formats = list(trim_perc1)
      ) %>%
      append_topleft(paste("  ", var_labels(anl["AEDECOD"]), "N (%)"))

    if (soc == "soc") {
      sort_path <- c("AEBODSYS", "*", "AEDECOD")
    } else {
      sort_path <- c("AEDECOD")
    }

    # this is an add hoc test check
    myh_col_indices <- function(table_row, col_names) {
      NULL
    }
    # environment(myh_col_indices) <- asNamespace("tern")
    # assignInNamespace("h_col_indices", myh_col_indices, ns = "tern")
    # result <- build_table(lyt = lyt, df = anl, alt_counts_df = adsl1)

    result <- lyt_to_side_by_side_two_data(lyt, anl, adsl1, side_by_side)

    result <- result %>%
      sort_at_path(
        path = sort_path,
        scorefun = score_occurrences
      )

    # criteria_fun <- function(tr) is(tr, "ContentRow")
    # result <- trim_rows(result, criteria = criteria_fun)

    if (diff) {
      row_condition <- has_fractions_difference(
        atleast = cutoff / 100,
        # col_names = levels(adsl1$TRT01A)
        col_indices = 1:2
      )
      if (length(levels(adsl1[[arm]])) > 2) {
        stop("More than two arms, not implemented yet")
      }
    } else if (prune_by_total) {
      if (is.null(side_by_side)) {
        row_condition <- has_fraction_in_any_col(
          atleast = cutoff / 100,
          col_indices = ncol(result)
        )
      } else if (!is.null(side_by_side)) {
        stop("I am not implemented yet")
      } else {
        row_condition <- has_fraction_in_any_col(
          atleast = cutoff / 100,
          col_indices = ncol(result)
        )
      }
    } else {
      row_condition <- has_fraction_in_any_col(
        atleast = cutoff / 100,
        col_names = levels(adsl1[[arm]])
      )
    }

    result1 <- prune_table(result, keep_rows(row_condition))
    # Viewer(result1)

    if (is.null(result1)) {
      return(null_report())
    } else {
      return(result1)
    }
  }
}
