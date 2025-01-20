test_that("Listing print correctly", {
  testthat::skip_if_not_installed("filters")
  require(filters)
  expect_error(load_filters(file.path(
    system.file(package = "autoslider.core"), "bad_filters.yml"
  ), overwrite = TRUE))
})
