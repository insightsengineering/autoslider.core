#' Adverse event table
#'
#' @param adae ADAE data set, dataframe
#' @param adsl ADSL data set, dataframe
#' @param arm Arm variable, character, "`TRT01A" by default.
#' @param cutoff Cutoff threshold
#' @param prune_by_total Prune according total column
#' @param split_by_study Split by study, building structured header for tables
#' @param side_by_side A logical value indicating whether to display the data side by side.
#' @return rtables object
#' @inherit gen_notes note
#' @export
#' @examples
#'
#' library(dplyr)
#' # Example 1
#' adsl <- eg_adsl %>%
#'   dplyr::mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae <- eg_adae %>%
#'   dplyr::mutate(
#'     TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")),
#'     ATOXGR = AETOXGR
#'   )
#' out <- t_ae_pt_slide(adsl, adae, "TRT01A", 2)
#' print(out)
#' generate_slides(out, paste0(tempdir(), "/ae.pptx"))
#'
#' # Example 2, prune by total column
#' out2 <- t_ae_pt_slide(adsl, adae, "TRT01A", 25, prune_by_total = TRUE)
#' print(out2)
#' generate_slides(out, paste0(tempdir(), "/ae2.pptx"))
t_ae_pt_slide <- function(adsl, adae, arm = "TRT01A", cutoff = NA, prune_by_total = FALSE,
                          split_by_study = FALSE,
                          side_by_side = NULL) {
  cutoff <- check_and_set_cutoff(adae, cutoff)
  result <- t_ae_pt_core(adsl, adae, arm, cutoff,
    diff = FALSE, soc = "NULL",
    prune_by_total = prune_by_total,
    split_by_study,
    side_by_side
  )
  result@main_title <- "Adverse Events table"

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
