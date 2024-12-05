test_that("save an autoslider output", {
  output <- t_dm_slide(adsl = testdata$adsl) %>%
    decorate(title = "test title", footnote = "") %>%
    list()

  outfile = paste0(tempdir(), "/output.pptx")
  testthat::expect_no_error(
    generate_slides(
      output,
      outfile = outfile,
      table_format = autoslider_format
    )
  )

  testthat::expect_no_error(
    generate_slides(
      output,
      outfile = outfile,
      template = outfile,
      table_format = blue_format
    )
  )

  testthat::expect_no_error(
    generate_slides(
      output,
      outfile = outfile,
      template = outfile,
      table_format = orange_format
    )
  )

  testthat::expect_no_error(
    generate_slides(
      output,
      outfile = outfile,
      template = outfile,
      table_format = red_format
    )
  )

  testthat::expect_no_error(
    generate_slides(
      output,
      outfile = outfile,
      template = outfile,
      table_format = purple_format
    )
  )
})
