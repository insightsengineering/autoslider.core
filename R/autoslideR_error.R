#' autoslider_error class
#' @details this function is used to create autoslider_error object.
#' this function is for internal use only to create the autoslider_error object.
#' It enable us for further functionalities, like providing help on easy debuging,
#' e.g. if the error is inside the user function, provide the call and let the user
#' run the code outside the pipeline.
#' @param x character scaler
#' @param spec spec should be a list containing "program" and "suffix"
#' @param step step is a character indicating in which step the pipeline encounter error
#' @noRd
#' @export
autoslider_error <- function(x, spec, step) {
  assert_is_character_scalar(x)
  structure(
    .Data = x,
    step = step,
    spec = spec,
    class = "autoslider_error"
  )
}
