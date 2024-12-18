% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util.R
\name{s_proportion_1}
\alias{s_proportion_1}
\title{survival proportion afun}
\usage{
s_proportion_1(
  x,
  conf_level = 0.95,
  method = c("waldcc", "wald", "clopper-pearson", "wilson", "agresti-coull", "jeffreys"),
  long = FALSE
)
}
\arguments{
\item{x}{data vector}

\item{conf_level}{confidence level}

\item{method}{type of method for calculation}

\item{long}{flag}
}
\value{
A function suitable for use in rtables::analyze() with element selection,
reformatting, and relabeling performed automatically.
}
\description{
survival proportion afun
}
