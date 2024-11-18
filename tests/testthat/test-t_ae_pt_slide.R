test_that("Test table creation of t_ae_pt_slide (safety summary table)", {
  expect_snapshot(t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 2))
})

test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 28", {
  expect_snapshot(t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 28, prune_by_total = TRUE))
})

test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 30", {
  expect_snapshot(t_ae_pt_slide(testdata$adsl, testdata$adae, "TRT01A", 30, prune_by_total = TRUE))
})


test_that("Test table creation of t_ae_pt_soc_slide (safety summary table)", {
  expect_snapshot(t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 2))
})

test_that("Test table creation of t_ae_pt_soc_slide (safety summary table) prune by total 28", {
  expect_snapshot(t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 28, prune_by_total = TRUE))
})

test_that("Test table creation of t_ae_pt_soc_slide (safety summary table) prune by total 30", {
  expect_snapshot(t_ae_pt_soc_slide(testdata$adsl, testdata$adae, "TRT01A", 30, prune_by_total = TRUE))
})
