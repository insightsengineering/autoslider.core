#' autoslider: t_ae_pt_diff_slide to dataframe
#'
#' @param t_ae_pt_diff_slide an output from the autoslider function `t_ae_pt_diff_slide`
#' See \link[autoslideR]{t_ae_pt_diff_slide}
#'
#' @return dataframe object
#'
#' @export
#'
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl %>%
#'   mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae <- eg_adae %>%
#'   mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae$ATOXGR <- adae$AETOXGR
#' my_tbl <- t_ae_pt_diff_slide(adsl, adae, "TRT01A", 2)
#'
#' t_ae_pt_diff_slide_to_df(my_tbl)
t_ae_pt_diff_slide_to_df <- function(t_ae_pt_diff_slide) {
  # check that input is a s34 object
  assertthat::assert_that(isS4(t_ae_pt_diff_slide),
    msg = "Input not of the correct format"
  )

  # define treatment arm variable
  arm <- col_paths(t_ae_pt_diff_slide)[[1]][1]

  t_ae_pt_diff_tbls <- t_ae_pt_diff_slide@children

  t_ae_pt_diff_r <- lapply(names(t_ae_pt_diff_tbls), function(x) {
    arow <- t_ae_pt_diff_tbls[[x]]@leaf_value
    lapply(names(arow), function(y) {
      data.frame(
        ARM = rep(y, 2),
        LEVEL1_FORMAT = rep(x, 2),
        CONTENT = c("count", "percent"),
        NUMVALUE = as.numeric(arow[[y]] %>% unlist()) * c(1, 100)
      )
    }) %>%
      do.call("rbind", .)
  }) %>%
    do.call("rbind", .) %>%
    `colnames<-`(c(paste(arm), "LEVEL1_FORMAT", "CONTENT", "NUMVALUE")) %>%
    arrange(get(arm), LEVEL1_FORMAT, CONTENT)



  return(t_ae_pt_diff_r)
}
