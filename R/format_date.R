#' Convert dates from `yyyy-mm-dd` format into 20APR2019 format
#' `Datetime` format removes the time and outputs date in the same way
#' Able to handle truncated dates as well (e.g. just the year or year and month)
#'
#' `dplyr::case_when()` will check all RHS expressions on the input, this means if
#' these expressions return warnings, they will happen even then the input doesn't
#' doesn't satisfy the LHS. For this reason, I had to 'quiet' all `lubridate` functions.
#' This `format_date()` function was tested with the inputs in the examples, all gave the
#' expected returned value, so there should be no issues.
#'
#' @param x vector of dates in character, in `yyyy-mm-dd` format
#' @return A vector.
#'
#' @export
#' @examplesIf require(lubridate)
#' require(lubridate)
#'
#' # expected to return "2019"
#' format_date("2019")
#'
#' # expected to return "20APR2019"
#' format_date("2019-04-20")
#'
#' # expected to return ""
#' format_date("")
#'
#' # expected to return "18JUN2019"
#' format_date("2019-06-18T10:32")
#'
#' # expected to return "APR2019"
#' format_date("2019-04")
#'
format_date <- function(x) {
  x_form <- case_when(
    nchar(x) > 10 ~ toupper(format(lubridate::date(lubridate::ymd_hms(x, truncated = 3, quiet = TRUE)), "%d%b%Y")),
    nchar(x) == 10 ~ toupper(format(lubridate::ymd(x, quiet = TRUE), "%d%b%Y")),
    nchar(x) == 7 ~ substr(toupper(format(lubridate::ymd(x, truncated = 2, quiet = TRUE), "%d%b%Y")), 3, 9),
    nchar(x) == 4 ~ x,
    is.na(x) ~ "",
    TRUE ~ ""
  )

  x_form
}
