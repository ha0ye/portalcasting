% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.R
\name{clear_tmp}
\alias{clear_tmp}
\title{Remove files from the tmp subdirectory}
\usage{
clear_tmp(main = ".", quiet = FALSE, verbose = FALSE,
  cleanup = TRUE, arg_checks = TRUE)
}
\arguments{
\item{main}{\code{character} value of the name of the main component of
the directory tree.}

\item{quiet}{\code{logical} indicator if progress messages should be
quieted.}

\item{verbose}{\code{logical} indicator of whether or not to print out
all of the information or just tidy messages.}

\item{cleanup}{\code{logical} indicator if any files put into the tmp
subdirectory should be removed at the end of the process.}

\item{arg_checks}{\code{logical} value of if the arguments should be
checked using standard protocols via \code{\link{check_args}}. The 
default (\code{arg_checks = TRUE}) ensures that all inputs are 
formatted correctly and provides directed error messages if not. \cr
However, in sandboxing, it is often desirable to be able to deviate from 
strict argument expectations. Setting \code{arg_checks = FALSE} triggers
many/most/all enclosed functions to not check any arguments using 
\code{\link{check_args}}, and as such, \emph{caveat emptor}.}
}
\value{
\code{NULL}, with the tmp subdirectory's files removed.
}
\description{
Clear the files from the tmp subdirectory.
}
\examples{
 \donttest{
  create_dir()
  clear_tmp
 }

}
