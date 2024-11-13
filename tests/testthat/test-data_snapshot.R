test_that("Test data snapshot", {
  eg_dataname <- data(package = "autoslider.core")$results[, "Item"] %>%
    .[grep("eg_", .)] %>%
    sort()
  for (datai in eg_dataname) {
    expect_snapshot(dim(get(datai)))
    expect_snapshot(head(get(datai)))
  }
})
