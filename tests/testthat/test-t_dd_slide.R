test_that("Test table creation of t_dd_slide (death table)", {
  expect_snapshot(t_dd_slide(testdata$adsl, "TRT01A"))
})

test_that("Test t_dd_slide table with expected Error", {
  expect_snapshot(error = TRUE, t_dd_slide(adsl, "TRT"))
})

test_that("Test table creation of with null_report", {
  expect_snapshot(t_dd_slide(testdata$adsl[0, ], "TRT01A"))
})


test_that("Test table creation of t_dd_slide (death table)", {
  expect_snapshot(t_dd_slide(testdata$adsl, "TRT01A", split_by_study = TRUE))
})


test_that("Test table creation of t_dd_slide (death table)", {
  expect_snapshot(t_dd_slide(testdata$adsl, "TRT01A", split_by_study = TRUE, side_by_side = "GlobalChina"))
  expect_warning(t_dd_slide(testdata$adsl, "TRT01A", split_by_study = TRUE, side_by_side = "GlobalChina"))
})
