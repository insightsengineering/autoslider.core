test_that("Test some functions in util.R", {
  df1 <- data.frame(1:3, 2:4)
  df2 <- df1
  df2[1, 1] <- NA

  testthat::expect_no_error(na_replace(df1))
  testthat::expect_no_error(na_replace(df2))
  testthat::expect_no_error(dec_paste())
  testthat::expect_no_error(dec_paste("test1", "test2"))
  testthat::expect_no_error(to_vector(list(1:10, 2:11)))
  testthat::expect_no_error(c(0.999, 0.1898))
  testthat::expect_no_error(get_remote_url())
  testthat::expect_no_error(get_last_gitcommit_sha())
  testthat::expect_no_error(get_repo_head_name())
  testthat::expect_warning(warn())
  testthat::expect_no_error(git_footnote())
  testthat::expect_no_error(enumerate(1))
  testthat::expect_no_error(enumerate(1:3))
  testthat::expect_no_error(map_num(1:3, sum))
  testthat::expect_no_error(get_version_label_output())
})
