test_that("save an output", {
  output <- t_ds_slide(adsl = testdata$adsl) %>% decorate(title = "test title", footnote = "")
  testthat::expect_no_error(
    save_output(
      output,
      file_name = "t_ds_output",
      save_rds = TRUE
    )
  )
})
