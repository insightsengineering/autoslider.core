test_that("Test DOR table when time unit is 'DAYS'", {
  adsl <- eg_adsl %>%
    dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
  adtte <- eg_adtte %>%
    dplyr::filter(PARAMCD == "OS") %>%
    dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))

  expect_snapshot(t_dor_slide(adsl, adtte))
})

test_that("Test DOR table when time unit is 'YEARS'", {
  adsl <- eg_adsl %>%
    dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
  adtte <- eg_adtte %>%
    dplyr::filter(PARAMCD == "OS") %>%
    dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
  levels(adtte$AVALU)[2] <- "YEARS"

  expect_snapshot(t_dor_slide(adsl, adtte))
})
