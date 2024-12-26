test_that("Test demographic table creation of t_dm_slide", {
  adsl <- eg_adsl
  expect_snapshot(t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY")))

  expect_snapshot(t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"),
    split_by_study = FALSE,
    side_by_side = "GlobalChina"
  ))

  expect_snapshot(t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"),
    split_by_study = TRUE
  ))

  expect_warning(t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"),
    split_by_study = TRUE, side_by_side = "GlobalChina"
  ))
  expect_snapshot(t_dm_slide(adsl, "TRT01P", c("SEX", "AGE", "RACE", "ETHNIC", "COUNTRY"),
    split_by_study = TRUE, side_by_side = "GlobalChina"
  ))
})
