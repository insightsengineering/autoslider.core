test_that("Test some functions in log.R", {
  testthat::expect_no_error(log_success_infomation(100, 0))
  testthat::expect_no_error(log_success_infomation(99, 1))
})
