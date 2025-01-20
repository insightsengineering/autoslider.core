# data setup
library(dplyr)
library(ggplot2)

adeg <- testdata$adeg %>% filter(PARAMCD == "QT")
advs <- testdata$advs %>% filter(PARAMCD == "WEIGHT")
adlb <- testdata$adlb %>% filter(PARAMCD == "IGA")

# tests
path_to_test <- "_snaps"

## adeg
## Test 1: Test graph creation of `g_eg_slide` (eg mean plot) ----
test_that("g_mean_slides Test 1: Test graph creation of `g_eg_slide` (eg mean plot)", {
  testthat::expect_silent(geg <- withr::with_options(
    opts_partial_match_old,
    g_eg_slide(testdata$adsl, adeg, arm = "TRT01P", paramcd = "PARAMCD")
  ))

  expect_snapshot_ggplot(title = "g_eg_test", geg, width = 10, height = 8)
})


## Test 2: Test error of `g_eg_slide` ----
test_that("g_mean_slides Test 2: Test error of `g_eg_slide`", {
  testthat::expect_error(g_eg_slide(testdata$adsl, adeg, arm = TRT01P))
})

## adlb
## Test 3: Test graph creation of `g_lb_slide` (lab mean plot) ----
test_that("g_mean_slides Test 3: Test graph creation of `g_lb_slide` (lab mean plot)", {
  testthat::expect_silent(glb <- withr::with_options(
    opts_partial_match_old,
    g_lb_slide(testdata$adsl, adlb, arm = "TRT01P", paramcd = "PARAMCD")
  ))

  expect_snapshot_ggplot(title = "g_lb_test", glb, width = 10, height = 8)
})


## Test 4: Test graph creation of `g_lb_slide` (lab change from baseline plot) ----
test_that("g_mean_slides Test 4: Test graph creation of `g_lb_slide` (lab change from baseline plot)", {
  testthat::expect_silent(plot_lb_chg <- withr::with_options(
    opts_partial_match_old,
    g_lb_slide(
      testdata$adsl, adlb,
      arm = "TRT01P",
      paramcd = "PARAMCD",
      y = "CHG",
      subtitle = "Plot of change from baseline and 95% Confidence Limit by Visit."
    )
  ))

  expect_snapshot_ggplot(title = "g_lb_chg_test", plot_lb_chg, width = 10, height = 8)
})



## Test 5: Test error of `g_lb_slide` ----
test_that("g_mean_slides Test 5: Test error of `g_lb_slide`", {
  expect_error(g_lb_slide(testdata$adsl, adlb, arm = TRT01P))
})

## advs
## Test 6: Test graph creation of `g_vs_slide` (vital sign mean plot) ----
test_that("g_mean_slides Test 6: Test graph creation of `g_vs_slide` (vital sign mean plot)", {
  testthat::expect_silent(gvs <- withr::with_options(
    opts_partial_match_old,
    g_vs_slide(testdata$adsl, advs, arm = "TRT01P", paramcd = "PARAMCD")
  ))

  expect_snapshot_ggplot(title = "g_vs_test", gvs, width = 10, height = 8)
})

## Test 7: Test error of `g_vs_slide` ----
test_that("g_mean_slides Test 7: Test error of `g_vs_slide`", {
  expect_error(g_vs_slide(testdata$adsl, advs, arm = TRT01P))
})

## general
## Test 8: Test graph creation of `g_mean_slide` (vital sign mean plot) ----
test_that("g_mean_slides Test 8: Test graph creation of `g_mean_slide` (vital sign mean plot)", {
  testthat::expect_silent(gm1 <- withr::with_options(
    opts_partial_match_old,
    g_mean_general(testdata$adsl,
      adeg,
      variables = tern::control_lineplot_vars(
        group_var = "TRT01P",
        paramcd = "PARAMCD"
      )
    )
  ))

  expect_snapshot_ggplot(title = "g_mean_general_test", gm1, width = 10, height = 8)

  testthat::expect_silent(gm2 <- withr::with_options(
    opts_partial_match_old,
    g_mean_general(testdata$adsl,
      adeg,
      variables = tern::control_lineplot_vars(
        group_var = "TRT01P",
        paramcd = "PARAMCD"
      ),
      subtitle_add_unit = FALSE
    )
  ))

  expect_snapshot_ggplot(title = "g_mean_nounit_test", gm2, width = 10, height = 8)
})

## Test 9: Test error of general function `g_mean_slide` ----
test_that("g_mean_slides Test 9: Test error of general function `g_mean_slide`", {
  expect_error(g_eg_slide(testdata$adsl, adeg, arm = TRT01P))
})
