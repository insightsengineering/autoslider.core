% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/appendix.R
\name{append_title_slides}
\alias{append_title_slides}
\title{Append Title Slides to a PowerPoint Document}
\usage{
append_title_slides(
  doc_o,
  study_id = "XXXX change me",
  to_page = NA,
  doc_original = NULL,
  save_file = FALSE
)
}
\arguments{
\item{doc_o}{Path to a PowerPoint (`.pptx`) file. Used to initialize the document
if `doc_original` is `NULL`.}

\item{study_id}{A character string that represent your study identifier.}

\item{to_page}{An integer specifying the page number where the new slide should be moved.}

\item{doc_original}{An optional existing `officer::rpptx` object. If `NULL`,
the document is initialized from `doc_o`.}

\item{save_file}{A logical value. If `TRUE`, the modified document is saved to a file
after adding the slide.}
}
\value{
An `officer::rpptx` object with the new title slide appended.
}
\description{
This function adds a new title slide using a "Title and Content" layout
from the "Office Theme".
}
\examples{

tmp <- tempfile(fileext = ".pptx")
doc <- officer::read_pptx()
doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")
print(doc, target = tmp)

doc <- append_title_slides(
  doc_o = tmp,
  study_id = "My Study #13",
  to_page = 1,
  save_file = TRUE
)
}
