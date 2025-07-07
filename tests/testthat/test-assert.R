library(testthat)

test_that("assert_is_character_scalar works correctly", {
  x <- "a"
  expect_silent(assert_is_character_scalar(x))

  y <- 1
  expect_error(assert_is_character_scalar(y), "`y` must be a character scalar.")
  z <- c("a", "b")
  expect_error(assert_is_character_scalar(z), "`z` must be a character scalar.")
  w <- ""
  expect_error(assert_is_character_scalar(w), "`w` must be a character scalar.")
  v <- NA_character_
  expect_error(assert_is_character_scalar(v), "`v` must be a character scalar.")
  u <- NULL
  expect_error(assert_is_character_scalar(u), "`u` must be a character scalar.")
})

test_that("assert_exists_in_spec_or_calling_env is robustly testable", {
  # Create a clean environment for testing
  test_env <- rlang::env(
    my_calling_env_var = "some_value"
  )

  spec_output <- list(program = "t_dm", suffix = "IT")

  expect_silent(
    assert_exists_in_spec_or_calling_env(
      vars = "my_calling_env_var",
      output = spec_output,
      env = test_env
    )
  )


  expect_silent(
    assert_exists_in_spec_or_calling_env(
      vars = c("program", "suffix"),
      output = spec_output,
      env = test_env
    )
  )


  expect_error(
    assert_exists_in_spec_or_calling_env(
      vars = "xxxx",
      output = spec_output,
      env = test_env
    )
  )
})

test_that("assert_is_valid_filter_result passes with valid inputs", {
  expect_silent(assert_is_valid_filter_result(TRUE))
  expect_silent(assert_is_valid_filter_result(FALSE))
})

test_that("assert_is_valid_filter_result fails with invalid inputs", {
  # Test wrong types
  expect_error(assert_is_valid_filter_result(1), "must evaluate to a logical scalar")
  expect_error(assert_is_valid_filter_result("TRUE"), "must evaluate to a logical scalar")
  expect_error(assert_is_valid_filter_result(NULL), "must evaluate to a logical scalar")

  # Test wrong length
  expect_error(assert_is_valid_filter_result(c(TRUE, TRUE)), "must evaluate to a logical scalar")
  expect_error(assert_is_valid_filter_result(logical(0)), "must evaluate to a logical scalar")

  # Test NA
  expect_error(assert_is_valid_filter_result(NA), "must evaluate to a logical scalar")
})
