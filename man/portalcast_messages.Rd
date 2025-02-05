% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/messaging.R
\name{portalcast_messages}
\alias{portalcast_messages}
\alias{portalcast_welcome}
\alias{portalcast_goodbye}
\alias{sandbox_welcome}
\title{Directory welcome and model completion messages}
\usage{
portalcast_welcome(quiet = FALSE, arg_checks = TRUE)

portalcast_goodbye(quiet = FALSE, arg_checks = TRUE)

sandbox_welcome(main = ".", quiet = FALSE, arg_checks = TRUE)
}
\arguments{
\item{quiet}{\code{logical} indicator if message should be quieted.}

\item{arg_checks}{\code{logical} value of if the arguments should be
checked using standard protocols via \code{\link{check_args}}. The 
default (\code{arg_checks = TRUE}) ensures that all inputs are 
formatted correctly and provides directed error messages if not.}

\item{main}{\code{character} value of the name of the main component of
the directory tree.}
}
\value{
\code{NULL}, as message is printed.
}
\description{
Messaging functions for top-level message output.
 \code{portalcast_welcome} creates a welcome message for the directory 
  based on the package version and directory type. \cr \cr
 \code{portalcast_goodbye} creates a goodbye message for when models are 
  done. \cr \cr
 \code{sandbox_welcome} creates a welcome message for sandbox users,
  displayed upon completion of \code{\link{setup_sandbox}}. \cr \cr
}
\examples{
 portalcast_welcome()
 portalcast_goodbye()
 sandbox_welcome()

}
