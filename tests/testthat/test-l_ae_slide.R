test_that("Test listing creation of l_ae_slide (Adverse Events Listing)", {
  library(dplyr)
  library(rlistings)
  adsl <- eg_adsl
  adae <- eg_adae

  expect_snapshot(l_ae_slide(adsl = adsl, adae = adae))
})
