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
#' @examples
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
#' )
#' plot_vs
#' # you want x-axis tilted labels? No problem:
#' plot_vs +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) %>%
#'   generate_slides(paste0(tempdir(), "/g_vs.pptx"))
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
#' )
#' plot_lb
#' # you want x-axis tilted labels? No problem:
#' plot_lb +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
#'
#' # Let's plot change values:
#' plot_lb_chg <- g_lb_slide(
#'   adsl = eg_adsl,
#'   adlb = adlb_filtered,
#'   paramcd = "PARAM",
#'   y = "CHG",
#'   subtitle = "Plot of change from baseline and 95% Confidence Limit by Visit."
#' ) %>%
#'   generate_slides(paste0(tempdir(), "/g_lb.pptx"))
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
#' )
#' plot_eg
#' # you want x-axis tilted labels? No problem:
#' plot_eg +
#'   ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) %>%
#'   generate_slides(paste0(tempdir(), "/g_eg.pptx"))
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
