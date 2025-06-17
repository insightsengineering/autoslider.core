output_dir <- tempdir()

test_that("save an output", {
  output <- t_dm_slide(adsl = testdata$adsl) %>% decorate(title = "test title", footnote = "")
  testthat::expect_no_error(
    save_output(
      output,
      file_name = file.path(output_dir, "t_dm_output"),
      save_rds = TRUE
    )
  )
})


test_that("Test save_output (Save an Output)", {
  library(dplyr)
  adsl <- eg_adsl %>%
    mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
  adae <- eg_adae %>%
    mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))
  adae$ATOXGR <- adae$AETOXGR

  expect_snapshot(print(t_ae_pt_slide(adsl, adae, "TRT01A", 2) %>%
    decorate(
      title = "Serious Adverse Events, Safety-Evaluable Patients",
      footnote = "",
      paper = "P8",
      for_test = TRUE
    ) %>%
    save_output(
      file_name = file.path(output_dir, "t_ae_SER_SE"),
      save_rds = TRUE
    )))

  expect_no_error(slides_from_rds(file.path(output_dir, "t_ae_SER_SE.rds")))
})


test_that("save an output", {
  output <- t_ds_slide(adsl = testdata$adsl) %>% decorate(title = "test title", footnote = "")
  testthat::expect_no_error(
    save_output(
      output,
      file_name = file.path(output_dir, "t_ds_output"),
      save_rds = TRUE
    )
  )
  expect_no_error(slides_from_rds(file.path(output_dir, "t_ds_output.rds")))
})
