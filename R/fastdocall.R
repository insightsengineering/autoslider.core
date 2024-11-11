#' Does do.call quicker, and avoids issues with debug mode within do.call
#' @description copied from ms showcase app
#' @param what either a function or a non-empty character string naming the function to be called.
#' @param args a list of arguments to the function call. The names attribute of args gives the argument names.
#' @param quote a logical value indicating whether to quote the arguments.
#' @param envir an environment within which to evaluate the call. This will be most useful if what is a character
#' string and the arguments are symbols or quoted expressions.
#' @export
fastDoCall <-
  function(what,
           args,
           quote = FALSE,
           envir = parent.frame()) {
    if (quote) {
      args <- lapply(args, enquote)
    }

    if (is.null(names(args))) {
      argn <- args
      args <- list()
    } else {
      # Add all the named arguments
      argn <- lapply(names(args)[names(args) != ""], as.name)
      names(argn) <- names(args)[names(args) != ""]
      # Add the unnamed arguments
      argn <- c(argn, args[names(args) == ""])
      args <- args[names(args) != ""]
    }

    if (is(what, "character")) {
      if (is.character(what)) {
        fn <- strsplit(what, "[:]{2,3}")[[1]]
        what <- if (length(fn) == 1) {
          get(fn[[1]], envir = envir, mode = "function")
        } else {
          get(fn[[2]], envir = asNamespace(fn[[1]]), mode = "function")
        }
      }
      call <- as.call(c(list(what), argn))
    } else if (is(what, "function")) {
      f_name <- deparse(substitute(what))
      call <- as.call(c(list(as.name(f_name)), argn))
      args[[f_name]] <- what
    } else if (is(what, "name")) {
      call <- as.call(c(list(what, argn)))
    }

    eval(call,
      envir = args,
      enclos = envir
    )
  }
