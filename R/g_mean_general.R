#' Plot mean values general function
#' used by wrappers `g_vs_slide`,`g_lb_slide`, & `g_eg_slide`
#'
#' adapted from https://insightsengineering.github.io/tlg-catalog/stable/graphs/other/mng01.html
#'
#' @param adsl ADSL dataset
#' @param data dataset containing the variable of interest in PARAMCD and AVAL
#' @inheritParams tern::g_lineplot
#' @param by_vars variables to merge the two datasets by
#' @param subtitle character scalar forwarded to g_lineplot
#' @param ... additional arguments passed to `tern::g_lineplot`
#' @author Stefan Thoma (`thomas7`)
#' @importFrom forcats fct_reorder
#' @import ggplot2
#' @import dplyr tern assertthat
#' @export
#' @examplesIf require('rsvg')
#' library(dplyr)
#' advs_filtered <- eg_advs %>% filter(
#'   PARAMCD == "SYSBP"
#' )
#' out1 <- g_mean_general(eg_adsl, advs_filtered)
#' generate_slides(out1, paste0(tempdir(), "/g_mean.pptx"))
g_mean_general <- function(adsl,
                           data,
                           variables = control_lineplot_vars(group_var = "TRT01P"),
                           by_vars = c("USUBJID", "STUDYID"),
                           subtitle = "Plot of Mean and 95% Confidence Limits by Visit.",
                           ...) {
  assert_that(is.string(subtitle))
  variables <- variables %>% strip_NA() # tern 0.9.4 added facet_var in control_lineplot_vars
  assert_that(has_name(data, c(by_vars, variables)))
  assert_that(has_name(adsl, c(by_vars, variables["group_var"])))

  adsl_f <- adsl %>%
    df_explicit_na()

  data_f <- data %>%
    mutate(AVISIT = forcats::fct_reorder(AVISIT, AVISITN, min)) %>%
    dplyr::filter(
      AVISIT != "SCREENING"
    ) %>%
    droplevels() %>%
    df_explicit_na() %>%
    semi_join(adsl_f, by_vars)


  plot <- g_lineplot(
    df = data_f,
    alt_counts_df = adsl_f,
    variables = variables,
    title = "",
    subtitle = subtitle,
    ...
  )
  plot
}
