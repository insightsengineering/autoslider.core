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
