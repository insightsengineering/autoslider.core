filters::load_filters(
  yaml_file = system.file("filters.yml", package = "autoslider.core"),
  overwrite = TRUE
)

spec_file <- system.file("spec.yml", package = "autoslider.core")
spec_file <- spec_file %>% read_spec()
spec <- spec_file$t_aesi_slide_SE

data <- list(
  adsl = eg_adsl,
  adae = eg_adae
)
# generate_output("t_ae_slide", data, spec$t_aesi_slide_SE)

test_that("legacy with datasets and spec", {
  test_func <- "t_aesi_slide"
  wrapped <- func_wrapper(match.fun(test_func), data, spec)
  result <- wrapped(aesi = "CQ01NAM", grad_var = "AETOXGR")

  expect_s4_class(result, "VTableTree")
})

test_that("legacy with datasets but no spec", {
  test_func <- "t_dd_slide"
  spec <- spec_file$t_dd_slide_SE
  wrapped <- func_wrapper(test_func, data, spec)
  result <- wrapped(arm = "TRT01A", split_by_study = TRUE)

  expect_s4_class(result, "VTableTree")
})

test_that("modern with named datasets and spec", {
  test_func <- function(datasets, spec, arg1 = "default") {}
  wrapped <- func_wrapper(test_func, data, spec)
  expect_silent(wrapped(arg1 = "custom"))
})

test_that("modern with named datasets but no spec", {
  test_func <- function(datasets, arg1 = "default") {}
  wrapped <- func_wrapper(test_func, data, spec)
  expect_silent(wrapped(arg1 = "custom"))
})

test_that("modern with named spec but no datasets", {
  test_func <- function(spec, arg1 = "default") {}
  wrapped <- func_wrapper(test_func, data, spec)
  expect_silent(wrapped(arg1 = "custom"))
})

