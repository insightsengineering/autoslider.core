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
#' initialize_to_page(doc, NA)    # append to end
#' initialize_to_page(doc, 3)     # insert at page 3
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
    outfile_final <- paste0(dirname(doc_o), basename(doc_o), "_", type, ".pptx")
    print(doc, outfile_final)
  }

  return(doc)
}
