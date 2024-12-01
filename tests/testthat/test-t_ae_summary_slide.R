test_that("Test table creation of t_ae_summ_slide (safety summary table)", {
  expect_snapshot(t_ae_summ_slide(testdata$adsl, testdata$adae,
    arm = "TRT01A",
    dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
    dose_adjust_labels = c(
      "DRUG WITHDRAWN", "DOSE REDUCED",
      "DRUG INTERRUPTED"
    ),
    gr34_highest_grade_only = TRUE
  ))
  expect_snapshot(t_ae_summ_slide(testdata$adsl, testdata$adae,
    arm = "TRT01A",
    dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
    dose_adjust_labels = c(
      "DRUG WITHDRAWN", "DOSE REDUCED",
      "DRUG INTERRUPTED"
    ),
    gr34_highest_grade_only = FALSE
  ))
})

test_that("Test t_ae_summ_slide with expected Error", {
  expect_snapshot(error = TRUE, t_ae_summ_slide(testdata$adsl, testdata$adae,
    arm = "TRT01A",
    dose_adjust_flags = c("dis_flags", "dis_flags", "dis_flags"),
    dose_adjust_labels = c(
      "DRUG WITHDRAWN", "DOSE REDUCED",
      "DRUG INTERRUPTED"
    ),
    gr34_highest_grade_only = "FALSE"
  ))
})

test_that("Test t_ae_summ_slide with null_report", {
  expect_snapshot(t_ae_summ_slide(testdata$adsl[1, ], testdata$adae[1, ]))
})
