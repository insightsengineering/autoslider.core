pkg_name <- "autoslider.core"
library(testthat)
test_check(pkg_name, reporter = ParallelProgressReporter$new())
