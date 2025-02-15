% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepare_rodents.R
\name{rodent_species}
\alias{rodent_species}
\alias{all_species}
\alias{base_species}
\alias{evalplot_species}
\title{Rodent species abbreviations}
\usage{
rodent_species(species = NULL, set = NULL, nadot = FALSE,
  total = FALSE, arg_checks = TRUE)

all_species(species = NULL, nadot = FALSE, total = FALSE,
  arg_checks = TRUE)

base_species(species = NULL, nadot = FALSE, total = FALSE,
  arg_checks = TRUE)

evalplot_species(species = NULL, nadot = FALSE, total = TRUE,
  arg_checks = TRUE)
}
\arguments{
\item{species}{\code{character}-valued vector of species names to include.}

\item{set}{\code{character} input of a specified set of species. 
Default entry (\code{"base"}) returns the standard set of all species 
included. Other options include \code{"wtotal"} (same as \code{"base"} 
but with "total" as well) and \code{"evalplot"} which only returns a 
subset of common species to be included in the evaluations plots.}

\item{nadot}{\code{logical} indicator if the dot should be added to the 
\code{"NA"} species name. Defaults to \code{FALSE}.}

\item{total}{\code{logical} value indicating if \code{"total"} should be 
added or not.}

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
\code{character} vector of species abbreviations.
}
\description{
Creates a simple \code{character} vector of abbreviations for
  the \href{https://portal.naturecast.org/profiles.html}{Portal Rodents}.
}
\examples{
 rodent_species()
 rodent_species(set = "all")
 rodent_species("BA")
 rodent_species("BA", set = "all")
 all_species()
 all_species(nadot = TRUE)
 all_species(total = TRUE)
 base_species()
 evalplot_species()

}
