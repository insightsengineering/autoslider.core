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



  test_that("validate_paper_size works correctly", {
    expect_silent(validate_paper_size("L10"))
    expect_silent(validate_paper_size("P8"))
    expect_silent(validate_paper_size("P14"))

    # Test for errors
    expect_error(validate_paper_size("A10"), "Page size must be starting with `L` or `P`")
    expect_error(validate_paper_size("L15"), "Fontsize should be less or equal than 14")
    expect_error(validate_paper_size("P"), "Page size must be starting with `L` or `P`")
    expect_error(validate_paper_size("L1O"), "Page size must be starting with `L` or `P`") # O instead of 0
  })

  test_that("Legacy warning functions work as expected", {
    # Reset warning flags before test
    .autoslider_config$filter_warning_issued <- FALSE
    .autoslider_config$paper_size_warning_issued <- stats::setNames(
      rep(FALSE, 2), c("a4r", "a4")
    )

    # Test filtering warning
    expect_warning(warn_about_legacy_filtering("t_dm_IT"), "deprecated")
    # Second call should be silent
    expect_silent(warn_about_legacy_filtering("t_dm_IT"))

    # Test paper size warning
    expect_warning(warn_about_legacy_paper_size("a4r", "L11"), "Paper size 'a4r' is deprecated")
    # Second call for the same legacy size should be silent
    expect_silent(warn_about_legacy_paper_size("a4r", "L11"))
    # A different legacy size should still warn
    expect_warning(warn_about_legacy_paper_size("a4", "P11"), "Paper size 'a4' is deprecated")
  })
})
