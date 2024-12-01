test_that("Test table creation of t_aesi_slide (AESI summary table) with AETOXGR grading", {
  expect_snapshot(t_aesi_slide(testdata$adsl,
    testdata$adae,
    aesi = "CQ01NAM",
    arm = "ACTARM"
  ))
})

test_that("Test table creation of t_aesi_slide (AESI summary table) with AESEV grading", {
  expect_snapshot(t_aesi_slide(testdata$adsl,
    testdata$adae_aesev,
    aesi = "CQ01NAM",
    arm = "ACTARM",
    grad_var = "AESEV"
  ))
})

# Custom grouping

test_that("Test table creation of t_aesi_slide (AESI summary table) with custom AEGRP grouping", {
  expect_snapshot(t_aesi_slide(testdata$adsl,
    testdata$adae_custom,
    aesi = "CQ01NAM",
    arm = "ARM",
    grad_var = "AEGRP"
  ))
})

# Errors

test_that("Test table creation of t_aesi_slide with no aesi var given", {
  expect_error(
    t_aesi_slide(
      testdata$adsl,
      testdata$adae
    ),
    'argument "aesi" is missing, with no default'
  )
})

test_that("Test table creation of t_aesi_slide with aesi var not found in dataset", {
  expect_error(
    t_aesi_slide(testdata$adsl,
      testdata$adae,
      aesi = "CQ02NAM"
    ),
    "object 'CQ02NAM' not found"
  )
})
