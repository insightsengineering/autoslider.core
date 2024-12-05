test_that("Test table creation of t_ds_slide", {
  expect_snapshot(t_ds_slide(adsl = testdata$adsl))
})

test_that("Test table creation of t_ds_slide", {
  expect_snapshot(t_ds_slide(adsl = testdata$adsl, side_by_side = TRUE))
})

test_that("Test table creation of t_ds_slide", {
  expect_snapshot(t_ds_slide(adsl = testdata$adsl, split_by_study = TRUE))
})

test_that("Test table creation of t_ds_slide", {
  expect_snapshot(t_ds_slide(adsl = testdata$adsl, split_by_study = TRUE, side_by_side = TRUE))
  expect_warning(t_ds_slide(adsl = testdata$adsl, split_by_study = TRUE, side_by_side = TRUE))
})
