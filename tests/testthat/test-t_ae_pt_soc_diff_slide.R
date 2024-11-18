test_that("Test table creation of t_ae_pt_soc_diff_slide  (safety summary table)", {
  expect_snapshot(t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A"))
})

test_that("Test table creation of t_ae_pt_soc_diff_slide  (safety summary table) prune by total 2", {
  expect_snapshot(t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2))
})

test_that("Test table creation of t_ae_pt_soc_diff_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2, side_by_side = "GlobalAsia")
  )
})

test_that("Test table creation of t_ae_pt_soc_diff_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE
    )
  )
  expect_snapshot(
    t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE, side_by_side = "GlobalAsia"
    )
  )
  expect_warning(
    t_ae_pt_soc_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE, side_by_side = "GlobalAsia"
    )
  )
})

test_that("Test table creation of t_ae_pt_soc_diff_slide  (safety summary table)", {
  expect_error(t_ae_pt_soc_diff_slide(testdata$adsl, testdata$adae, "TRT01A"))
})
