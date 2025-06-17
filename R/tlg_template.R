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
  assert_that(assertthat::is.string(template))
  # assert_that(assertthat::is.string(save_path))
  assert_that(assertthat::is.flag(overwrite))
  assert_that(assertthat::is.flag(open))
  assert_that(!is.null(save_path))


  if (!dir.exists(save_path)) {
    dir.create(save_path, recursive = TRUE)
  }

  save_path <- file.path(save_path, paste0(function_name, ".R"))

  # Original validation logic for when save_path is provided
  assertthat::has_extension(save_path, ext = "R")
  assertthat::is.writeable(save_path %>% dirname())


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

  template_file <- system.file(
  paste0("R/", tolower(template), ".R"),
   package = package
  )


  #template_file <- file.path(rprojroot::find_package_root_file("R"), paste0(tolower(template), ".R"))
  #template_dir <- system.file("R", package = package)

  print(template_file)
  # Check if the file exists:

  # Fallback for development mode (e.g., when testing locally)
  if (template_file == "" || !file.exists(template_file)) {
    fallback_file <- file.path("R", paste0(tolower(template), ".R"))
    if (file.exists(fallback_file)) {
      template_file <- fallback_file
    } else {
      err_msg <- sprintf(
        "No templates named '%s' are available",
        tolower(template)
      )
      abort(err_msg)
    }
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
  package <- "autoslider.core"
  template_files <- system.file("R", package = package)

  # Fallback to dev source dir if not found (e.g., during devtools::test())
  if (template_files == "" || !dir.exists(template_files)) {
    template_files <- "R"
  }

  list.files(template_files, pattern = "\\.R$", full.names = FALSE) %>%
    stringr::str_remove(".R$") %>%
    tolower() %>%
    stringr::str_subset("^(t_|l_|g_)") %>%
    structure(package = package)
}
