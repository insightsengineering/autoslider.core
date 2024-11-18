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
#' out <- t_ae_pt_soc_diff_slide(adsl, adae, "TRT01A", 2)
#' print(out)
#' generate_slides(out, paste0(tempdir(), "/ae_diff.pptx"))
t_ae_pt_soc_diff_slide <- function(adsl, adae, arm = "TRT01A", cutoff = NA,
                                   split_by_study = FALSE, side_by_side = NULL) {
  cutoff <- check_and_set_cutoff(adae, cutoff)
  result <- t_ae_pt_core(adsl, adae, arm, cutoff,
    diff = TRUE, soc = "soc",
    prune_by_total = FALSE,
    split_by_study, side_by_side
  )
  result@main_title <- "Adverse Events with Difference"

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
  result
}
