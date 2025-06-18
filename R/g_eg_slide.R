#' Plot mean values of EG
#'
#' Wrapper for `g_mean_general()`.
#' Requires filtering of the datasets (e.g. using SUFFIX in spec.yml)
#'
#' @param adsl ADSL data
#' @param adeg ADVS data
#' @param arm `"TRT01P"` by default
#' @param paramcd Which variable to use for plotting. By default `"PARAM"`
#' @inheritParams g_mean_general
#' @param ... |
#' Gets forwarded to `tern::g_lineplot()`.
#' This lets you specify additional arguments to `tern::g_lineplot()`
#' @author Stefan Thoma (`thomas7`)
#' @importFrom forcats fct_reorder
#' @export
#' @examples
#' library(dplyr)
#'
#' adeg_filtered <- eg_adeg %>% filter(
#'   PARAMCD == "HR"
#' )
#' plot_eg <- g_eg_slide(
#'   adsl = eg_adsl,
#'   adeg = adeg_filtered,
#'   arm = "TRT01P",
#'   paramcd = "PARAM",
#'   subtitle_add_unit = FALSE
#' ) +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
#'
#' generate_slides(plot_eg, paste0(tempdir(), "/g_eg.pptx"))
g_eg_slide <- function(adsl, adeg, arm = "TRT01P", paramcd = "PARAM",
                       subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
  # tern 0.9.4 added facet_var in control_lineplot_vars
  variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd) %>% strip_NA()
  by_vars <- c("USUBJID", "STUDYID")
  assert_that(is.string(arm))
  assert_that(has_name(adeg, c(by_vars, variables) %>% unique()))
  assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))
  assert_that(is.string(subtitle))

  g_mean_general(
    adsl = adsl, data = adeg, variables = variables, by_vars = by_vars,
    subtitle = subtitle, ...
  )
}
