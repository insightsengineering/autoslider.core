#' function wrapper to pass filtered data
#' @param func function name
#' @param datasets list of raw datasets
#' @param spec spec
#' @param verbose whether to show verbose information
#' @return a wrapped function using filtered adam
func_wrapper <-
  function(func, datasets, spec, verbose = TRUE) {
    suffix <- spec$suffix
    function_args <- names(formals(func))
    datasets_filtered <- filters::apply_filter(
      data = datasets,
      id = suffix,
      verbose = verbose
    )

    if ("datasets" %in% function_args) {
      if ("spec" %in% function_args) {
        return({
          function(...) {
            fastDoCall(func, list(datasets_filtered, spec = spec, ...))
          }
        })
      } else {
        return({
          function(...) {
            fastDoCall(func, list(datasets_filtered, ...))
          }
        })
      }
    } else {
      # to keep compatibility with previous version
      data_used <-
        function_args[function_args %in% names(datasets)]
      if ("spec" %in% function_args) {
        return({
          function(...) {
            fastDoCall(func, c(
              datasets_filtered[data_used],
              list(spec = spec),
              list(...)
            ))
          }
        })
      } else {
        return({
          function(...) {
            fastDoCall(func, c(datasets_filtered[data_used], list(...)))
          }
        })
      }
    }
  }
