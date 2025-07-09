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
    expect_warning(warn_about_legacy_filtering("t_dm_IT"), "deprecated")
    # Second call should be silent
    expect_silent(warn_about_legacy_filtering("t_dm_IT"))

    expect_warning(warn_about_legacy_paper_size("a4r", "L11"), "Paper size 'a4r' is deprecated")
    # Second call for the same legacy size should be silent
    expect_silent(warn_about_legacy_paper_size("a4r", "L11"))
    expect_warning(warn_about_legacy_paper_size("a4", "P11"), "Paper size 'a4' is deprecated")
  })


  test_that("vbar2newline correctly replaces vertical bars", {
    expect_equal(vbar2newline("hello | world"), "hello\nworld")
    expect_equal(vbar2newline("hello|world"), "hello\nworld")
    expect_equal(vbar2newline("A | B | C"), "A\nB\nC")
    expect_equal(vbar2newline("NoVbarHere"), "NoVbarHere")
    expect_equal(vbar2newline(""), "")
  })


  test_that("munge_spaces correctly replaces various whitespace", {
    expect_equal(munge_spaces("hello\tworld"), "hello world")
    expect_equal(munge_spaces("hello\nworld"), "hello world")
    expect_equal(munge_spaces("hello  world"), "hello  world")
    expect_equal(munge_spaces(" leading"), " leading")
    expect_equal(munge_spaces("trailing "), "trailing ")
  })

  test_that("split_chunk correctly splits text into words", {
    expect_equal(split_chunk("hello world"), c("hello", "world"))
    expect_equal(split_chunk("hello\tworld\nagain"), c("hello", "world", "again"))
    expect_equal(split_chunk("hello   world"), c("hello", "world"))
    expect_equal(split_chunk("singleword"), c("singleword"))
    expect_equal(split_chunk(""), character(0))
  })


  test_that("wrap_chunk wraps text correctly", {
    chunks1 <- c("This", "is", "a", "test.")
    expect_equal(wrap_chunk(chunks1, 20), list("This is a test."))

    chunks2 <- c("This", "is", "a", "longer", "test", "to", "see", "wrapping.")
    expect_equal(wrap_chunk(chunks2, 15), list("This is a", "longer test to", "see wrapping."))

    chunks3 <- c("A", "verylongword", "and", "some", "more.")
    expect_equal(wrap_chunk(chunks3, 8), list("A", "verylong", "word and", "some", "more."))

    expect_equal(wrap_chunk(character(0), 10), list())

    chunks4 <- c("one", "two", "three")
    expect_equal(wrap_chunk(chunks4, 13), list("one two three"))

    chunks5 <- c("one", "two", "three", "four")
    expect_equal(wrap_chunk(chunks5, 13), list("one two three", "four"))
  })

  test_that("git_footnote returns repo", {
    expect_silent(git_footnote())
  })


  test_that("on_master_branch", {
    # my local testing branch is called unittest
    expect_warning(on_master_branch())
  })

  test_that("create_new_reporting_event", {
    temp_dir <- tempfile(pattern = "revent")

    create_new_reporting_event(temp_dir)
    expect_true(dir.exists(temp_dir))
    expect_true(file.exists(file.path(temp_dir, "metadata.yml")))

    unlink(temp_dir, recursive = TRUE)
  })

  test_that("create_output_name", {
    expect_equal(create_output_name("t_dm", "IT"), "t_dm_IT")
    expect_equal(create_output_name("t_dm", ""), "t_dm")
    expect_equal(create_output_name("t_dm", NA), "t_dm")
    expect_equal(create_output_name("l_ae", "SE"), "l_ae_SE")
  })


  test_that("text_wrap_cut works correctly", {
    expect_equal(text_wrap_cut("A long line of text to be wrapped", 10), "A long\nline of\ntext to be\nwrapped")
    expect_equal(text_wrap_cut("A verylongword", 8), "A\nverylong\nword")
    expect_equal(text_wrap_cut("short", 10), "short")
    expect_equal(text_wrap_cut("Another test", 0), "")
  })

  test_that("text_wrap_cut_keepreturn respects existing newlines", {
    text_with_newlines <- "First line to wrap.\nSecond, much longer line of text that also needs to be wrapped."
    expected_output <- "First line\nto wrap.\nSecond,\nmuch\nlonger\nline of\ntext that\nalso needs\nto be\nwrapped."
    expect_equal(text_wrap_cut_keepreturn(text_with_newlines, 10), expected_output)

    # Test with empty lines
    text_with_empty_lines <- "Line 1\n\nLine 3"
    expected_empty <- "Line 1\n\nLine 3"
    expect_equal(text_wrap_cut_keepreturn(text_with_empty_lines, 20), expected_empty)
  })
})
