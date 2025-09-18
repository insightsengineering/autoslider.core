test_that("Test layout is in layout", {
  adsl <- eg_adsl
  out1 <- t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"))
  expect_no_error(generate_slides(out1, paste0(tempdir(), "/dm.pptx")))
  expect_error(generate_slides(out1, paste0(tempdir(), "/dm.pptx"), layout = "some layout"))
})
