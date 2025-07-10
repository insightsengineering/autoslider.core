abort <- function(...) {
  stop(..., call. = FALSE)
}

assert_is_character_scalar <- function(x) {
  if (length(x) != 1L || is.na(x) || !is.character(x) || x == "") {
    abort("`", deparse(substitute(x)), "` must be a character scalar.")
  }
}

assert_is_valid_version_label <- function(x) {
  if (!(x %in% c("DRAFT", "APPROVED") || is.null(x))) {
    abort("Version label must be 'DRAFT', 'APPROVED' or `NULL` but is '", x, "'.")
  }
}


assert_exists_in_spec_or_calling_env <- function(vars, output, env = parent.frame()) {
  exist_in_spec <- vars %in% names(output)
  # explicitly define env to use, better practice for testing
  exist_in_calling_env <- map_lgl(vars, exists, envir = env)

  non_existing_vars <- vars[!(exist_in_spec | exist_in_calling_env)]


  n <- length(non_existing_vars)
  if (n >= 1L) {
    err_msg <- sprintf(
      paste(
        "Cannot filter based upon the %s %s as %s not contained in",
        "`spec` or the surrounding environment."
      ),
      if (n == 1L) "variable" else "variables",
      enumerate(non_existing_vars),
      if (n == 1L) "it is" else "they are"
    )
    stop(err_msg, call. = FALSE)
  }
}

assert_is_valid_filter_result <- function(x) {
  if (length(x) != 1L || is.na(x) || !is.logical(x)) {
    stop(
      "`filter_expr` must evaluate to a logical scalar but returned `",
      deparse(x), "`.",
      call. = FALSE
    )
  }
}
