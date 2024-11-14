#' Null report
#'
#' @author Thomas Neitmann (`neitmant`)
#'
#' @details
#' This will create a null report similar as STREAM does. You can use
#' it inside output functions as shown in the example below.
#'
#' @examples
#' library(dplyr)
#' library(filters)
#' data <- list(
#'   adsl = eg_adsl,
#'   adae = eg_adae %>% mutate(AREL = "")
#' )
#'
#' null_report()
#'
#' ## An example how to use the `null_report()` inside an output function
#' t_ae <- function(datasets) {
#'   trt <- "ACTARM"
#'   anl <- semi_join(
#'     datasets$adae,
#'     datasets$adsl,
#'     by = c("STUDYID", "USUBJID")
#'   )
#'
#'   return(null_report())
#' }
#'
#' data %>%
#'   apply_filter("SER_SE") %>%
#'   t_ae()
#'
#' @export
#'
null_report <- function() {
  rtable(
    header = " ",
    rrow("", "Null Report: No observations met the reporting criteria for inclusion in this output.")
  )
}
