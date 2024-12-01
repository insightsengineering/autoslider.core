test_that("Test adverse event table creation of t_ae_slide (Adverse Events for Patient)", {
  adsl <- eg_adsl %>%
    dplyr::mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
  adae <- eg_adae %>%
    dplyr::mutate(
      TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")),
      ATOXGR = AETOXGR
    )

  expect_snapshot(t_ae_slide(adsl, adae, "TRT01A"))
})

test_that("Test adverse event table creation of t_ae_slide with null_report", {
  adsl <- eg_adsl %>%
    dplyr::mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
  adae <- eg_adae %>%
    dplyr::mutate(
      TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")),
      ATOXGR = AETOXGR
    )
  adae <- adae[1, ]
  adsl <- adsl[1, ]

  expect_snapshot(t_ae_slide(adsl, adae, "TRT01A"))
})
