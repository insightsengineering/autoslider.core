#' Adverse event table
#'
#' @param adae ADAE data set, dataframe
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01A" by default.
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side should table be displayed side by side
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
#' out <- t_ae_slide(adsl, adae, "TRT01A")
#' print(out)
#' generate_slides(out, "ae.pptx")
t_ae_slide <- function(adsl, adae, arm = "TRT01A",
                       split_by_study = FALSE, side_by_side = NULL) {
  assert_that(has_name(adae, "AEDECOD"))
  assert_that(has_name(adae, "ATOXGR"))
  assert_that(has_name(adae, "AEBODSYS"))

  slref_arm <- sort(unique(adsl[[arm]]))
  anl_arm <- sort(unique(adae[[arm]]))
  assert_that(identical(slref_arm, anl_arm),
    msg = "The adsl and the analysis datasets should have the same treatment arm levels"
  )

  anl <- adae %>%
    mutate_at(
      c("AEDECOD", "AEBODSYS"),
      ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
    ) %>%
    semi_join(., adsl, by = c("STUDYID", "USUBJID")) %>%
    mutate(
      AETOXGR = sas_na(AETOXGR) %>% as.factor()
    ) %>%
    var_relabel(
      AEBODSYS = "MedDRA System Organ Class",
      AEDECOD = "MedDRA Preferred Term"
    )

  if (nrow(anl) == 0) {
    return(null_report())
  } else {
    lyt <- build_table_header(adsl, arm,
      split_by_study = split_by_study,
      side_by_side = side_by_side
    )

    lyt <- lyt %>%
      split_rows_by(
        "AEBODSYS",
        child_labels = "hidden",
        nested = FALSE,
        indent_mod = 0L,
        split_fun = drop_split_levels,
        label_pos = "topleft",
        split_label = obj_label(anl$AEBODSYS)
      ) %>%
      summarize_num_patients(
        var = "USUBJID",
        .stats = c("unique"),
        .labels = c(
          unique = "Total number of patients"
        ),
        .formats = list(trim_perc1)
      ) %>%
      count_occurrences(
        vars = "AEBODSYS",
        .indent_mods = -1L
        # , .formats = list(trim_perc1)
      ) %>%
      count_occurrences(
        vars = "AEDECOD",
        .indent_mods = 1L
        # , .formats = list(trim_perc1)
      ) %>%
      # append_varlabels(anl, "AEDECOD", indent = TRUE)
      append_topleft(paste("  ", var_labels(anl["AEDECOD"]), "N (%)"))

    result <- lyt_to_side_by_side_two_data(lyt, anl, adsl, side_by_side)

    result1 <- result %>%
      prune_table() %>%
      sort_at_path(
        path = c("AEBODSYS"),
        scorefun = cont_n_allcols
      ) %>%
      sort_at_path(
        path = c("AEBODSYS", "*", "AEDECOD"),
        scorefun = score_occurrences
      )

    t_aesi_trim_rows <- function(tt) {
      rows <- collect_leaves(tt, TRUE, TRUE)

      tbl <- tt[!grepl("unique", names(rows)), , keep_topleft = TRUE]

      tbl
    }
    result1 <- result1 %>%
      t_aesi_trim_rows()
    result1@main_title <- "AE event table"
    return(result1)
  }
}
