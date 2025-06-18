#' Plot mean values of LB
#'
#' Wrapper for `g_mean_general()`.
#' Requires filtering of the datasets (e.g. using SUFFIX in spec.yml)
#'
#' @param adsl ADSL data
#' @param adlb ADLB data
#' @param arm `"TRT01P"` by default
#' @param paramcd character scalar. defaults to By default `"PARAM"`
#'  Which variable to use for plotting.
#' @param y character scalar. Variable to plot on the Y axis. By default `"AVAL"`
#' @inheritParams g_mean_general
#' @param ... |
#' Gets forwarded to `tern::g_lineplot()`.
#' This lets you specify additional arguments to `tern::g_lineplot()`
#' @author Stefan Thoma (`thomas7`)
#' @export
#' @examples
#' library(dplyr)
#'
#' adlb_filtered <- eg_adlb %>% filter(
#'   PARAMCD == "CRP"
#' )
#' plot_lb <- g_lb_slide(
#'   adsl = eg_adsl,
#'   adlb = adlb_filtered,
#'   paramcd = "PARAM",
#'   subtitle_add_unit = FALSE
#' ) +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
#' generate_slides(plot_lb, paste0(tempdir(), "/g_lb.pptx"))
#'
#' # Let's plot change values:
#' plot_lb_chg <- g_lb_slide(
#'   adsl = eg_adsl,
#'   adlb = adlb_filtered,
#'   paramcd = "PARAM",
#'   y = "CHG",
#'   subtitle = "Plot of change from baseline and 95% Confidence Limit by Visit."
#' )
#' generate_slides(plot_lb_chg, paste0(tempdir(), "/g_lb_chg.pptx"))
#'
g_lb_slide <- function(adsl, adlb, arm = "TRT01P", paramcd = "PARAM", y = "AVAL",
                       subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
  # tern 0.9.4 added facet_var in control_lineplot_vars
  variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd, y = y) %>%
    strip_NA()

  by_vars <- c("USUBJID", "STUDYID")
  assert_that(is.string(arm))
  assert_that(is.string(paramcd))
  assert_that(is.string(y))
  assert_that(has_name(adlb, c(by_vars, variables) %>% unique()))
  assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))
  assert_that(is.string(subtitle))

  g_mean_general(
    adsl = adsl, data = adlb, variables = variables, by_vars = by_vars,
    subtitle = subtitle, ...
  )
}
