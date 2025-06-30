#' Determine Slide Insertion Page Number
#'
#' Computes the appropriate page number at which to insert a new slide into the PowerPoint deck.
#' Defaults to appending to the end if no value is provided.
#'
#' @param doc_original An `officer::rpptx` object representing the PowerPoint file.
#' @param to_page Desired slide index to insert the new slide. If `NA`, appends to the last page.
#'
#' @return A single integer value indicating the validated page number for slide insertion.
#'
#' @export
#'
#' @examples
#' doc <- officer::read_pptx("example.pptx")
#' initialize_to_page(doc, NA) # append to end
#' initialize_to_page(doc, 3) # insert at page 3
initialize_to_page <- function(doc_original, to_page) {
  max_pages <- length(doc_original)
  if (max_pages == 0) {
    max_pages <- 1
  }
  if (is.na(to_page)) {
    to_page <- max_pages
  }

  assert_that((max_pages + 1) >= to_page)
  to_page
}

#' Post-process PowerPoint Document
#'
#' Performs final actions on the PowerPoint object, including optionally saving the updated file.
#' The saved filename includes a suffix indicating the slide type that was appended.
#'
#' @param doc An `officer::rpptx` object to finalize.
#' @param save_file A boolean indicating whether to save the file to disk.
#' @param doc_o Original PowerPoint file path.
#' @param type A string suffix to label the output file, e.g., `"cohort_sec"` or `"safety_sum_sec"`.
#'
#' @return The modified `officer::rpptx` object.
#'
#' @export
#'
#' @examples
#' doc <- officer::read_pptx("slides.pptx")
#' postprocessing_doc(doc, TRUE, "slides.pptx", type = "final")
postprocessing_doc <- function(doc, save_file, doc_o, type = "") {
  if (save_file) {
    doc_dir <- dirname(doc_o)
    doc_base_name <- tools::file_path_sans_ext(basename(doc_o))

    doc_ext <- tools::file_ext(basename(doc_o))
    outfile_name <- paste0(doc_base_name, "_", type, ".", doc_ext)

    # Combine the directory with the new filename to get the full output path
    outfile_final <- file.path(doc_dir, outfile_name)
    print(doc, outfile_final)
  }

  return(doc)
}


#' Initialize PowerPoint Document Object
#'
#' This function ensures a PowerPoint document (`officer::rpptx` object) is loaded.
#' If a `doc_original` is provided, it is directly returned. Otherwise, the function reads
#' the presentation from the given file path.
#'
#' @param doc_original An existing `officer::rpptx` object, or `NULL` to read from file.
#' @param doc_o Path to a PowerPoint (`.pptx`) file. Used only if `doc_original` is `NULL`.
#'
#' @return An `officer::rpptx` PowerPoint object.
#'
#' @export
#'
#' @examples
#' example <- tempfile(fileext = ".pptx")
#' Add contents into the pptx file
#' officer::read_pptx() %>%
#'   officer::add_slide() %>%
#'   print(target = example)
#'
#' doc <- initialize_doc_original(NULL, example)
initialize_doc_original <- function(doc_original, doc_o) {
  if (is.null(doc_original)) {
    doc_original <- officer::read_pptx(doc_o)
  }
  doc_original
}
