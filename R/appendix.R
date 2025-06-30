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
    # is this really the desired output directory?
    outfile_final <- paste0(dirname(doc_o), basename(doc_o), "_", type, ".pptx")
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
#' doc <- initialize_doc_original(NULL, "example.pptx")
initialize_doc_original <- function(doc_original, doc_o) {
  if (is.null(doc_original)) {
    doc_original <- officer::read_pptx(doc_o)
  }
  doc_original
}

#' Append Title Slides to PowerPoint
#'
#' Inserts the study title slide and agenda page at the beginning of the presentation.
#'
#' @param doc_o Path to the PowerPoint file.
#' @param study_id Study identifier to appear in the title.
#' @param title_page_info A character vector of role-based contributor lines to display.
#' @param meeting_date Meeting date string (e.g., "24-JUN-2025").
#' @param to_page Desired page to insert at. Defaults to 1.
#' @param doc_original Optional preloaded `officer::rpptx` object.
#' @param save_file Whether to save the modified presentation.
#'
#' @return Modified PowerPoint object with new title and agenda slides.
#'
#' @export
#'
#' @examples
#' append_starting_slides("slides.pptx", study_id = "AB123", meeting_date = "24-JUN-2025")
append_starting_slides <- function(
    doc_o,
    study_id = "XXXX change me",
    title_page_info = c(
      "Study Part X / Arm XX",
      "Cohort XXX",
      "Clinical Science: [Name]",
      "Safety Science: [Name]",
      "Clinical Pharmacology: [Name]",
      "Clinical Operations: [Name]",
      "Biostatistics: [Name]"
    ),
    meeting_date = "DD-MMM-YYYY",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    add_slide("04_CoverAlt", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0(study_id, " Dose Escalation Meeting"),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = c(
        title_page_info
      ),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    ph_with(
      value = paste0(
        "Meeting Date: ",
        meeting_date
      ),
      location = ph_location_label("Footer Placeholder 1")
    ) %>%
    move_slide(to = 1) %>%
    ################################
    ########## Agenda Page ##########
    ################################
    add_slide("16_DEM_Agenda", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0(study_id, " Dose Escalation Meeting"),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = "Agenda",
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = 2)

  postprocessing_doc(doc, save_file, doc_o, type = "starting")
}

#' Append Disclaimer Slide to PowerPoint
#'
#' Adds a slide with a disclaimer heading and subtitle.
#'
#' @param doc_o Path to the PowerPoint file.
#' @param study_id Study identifier.
#' @param to_page Desired page number to insert at.
#' @param doc_original Optional preloaded `officer::rpptx` object.
#' @param save_file Whether to save the modified file.
#'
#' @return Modified PowerPoint object with the disclaimer slide inserted.
#'
#' @export
#'
#' @examples
#' append_disclaimer_slides("slides.pptx", study_id = "AB123")
append_disclaimer_slides <- function(
    doc_o,
    study_id = "XXXX change me",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    add_slide("19_Disclaimer", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0(study_id, " Dose Esclation Meeting"),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = paste0("Disclaimer"),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = to_page)

  postprocessing_doc(doc, save_file, doc_o, type = "disclaimer")
}


#' Append Cohort Section Title Slide
#'
#' Inserts a slide that marks the start of a new cohort section.
#'
#' @param doc_o Path to the PowerPoint file.
#' @param cohort_id ID of the cohort (e.g., "Cohort 2").
#' @param cutoff_date Data cutoff date shown on the slide.
#' @param to_page Desired page number.
#' @param doc_original Optional preloaded `officer::rpptx` object.
#' @param save_file Whether to save the presentation.
#'
#' @return PowerPoint object with cohort title section slide.
#'
#' @export
#'
#' @examples
#' append_cohort_sec_slides("slides.pptx", cohort_id = "Cohort 2", cutoff_date = "24-JUN-2025")
append_cohort_sec_slides <- function(
    doc_o,
    cohort_id = "Cohort #X change me",
    cutoff_date = "DD-MMM-YYYY",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("05_CoverTitle", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Clinical Data Review - ", cohort_id),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = paste0("Cut-off date: ", cutoff_date),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = to_page)
  postprocessing_doc(doc, save_file, doc_o, type = "cohort_sec")
}

#' Append Lab Section Title Slide
#'
#' Adds a slide to introduce the lab parameters section of the meeting.
#'
#' @param doc_o Path to the PowerPoint file.
#' @param cohort_id Cohort label (e.g., "Cohort 2").
#' @param cutoff_date Date of the data cutoff.
#' @param to_page Desired page number.
#' @param doc_original Optional `officer::rpptx` object.
#' @param save_file Whether to save the result.
#'
#' @return PowerPoint object with lab section title slide added.
#'
#' @export
#'
#' @examples
#' append_lab_sec_slides("slides.pptx", cohort_id = "Cohort 2", cutoff_date = "24-JUN-2025")
append_lab_sec_slides <- function(
    doc_o,
    cohort_id = "Cohort #X change me",
    cutoff_date = "DD-MMM-YYYY",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("05_CoverTitle", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Lab Parameters of Interest - ", cohort_id),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = paste0("Cut-off date: ", cutoff_date),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = to_page)
  postprocessing_doc(doc, save_file, doc_o, type = "lab_sec")
}

#' Append Lab Section Title Slide
#'
#' Adds a slide to introduce the lab parameters section of the meeting.
#'
#' @param doc_o Path to the PowerPoint file.
#' @param cohort_id Cohort label (e.g., "Cohort 2").
#' @param cutoff_date Date of the data cutoff.
#' @param to_page Desired page number to add slide.
#' @param doc_original Optional `officer::rpptx` object.
#' @param save_file Whether to save the result.
#'
#' @return PowerPoint object with lab section title slide added.
#'
#' @export
#'
#' @examples
#' append_lab_sec_slides("slides.pptx", cohort_id = "Cohort 2", cutoff_date = "24-JUN-2025")
append_lab_sec_slides <- function(
    doc_o,
    cohort_id = "Cohort #X change me",
    cutoff_date = "DD-MMM-YYYY",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("05_CoverTitle", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Lab Parameters of Interest - ", cohort_id),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = paste0("Cut-off date: ", cutoff_date),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = to_page)
  postprocessing_doc(doc, save_file, doc_o, type = "lab_sec")
}

#' Append Safety Summary Section Slide
#'
#' Inserts a section divider slide labeled "Safety Summary".
#'
#' @param doc_o Path to the PowerPoint file.
#' @param cutoff_date Date used to annotate the summary.
#' @param to_page Page number to insert at.
#' @param doc_original Optional `officer::rpptx` object.
#' @param save_file Whether to write to file.
#'
#' @return Modified PowerPoint object.
#'
#' @export
#'
#' @examples
#' append_safetey_sum_sec_slides("slides.pptx", cutoff_date = "24-JUN-2025")
append_safetey_sum_sec_slides <- function(
    doc_o,
    cutoff_date = "DD-MMM-YYYY",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("05_CoverTitle", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Safety Summary"),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = paste0("Cut-off date: ", cutoff_date),
      location = ph_location_label("Subtitle Placeholder 1")
    ) %>%
    move_slide(to = to_page)
  postprocessing_doc(doc, save_file, doc_o, type = "safety_sum_sec")
}

#' Append Patient Details Section Slide
#'
#' Inserts a slide separating individual patient details within the report.
#'
#' @param doc_o PowerPoint file path.
#' @param to_page Target page number to insert to.
#' @param doc_original Optional preloaded PowerPoint object.
#' @param save_file Whether to save output.
#'
#' @return `officer::rpptx` object with patient section slide.
#'
#' @export
#'
#' @examples
#' append_patient_sec_slides("slides.pptx", to_page = 5)
append_patient_sec_slides <- function(
    doc_o,
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("19_PatientSeparator", master = "Half_Design_Left_master") %>%
    ph_with(
      value = c(
        "Details for Patient: BP12345-XXX1",
        "Site: Hospital",
        "Investigator name: Dr John Doe"
      ),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = c(
        "Cohort # ",
        "xx mg ROXXXXXXX in XX schedule / in combination with XXX at xx mg in XX schedule"
      ),
      location = ph_location_label("Text Placeholder 5")
    ) %>%
    move_slide(to = to_page)
  postprocessing_doc(doc, save_file, doc_o, type = "patient_sec")
}

#' Append Dose Proposal Slides for Next Meeting
#'
#' Adds a title slide and a dose proposal slide for the upcoming cohort.
#'
#' @param doc_o PowerPoint file path.
#' @param to_page Target index for first of two slides.
#' @param doc_original Optional `rpptx` object.
#' @param save_file Whether to save the result.
#'
#' @return PowerPoint object with added dose proposal content.
#'
#' @export
#'
#' @examples
#' append_next_meeting_slides("slides.pptx", to_page = 8)
append_next_meeting_slides <- function(
    doc_o,
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)
  doc <- doc_original %>%
    add_slide("05_CoverTitle", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Dose Proposal for the next Cohort "),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    move_slide(to = to_page) %>%
    add_slide("09_DoseProposal", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("Dose Proposal for the next Cohort "),
      location = ph_location_label("Title Placeholder 1")
    ) %>%
    ph_with(
      value = c(
        "Summary of Cohort # X",
        "Proposal: open a new cohort (cohort # X+1) at xx mg in Q3W schedule",
        "Question: Do the investigators present at the meeting agree to the proposal?"
      ),
      location = ph_location_label("Content Placeholder 1")
    ) %>%
    move_slide(to = (to_page + 1))

  postprocessing_doc(doc, save_file, doc_o, type = "next_meeting")
}


#' Append Motto Slide
#'
#' Adds a simple Roche-branded motto slide at the specified position.
#'
#' @param doc_o PowerPoint file path.
#' @param to_page Page number to insert at.
#' @param doc_original Optional `rpptx` object.
#' @param save_file Whether to save the result.
#'
#' @return PowerPoint object with motto slide.
#'
#' @export
#'
#' @examples
#' append_moto_slides("slides.pptx", to_page = 10)
append_moto_slides <- function(
    doc_o,
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    add_slide("07_Motto", master = "Roche Evolved Brand") %>%
    move_slide(to = to_page)

  postprocessing_doc(doc, save_file, doc_o, type = "moto")
}


#' Append FAIR Data Analysis Slide
#'
#' Inserts a slide summarizing data location, script repository, and contributors.
#'
#' @param doc_o PowerPoint file path.
#' @param data_path Path to SDTM data location.
#' @param gitlab_repo Path to GitLab repo for analysis scripts.
#' @param contributor_list Comma-separated list of contributors.
#' @param to_page Page number to insert slide.
#' @param doc_original Optional preloaded `rpptx` object.
#' @param save_file Whether to save the file.
#'
#' @return PowerPoint object with FAIR slide.
#'
#' @export
#'
#' @examples
#' append_fair_slides("slides.pptx", data_path = "/ocean/data", gitlab_repo = "myrepo", contributor_list = "Joe, Ana")
append_fair_slides <- function(
    doc_o,
    data_path = "random data path, change me",
    gitlab_repo = "autoslider repo, change me",
    contributor_list = "Joe Zhu, change me",
    to_page = NA,
    doc_original = NULL,
    save_file = FALSE) {
  doc_original <- initialize_doc_original(doc_original, doc_o)
  to_page <- initialize_to_page(doc_original, to_page)

  doc <- doc_original %>%
    add_slide("08_TitleAndContent", master = "Roche Evolved Brand") %>%
    ph_with(
      value = paste0("F.A.I.R Data Analysis"),
      location = ph_location_label("Title 1")
    ) %>%
    ph_with(
      value = c(
        paste0("Data located on OCEAN: SDTMv files path: ", data_path),
        paste0("Analysis programs located on: Insert link here", gitlab_repo),
        paste0("Contributors", contributor_list)
      ),
      location = ph_location_label("Content Placeholder 2")
    ) %>%
    ph_with(
      value = "Findable, Accessible, Interoperable, Resuable",
      location = ph_location_label("Footer Placeholder 4")
    ) %>%
    move_slide(to = to_page)

  postprocessing_doc(doc, save_file, doc_o, type = "fair")
}
