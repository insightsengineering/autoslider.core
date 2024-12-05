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
