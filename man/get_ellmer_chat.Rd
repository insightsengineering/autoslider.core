% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ai.R
\name{get_ellmer_chat}
\alias{get_ellmer_chat}
\title{Get an `ellmer` chat API with given platform}
\usage{
get_ellmer_chat(
  platform = "deepseek",
  base_url = "https://api.deepseek.com",
  api_key = get_deepseek_key(),
  model = "deepseek-chat"
)
}
\arguments{
\item{platform}{Platform provider}

\item{base_url}{Base url}

\item{api_key}{API key}

\item{model}{Model of choice}
}
\description{
Get an `ellmer` chat API with given platform
}
