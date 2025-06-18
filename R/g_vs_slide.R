
#' Plot mean values of VS
#'
#' Wrapper for `g_mean_general()`.
#' Requires filtering of the datasets (e.g. using SUFFIX in spec.yml)
#'
#' @param adsl ADSL data
#' @param advs ADVS data
#' @param arm `"TRT01P"` by default
#' @inheritParams g_mean_general
#' @param paramcd Which variable to use for plotting. By default `"PARAM"`
#' @param ... |
#' Gets forwarded to `tern::g_lineplot()`.
#' This lets you specify additional arguments to `tern::g_lineplot()`
#' @author Stefan Thoma (`thomas7`)
#' @export
#' @examples
#' library(dplyr)
#' advs_filtered <- eg_advs %>% filter(
#'   PARAMCD == "SYSBP"
#' )
#'
#' plot_vs <- g_vs_slide(
#'   adsl = eg_adsl,
#'   advs = advs_filtered,
#'   paramcd = "PARAM",
#'   subtitle_add_unit = FALSE
#' ) +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
#'
#' generate_slides(plot_vs, paste0(tempdir(), "/g_vs.pptx"))
g_vs_slide <- function(adsl, advs, arm = "TRT01P", paramcd = "PARAM",
                       subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
  # tern 0.9.4 added facet_var in control_lineplot_vars
  variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd) %>% strip_NA()

  by_vars <- c("USUBJID", "STUDYID")
  assert_that(is.string(arm))
  assert_that(has_name(advs, c(by_vars, variables) %>% unique()))
  assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))

  g_mean_general(
    adsl = adsl, data = advs, variables = variables, by_vars = by_vars,
    subtitle = subtitle, ...
  )
}

