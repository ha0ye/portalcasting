% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download.R
\name{name_from_url}
\alias{name_from_url}
\title{Attempt to extract the record name from a URL}
\usage{
name_from_url(url, NULLname = FALSE, sep_char = ".",
  arg_checks = TRUE)
}
\arguments{
\item{url}{\code{character} value of the URL.}

\item{NULLname}{\code{logical} indicator of if the name should be kept as
\code{NULL}, rather than given a name based on the URL.}

\item{sep_char}{\code{character} value of the separator that delineates
the extension from the file path. Generally, this will be \code{"."},
but for some API URLs, the extension is actually a query component,
so the separator may sometimes need to be \code{"="}.}

\item{arg_checks}{\code{logical} value of if the arguments should be
checked using standard protocols via \code{\link{check_args}}. The 
default (\code{arg_checks = TRUE}) ensures that all inputs are 
formatted correctly and provides directed error messages if not.}
}
\value{
\code{character} value of the name or \code{NULL}.
}
\description{
The record name is often encoded in a URL, so in the case that
 a name is not given for the record, this function attempts to extract it,
 unless told to keep the name as NULL (via \code{NULLname}).
}
\examples{
 \donttest{
  source_url <- zenodo_url(concept_rec_id = "1215988")
  name_from_url(source_url)
 }

}
