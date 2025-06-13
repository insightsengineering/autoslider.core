#' [EXPERIMENTAL] Create new output function based on a template.
#'
#'
#' @description
#'
#' We have separate templates for listings, tables, and graphs.
#' There is also a template to set up the `run_all` script.
#'
#'
#' @param template Must be one of `r list_all_templates()`
#' @param function_name What output would you like to create?
#' @param save_path Path to save the function, should include filename and extension.
#'                  Defaults to "./programs/**function_name**_slide.R"
#' @param overwrite Whether to overwrite an existing file named `save_path`.
#' @param open Whether to open the script right away.
#'
#' @return No return values, called for side effects
#'
#' @details Use `list_all_templates()` to discover which templates are available.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   use_template("l_template_slide")
#' }
use_template <- function(template = "t_dm_slide",
                         function_name = "default",
                         save_path = NULL,
                         overwrite = FALSE,
                         open = interactive()) {
  assert_that(assertthat::is.string(template))
  # assert_that(assertthat::is.string(save_path))
  assert_that(assertthat::is.flag(overwrite))
  assert_that(assertthat::is.flag(open))

  if (is.null(save_path)) {
    target_dir <- "./programs/R"

    if (!dir.exists(target_dir)) {
      dir.create(target_dir, recursive = TRUE)
    }

    save_path <- file.path(target_dir, paste0(function_name, "_XXXX.R"))
  } else {
    # Original validation logic for when save_path is provided
    assertthat::has_extension(save_path, ext = "R")
    assertthat::is.writeable(save_path %>% dirname())
  }

  package <- "autoslide.core"
  if (!tolower(template) %in% list_all_templates()) {
    err_msg <- sprintf(
      paste0(
        "No template for '%s' available in package '%s'.\n",
        "\u2139 Run `list_all_templates()` to get a list of all available templates."
      ),
      tolower(template), package
    )
    abort(err_msg)
  }

  if (file.exists(save_path) && !overwrite) {
    err_msg <- paste(
      sprintf("A file named '%s' already exists.", save_path),
      "\u2139 Set `overwrite = TRUE` to force overwriting it.",
      sep = "\n"
    )
    abort(err_msg)
  }

  #template_file <- system.file(
   # paste0("R/", tolower(template), ".R"),
  #  package = package
  #)


  template_file <- file.path("R", paste0(tolower(template), ".R"))

  # Check if the file exists:
  if (!file.exists(template_file)){
    err_msg <- sprintf(
      "No templates named '%template_file' are available",
      package
    )
    abort(err_msg)
  }
  if (file.copy(template_file, save_path, overwrite = TRUE)) {
    rlang::inform(sprintf("\u2713 File '%s' has been created successfully", save_path))
    file_lines <- readLines(save_path)

    file_lines <- file_lines[!grepl("^#'", file_lines)]
    file_lines <- file_lines[nzchar(file_lines)]

    # Replace function name with numbering
    file_lines <- gsub(tolower(template), function_name, file_lines)
    writeLines(file_lines, save_path)
  }

  if (open) {
    file.edit(save_path)
  }

  invisible(TRUE)
}

#' [EXPERIMENTAL] List All Available Templates
#'
#' @family utils_examples
#' @keywords utils_examples
#'
#' @return A `character` vector of all available templates
#'
#' @export
#'
#' @examples
#' list_all_templates()
list_all_templates <- function() {
  package <- "autoslider.core"
  if (!requireNamespace(package, quietly = TRUE)) {
    err_msg <- sprintf(
      "No package called '%s' is installed and hence no templates are available",
      package
    )
    abort(err_msg)
  }
  # list all table templates in R folder
  list.files(system.file("R", package = package)) %>%
    stringr::str_remove(".R$") %>%
    # str_remove("^ad_") %>%
    tolower() %>%
    stringr::str_subset("^(t_|l_|g_)") %>%
    structure(package = package)
}
