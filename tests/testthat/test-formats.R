testthat::test_that("new_round function", {
  da1 <- data.frame(
    raw = seq(0, 1, 0.0005),
    r = unlist(lapply(seq(0, 1, 0.0005) * 100, new_round, digits = 1))
  )
  expect_true(all(table(da1$r[2:2001]) == 2))

  da2 <- data.frame(
    raw = seq(0, 1, 0.00005),
    r = unlist(lapply(seq(0, 1, 0.00005) * 100, new_round, digits = 2))
  )
  expect_true(all(table(da2$r[2:20001]) == 2))
})


testthat::test_that("xx.xx (xx.xx)", {
  expect_identical(trim_perc(c(10, 0.6375)), "10 (63.75)")
})

testthat::test_that("xx.xx (xx.x)", {
  expect_identical(trim_perc(c(10, 0.6375)), "10 (63.8)")
})

testthat::test_that("(xx\\%, xx\\%)", {
  expect_identical(perc_perc(c(0.2, 0.6375)), "20% (64%)")
})

testthat::test_that("xx.xx (xx.xx, xx.xx)", {
  expect_identical(format_3d(c(10, 0.6375, 0.2413)), "10 (0.64, 0.24)")
})
