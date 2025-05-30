% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t_dor_slide.R
\name{t_dor_slide}
\alias{t_dor_slide}
\title{DOR table}
\usage{
t_dor_slide(adsl, adtte, arm = "TRT01P", refgroup = NULL)
}
\arguments{
\item{adsl}{ADSL dataset}

\item{adtte}{ADTTE dataset}

\item{arm}{Arm variable, character, "`TRT01P" by default.}

\item{refgroup}{Reference group}
}
\value{
An `rtables` object
}
\description{
DOR table
}
\note{
* Default arm variables are set to `"TRT01A"` for safety output, and
 `"TRT01P"` for efficacy output
}
\examples{
library(dplyr)
adsl <- eg_adsl \%>\%
  dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
adtte <- eg_adtte \%>\%
  dplyr::filter(PARAMCD == "OS") \%>\%
  dplyr::mutate(TRT01P = factor(TRT01P, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
out <- t_dor_slide(adsl, adtte)
print(out)
generate_slides(out, paste0(tempdir(), "/dor.pptx"))
}
