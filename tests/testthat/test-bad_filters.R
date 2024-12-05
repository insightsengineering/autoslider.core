library(filters)

test_that("Listing print correctly", {
  expect_error(load_filters(file.path(
    system.file(package = "autoslider.core"), "bad_filters.yml"), overwrite = TRUE))
}
)
