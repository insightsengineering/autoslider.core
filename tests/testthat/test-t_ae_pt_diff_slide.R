test_that("Test table creation of t_ae_pt_diff_slide  (safety summary table)", {
  expect_snapshot(t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A"))
})

test_that("Test table creation of t_ae_pt_diff_slide  (safety summary table) prune by total 2", {
  expect_snapshot(t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2))
})


test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2, side_by_side = "GlobalAsia")
  )
})

test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE
    )
  )
})

test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE, side_by_side = "GlobalAsia"
    )
  )
  expect_warning(
    t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2,
      split_by_study = TRUE, side_by_side = "GlobalAsia"
    )
  )
})


test_that("Test table creation of t_ae_pt_diff_slide  (safety summary table)", {
  expect_error(t_ae_pt_diff_slide(testdata$adsl, testdata$adae, "TRT01A"))
})

test_that("Test table creation of t_ae_pt_slide (safety summary table) prune by total 2", {
  expect_snapshot(
    t_ae_pt_diff_slide(testdata_two_arm$adsl, testdata_two_arm$adae, "TRT01A", 2, side_by_side = "GlobalAsia")
  )
})

test_that("Test table creation of t_ae_pt_diff_slide with null_report", {
  adsl <- eg_adsl %>%
    dplyr::mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
  adae <- eg_adae %>%
    dplyr::mutate(
      TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")),
      ATOXGR = AETOXGR
    )

  expect_snapshot(t_ae_pt_diff_slide(adsl[1, ], adae[1, ], "TRT01A"))
})
