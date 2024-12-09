test_that("Test some functions in helper_functions.R", {
  testthat::expect_no_error(mutate_actarm(adsl))
  testthat::expect_snapshot(mutate_actarm(adsl))
})
