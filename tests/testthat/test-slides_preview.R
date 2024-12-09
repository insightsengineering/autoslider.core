test_that("Test slides preview", {
  adsl <- eg_adsl
  out <- t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE"))
  expect_no_error(ret <- out %>% slides_preview())
  expect_snapshot(ret$header$dataset)
  expect_snapshot(ret$body$dataset)
})
