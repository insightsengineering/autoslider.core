#' [EXPERIMENTAL] Create new output function based on a template.
#'
#' We have separate templates for listings, tables, and graphs.
#' There is also a template to set up the `run_all` script.
#'
#' @param template Must be one of `list_all_templates(package = "autoslider.core")`.
#' @param function_name Name of the output function you want to create. Defaults to "default".
#' @param save_path Path to save the function. Defaults to "./programs/R".
#' @param overwrite Whether to overwrite an existing file.
#' @param open Whether to open the file after creation.
#' @param package Which package to search for the template file. Defaults to "autoslider.core".
#'
#' @return No return value. Called for side effects (writes a file).
#'
#' @details Use `list_all_templates(package = "autoslider.core")` to discover which templates are available.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   use_template("t_dm_slide", function_name = "my_table", package = "autoslider.core")
#' }
use_template <- function(template = "t_dm_slide",
                         function_name = "default",
                         save_path = "./programs/R",
                         overwrite = FALSE,
                         open = interactive(),
                         package = "autoslider.core") {
  assert_that(assertthat::is.string(template))
  assert_that(assertthat::is.string(package))
  assert_that(assertthat::is.flag(overwrite))
  assert_that(assertthat::is.flag(open))
  assert_that(!is.null(save_path))
  assert_that(template %in% list_all_templates(package) ||
                paste0(system.file("R", package = package), "/", template) %in%
                list_all_templates(package))

  if (!dir.exists(save_path)) {
    dir.create(save_path, recursive = TRUE)
  }

  save_path <- file.path(save_path, paste0(function_name, ".R"))

  # Original validation logic for when save_path is provided
  assertthat::has_extension(save_path, ext = "R")
  assertthat::is.writeable(save_path %>% dirname())



  # if (!tolower(template) %in% list_all_templates()) {
  #   err_msg <- sprintf(
  #     paste0(
  #       "No template for '%s' available in package '%s'.\n",
  #       "\u2139 Run `list_all_templates()` to get a list of all available templates."
  #     ),
  #     tolower(template), package
  #   )
  #   abort(err_msg)
  # }

  if (file.exists(save_path) && !overwrite) {
    err_msg <- paste(
      sprintf("A file named '%s' already exists.", save_path),
      "\u2139 Set `overwrite = TRUE` to force overwriting it.",
      sep = "\n"
    )
    abort(err_msg)
  }

  file_list <- get_template_filepath(package = package, full.names = TRUE)
  template_file <- file_list[basename(file_list) == paste0(template, ".R")]


  if (template_file == "" || !file.exists(template_file)) {
    err_msg <- sprintf(
      "No templates named '%s' are available",
      tolower(template)
    )
    abort(err_msg)
  }
  # print(save_path)
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
#' @param package Which package to search for the template files. Defaults to "autoslider.core".
#'
#' @return A character vector of available template names in the specified package.
#'
#' @export
#'
#' @examples
#' list_all_templates(package = "autoslider.core")
list_all_templates <- function(package = "autoslider.core") {
  get_template_filepath(package = package, full.names = FALSE) |>
    stringr::str_remove("\\.R$") |>
    structure(package = package)
}


#' Retrieve Template File Paths
#'
#' @param package A character string specifying the name of the package to search.
#' @param full.names If `TRUE`, returns the full path to each file.
#'                   If `FALSE`, returns only the file names.
#'
#' @return A character vector of template file names or paths, depending on `full.names`.
#'
#' @export
#'
#' @keywords internal
get_template_filepath <- function(package = "autoslider.core", full.names = FALSE) {
  # Installed-package path
  template_dir <- system.file("templates", package = package)

  pattern <- "^(t_|l_|g_)"
  if (full.names == TRUE) {
    pattern <- paste0(paste0(template_dir, "/"), c("t_", "g_", "l_"),
                      collapse = "|"
    )
  }

  list.files(template_dir, pattern = "\\.R$", full.names = full.names) |>
    stringr::str_subset(pattern)
}
