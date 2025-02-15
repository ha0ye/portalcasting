% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/figures.R
\name{plot_casts_err_lead}
\alias{plot_casts_err_lead}
\title{Plot the forecast error as a function of lead time}
\usage{
plot_casts_err_lead(main = ".", cast_ids = NULL, cast_tab = NULL,
  end_moons = NULL, models = NULL, ensemble = TRUE,
  data_set = "controls", include_interp = TRUE, species = NULL,
  arg_checks = TRUE)
}
\arguments{
\item{main}{\code{character} value of the name of the main component of
the directory tree.}

\item{cast_ids}{\code{integer} (or integer \code{numeric}) values 
representing the casts of interest for restricting plotting, as indexed
within the directory in the \code{casts} sub folder. 
See the casts metadata file (\code{casts_metadata.csv}) for summary
information.}

\item{cast_tab}{Optional \code{data.frame} of cast table outputs. If not
input, will be loaded.}

\item{end_moons}{\code{integer} (or integer \code{numeric}) 
newmoon numbers of the forecast origin. Default value is 
\code{NULL}, which equates to no selection with respect to 
\code{end_moon}.}

\item{models}{\code{character} value(s) of the name of the model to 
include. Default value is \code{NULL}, which equates to no selection with 
respect to \code{model}. \code{NULL} translates to all \code{models}
in the table.}

\item{ensemble}{\code{logical} indicator of if an ensemble should be
included. Presently only the unweighted average. See 
\code{\link{ensemble_casts}}.}

\item{data_set}{\code{character} value of the rodent data set to include
Default value is \code{NULL}, which equates to no selection with 
respect to \code{data_set}.}

\item{include_interp}{\code{logical} indicator of if the models fit using
interpolated data should be included with the models that did not.}

\item{species}{\code{character} vector of the species code(s) 
or \code{"total"} for the total across species) to be plotted 
\code{NULL} translates to the species defined by  
\code{evalplot_species}.}

\item{arg_checks}{\code{logical} value of if the arguments should be
checked using standard protocols via \code{\link{check_args}}. The 
default (\code{arg_checks = TRUE}) ensures that all inputs are 
formatted correctly and provides directed error messages if not.}
}
\value{
\code{NULL}. Plot is generated.
}
\description{
Plot the raw error (estimate - observation) as a function
 of lead time across model runs from different forecast origins 
 (\code{end_moons}) for multiple models and multiple species (or total) 
 within a data set.
}
\details{
A pre-loaded table of casts can be input, but if not (default), 
 the table will be efficiently (as defined by the inputs) loaded and 
 trimmed. \cr 
 The casts can be trimmed specifically using the \code{cast_ids} input,
 otherwise, all relevant casts will be plotted.
}
\examples{
 \donttest{
  setup_dir()
  portalcast(models = "AutoArima", end_moons = 515:520)
  plot_casts_err_lead()
}

}
