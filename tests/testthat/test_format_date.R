test_that("Test format date", {
  testthat::skip_if_not_installed("lubridate")
  expect_snapshot(format_date("2019"))
  expect_snapshot(format_date("2019-04-20"))
  expect_snapshot(format_date(""))
  expect_snapshot(format_date("2019-06-18T10:32"))
  expect_snapshot(format_date("2019-04"))
})
