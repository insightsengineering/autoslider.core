#' autoslider: t_ae_pt_soc_slide to dataframe
#' @details
#' Takes the output from t_ae_pt_soc_slide and converts it to a dataframe of a similar
#' format to SAS result tables.
#' @param t_ae_pt_soc_slide output from function `t_ae_pt_soc_slide`. See
#' \link[autoslideR]{t_ae_pt_soc_slide}
#' @return dataframe object
#' @export
#'
#' @examples
#' library(dplyr)
#' adsl <- eg_adsl %>%
#'   mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae <- eg_adae %>%
#'   mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
#' adae$ATOXGR <- adae$AETOXGR
#' my_tbl <- t_ae_pt_soc_slide(adsl, adae, "TRT01A", 2)
#'
#' t_ae_pt_soc_slide_to_df(my_tbl)
# main function
t_ae_pt_soc_slide_to_df <- function(t_ae_pt_soc_slide) {
  # make sure input is in correct format
  assert_that(isS4(t_ae_pt_soc_slide), msg = "Is not t_ae_pt_soc_slide output")

  # pulling out the treatment assignment variable
  arm <- col_paths(t_ae_pt_soc_slide)[[1]][1]

  t_ae_pt_soc_tbls <- t_ae_pt_soc_slide@children # 1

  t_ae_pt_soc_r <-
    lapply(names(t_ae_pt_soc_tbls), function(x) {
      t_ae_pt_soc_tbls_1 <- t_ae_pt_soc_tbls[[x]]@children # 2

      lapply(names(t_ae_pt_soc_tbls_1), function(y) {
        t_ae_pt_soc_tbls_2 <- t_ae_pt_soc_tbls_1[[y]]@children # 3

        lapply(names(t_ae_pt_soc_tbls_2), function(z) {
          arow <- t_ae_pt_soc_tbls_2[[z]]@leaf_value # 4

          lapply(names(arow), function(a) {
            data.frame(
              ARM = rep(a, 2),
              AEBODSYS = rep(x, 2),
              LEVEL1_FORMAT = rep(z, 2),
              CONTENT = c("count", "percent"),
              NUMVALUE = as.numeric(arow[[a]] %>% unlist()) * c(1, 100)
            )
          }) %>%
            do.call("rbind", .)
        }) %>%
          do.call("rbind", .)
      }) %>%
        do.call("rbind", .)
    }) %>%
    do.call("rbind", .) %>%
    `colnames<-`(c(sym(arm), "AEBODSYS", "LEVEL1_FORMAT", "CONTENT", "NUMVALUE")) %>%
    dplyr::arrange(get(arm), AEBODSYS, LEVEL1_FORMAT, CONTENT)

  return(t_ae_pt_soc_r)
}
