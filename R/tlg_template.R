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
                         save_path = "./programs/R",
                         overwrite = FALSE,
                         open = interactive()) {
  package <- "autoslider.core"
  assert_that(assertthat::is.string(template))
  # assert_that(assertthat::is.string(save_path))
  assert_that(assertthat::is.flag(overwrite))
  assert_that(assertthat::is.flag(open))
  assert_that(!is.null(save_path))
  assert_that(template %in% list_all_templates() || paste0(system.file("R", package = package), "/", template) %in% list_all_templates())

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

  file_list <- get_template_filepath(full.names = TRUE)
  template_file <- file_list[grepl(template, file_list)]


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
  get_template_filepath(full.names = FALSE) |>
    stringr::str_remove("\\.R$") |>
    structure(package = "autoslider.core")
}

get_template_filepath <- function(full.names = FALSE) {
  package <- "autoslider.core"

  # Installed-package path
  template_dir <- system.file("templates", package = package)

  pattern <- "^(t_|l_|g_)"
  if (full.names == TRUE) {
    pattern <- paste0(paste0(template_dir, "/"), c("t_", "g_", "l_"), collapse = "|")
  }

  list.files(template_dir, pattern = "\\.R$", full.names = full.names) |>
    stringr::str_subset(pattern)
}
