test_that("Listing print correctly", {
  testthat::skip_if_not_installed("filters")
  require(filters)

  # skip_if_too_deep(1)
  load_filters(file.path(system.file(package = "autoslider.core"), "filters.yml"), overwrite = TRUE)

  spec_file <- file.path(system.file(package = "autoslider.core"), "spec.yml")

  full_spec <- spec_file %>%
    read_spec()

  testthat::expect_snapshot(full_spec %>%
    filter_spec(., program %in% c(
      "t_ds_slide",
      "t_ds_trt_slide",
      "i_am_wrong"
    ), verbose = TRUE))
})
