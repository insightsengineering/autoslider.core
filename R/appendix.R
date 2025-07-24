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
#' tmp <- tempfile(fileext = ".pptx")
#' doc <- officer::read_pptx()
#' doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")
#' print(doc, target = tmp)
#' doc <- officer::read_pptx(tmp)
#' initialize_to_page(doc, NA) # append to end
#' initialize_to_page(doc, 1) # insert at page 1
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
#' tmp <- tempfile(fileext = ".pptx")
#' doc <- officer::read_pptx()
#' doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")
#' print(doc, target = tmp)
#' doc <- officer::read_pptx(tmp)
#' # Call postprocessing_doc to save a modified version of doc
#' postprocessing_doc(doc, TRUE, tmp, type = "final")
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
#' doc <- officer::read_pptx()
#' doc <- officer::add_slide(doc, layout = "Title and Content")
#' print(doc, target = example)
#' doc <- initialize_doc_original(NULL, example)
initialize_doc_original <- function(doc_original, doc_o) {
  if (is.null(doc_original)) {
    doc_original <- officer::read_pptx(doc_o)
  }
  doc_original
}


#' Append Title Slides to a PowerPoint Document
#'
#' This function adds a new title slide using a "Title and Content" layout
#' from the "Office Theme".
#'
#' @param doc_o Path to a PowerPoint (`.pptx`) file. Used to initialize the document
#'   if `doc_original` is `NULL`.
#' @param study_id A character string that represent your study identifier.
#' @param to_page An integer specifying the page number where the new slide should be moved.
#' @param doc_original An optional existing `officer::rpptx` object. If `NULL`,
#'   the document is initialized from `doc_o`.
#' @param save_file A logical value. If `TRUE`, the modified document is saved to a file
#'   after adding the slide.
#'
#' @return An `officer::rpptx` object with the new title slide appended.
#'
#' @export
#'
#' @examples
#'
#' tmp <- tempfile(fileext = ".pptx")
#' doc <- officer::read_pptx()
#' doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")
#' print(doc, target = tmp)
#'
#' doc <- append_title_slides(
#'   doc_o = tmp,
#'   study_id = "My Study #13",
#'   to_page = 1,
#'   save_file = TRUE
#' )
append_title_slides <- function(
    doc_o,
    study_id = "XXXX change me",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)

  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    officer::add_slide(layout = "Title and Content", master = "Office Theme") %>%
    officer::ph_with(
      value = paste0(study_id, "Meeting"),
      location = officer::ph_location_type(type = "title")
    ) %>%
    officer::ph_with(
      value = paste0("meeting"),
      location = officer::ph_location_type(type = "body")
    ) %>%
    officer::move_slide(to = to_page)

  postprocessing_doc(doc, save_file, doc_o, type = "title")

  return(doc)
}



#' Append Section Header Slides to a PowerPoint Document
#'
#' This function adds a new section header slide to an existing PowerPoint document
#' using a "Section Header" layout from the "Office Theme".
#' It populates the title placeholder with the provided section title.
#'
#' @param doc_o Path to a PowerPoint (`.pptx`) file. Used to initialize the document
#'   if `doc_original` is `NULL`, and for post-processing.
#' @param section_title A character string for the title of the section header slide.
#'   Defaults to "New Section".
#' @param to_page An integer specifying the page number where the new slide should be moved.
#'   If `NA`, the slide is added at the end and `initialize_to_page` determines its final position.
#' @param doc_original An optional existing `officer::rpptx` object. If `NULL`,
#'   the document is initialized from `doc_o`.
#' @param save_file A logical value. If `TRUE`, the modified document is saved to a file
#'   after adding the slide.
#'
#' @return An `officer::rpptx` object with the new section header slide appended.
#'
#' @export
#'
#' @examples
#'
#' tmp <- tempfile(fileext = ".pptx")
#' doc <- officer::read_pptx()
#' print(doc, target = tmp)
#'
#' append_section_header_slides(
#'   doc_o = tmp,
#'   section_title = "My Section",
#'   to_page = 1,
#'   save_file = TRUE
#' )
append_section_header_slides <- function(
    doc_o,
    section_title = "New Section",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)

  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    officer::add_slide(layout = "Section Header", master = "Office Theme") %>%
    officer::ph_with(
      value = section_title,
      location = officer::ph_location_type(type = "title")
    ) %>%
    officer::move_slide(to = to_page)

  postprocessing_doc(doc, save_file, doc_o, type = "section_header")

  return(doc)
}

#' Append All Predefined Slides to a PowerPoint Document
#'
#' This function orchestrates the appending of a series of predefined slides
#' (including title and section header slides) to a PowerPoint document based
#' on a provided page list.
#'
#' @param doc_o Path to a PowerPoint (`.pptx`) file. Used to initialize the document
#'   if `doc_original` is `NULL`, and for final post-processing.
#' @param page_list A list of slide definitions. Each element in the list should be
#'   another list containing:
#'   - `type`: A character string indicating the type of slide ("title" or "section").
#'   - `to_page`: An integer specifying the target page number for the slide.
#'   - Other arguments specific to the slide type (e.g., `study_id` for "title" slides,
#'     `section_title` for "section" slides).
#' @param doc_original An optional existing `officer::rpptx` object. If `NULL`,
#'   the document is initialized from `doc_o`.
#' @param save_file A logical value. If `TRUE`, the final modified document is saved
#'   to a file after all slides have been appended.
#'
#' @return An `officer::rpptx` object with all specified slides appended.
#'
#' @export
#' @examples
#' tmp <- tempfile(fileext = ".pptx")
#' doc <- officer::read_pptx()
#' print(doc, target = tmp)
#'
#' my_page_list <- list(
#'   list(type = "title", to_page = 1, study_id = "My Project"),
#'   list(type = "section", to_page = 2, section_title = "Introduction"),
#'   list(type = "title", to_page = 3, study_id = "Mid-Term Review"),
#'   list(type = "section", to_page = 4, section_title = "Key Findings")
#' )
#'
#' # Append all slides using the dynamic page_list
#' doc <- append_all_slides(
#'   doc_o = tmp,
#'   page_list = my_page_list,
#'   save_file = TRUE
#' )
append_all_slides <- function(
    doc_o,
    page_list = list(), # Default to an empty list
    doc_original = NULL,
    save_file = FALSE) {
  doc <- initialize_doc_original(doc_original, doc_o)


  for (page in page_list) {
    current_to_page <- page$to_page


    if (page$type == "title") {
      doc <- append_title_slides(
        doc_o = doc_o,
        doc_original = doc,
        to_page = current_to_page,
        study_id = page$study_id,
        save_file = FALSE
      )
    } else if (page$type == "section") {
      doc <- append_section_header_slides(
        doc_o = doc_o,
        doc_original = doc,
        to_page = current_to_page,
        section_title = page$section_title,
        save_file = FALSE
      )
    }
  }

  postprocessing_doc(doc, save_file, doc_o, type = "final")

  return(doc)
}
