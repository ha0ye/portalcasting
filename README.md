# Supporting [automated iterative forecasting](https://github.com/weecology/portalPredictions) of [Portal rodent populations](https://portal.weecology.org/)
[![Build Status](https://travis-ci.org/weecology/portalcasting.svg?branch=master)](https://travis-ci.org/weecology/portalcasting)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/weecology/portalPredictions/master/LICENSE)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Codecov test coverage](https://img.shields.io/codecov/c/github/weecology/portalcasting/master.svg)](https://codecov.io/github/weecology/portalcasting/branch/master)

## Overview

The `portalcasting` package contains the functions used for continuous
analysis and forecasting of [Portal rodent populations](https://portal.weecology.org/) 
([code repository](https://github.com/weecology/portalPredictions),
[output website](http://portal.naturecast.org/),
[Zenodo archive](https://zenodo.org/record/2543733)).

## Status: Deployed, In Development

This package is currently ***in development*** by the 
[Weecology Team](https://www.weecology.org). Most of the code underlying the 
forecasting functionality has been migrated over from the [predictions
repository](https://github.com/weecology/portalPredictions),
which contains the code executed by the continuous integration.
Output (website) generation functionality is still housed there, however.
Coincidingly, the `portalcasting` package is deployed for use within the 
[repository](https://github.com/weecology/portalPredictions).

Note that the current master branch code is not necessarily always being
executed within the [predictions 
repository](https://github.com/weecology/portalPredictions). This is a 
desired result of our use of a [software
container](https://en.wikipedia.org/wiki/Operating-system-level_virtualization),
which enables reproducibility. 
Presently, we use a [Docker](https://www.docker.com/) image of the 
software environment ro create a container for the code and house it on
[DockerHub](https://hub.docker.com/r/weecology/portal_predictions). The
image update (*i.e.* the integration of the current master branch of 
`portalcasting` into the [predictions 
repository](https://github.com/weecology/portalPredictions)) necessarily
lags behind updates to the master branch of `portalcasting`, although
ideally not long behind.

The API is moderately well defined at this point, but is evolving and
may change substantially. Output functions have not been brought over from
the [predictions repository](https://github.com/weecology/portalPredictions).


## Installation

You can install the R package from github with:

```
install.packages("devtools")
```
```
devtools::install_github("weecology/portalcasting")
```

If you wish to spin up a local container from the Portal Predictions 
image (to ensure a stable runtime environment for implementation
of the `portalcasting` pipeline), you can run

```
sudo docker pull weecology/portal_predictions
```
from a shell on a computer with [Docker](https://www.docker.com/) installed
(Windows users need not include `sudo`). A tutorial on using the image 
to spin up a container is forthcoming. In the meantime, general usage
should be consistent if the user installs the current version of the
packages listed in the [`install-packages.R` file in the main 
repository](https://github.com/weecology/portalPredictions/blob/master/install-packages.R).


## Usage

The `setup_dir()` function creates and populates a standard portalcasting
directory within the present location (by default) that includes `data`,
`models`, `PortalData`, `predictions` and `tmp` subdirectories. By default,
`setup_dir()` downloads the most up-to-date version of the 
[Portal Data from Zenodo](https://zenodo.org/record/2541170)
into the `PortalData` subdirectory, prepares the moons, rodents, covariates,
and metadata data files (and places them in the `data` subdirectory), copies 
the historic covariate forecast data file available in the package 
(`/inst/extdata/covariate_forecasts.csv`) into the `data` subdirectory, 
downloads the most recent set of model forecasts into the `predictions` 
subdirectory and populates the `models` subdirectory with scripts for the four
existing models ("AutoArima", "ESSS", "nbGARCH", and "pevGARCH").

The `portalcast()` function controls the running of potentially multiple 
models for either a forecast or a hindcast. It will prepare the data 
(rodents, covariates, model metadata) as needed, verify that the requested
models are available to run, run the models, compile the output, and
generate an ensemble (if desired). Presently, the preloaded model set includes
[four models](https://weecology.github.io/portalcasting/articles/models.html):
ESSS, AutoArima, nbGARCH, and pevGARCH. 

The `cleanup_dir()` function simply removes the temporary files and folders
from the directory.

All required inputs to `setup_dir()`, `portalcast()`, and `cleanup_dir()` 
are encompassed within the singular argument `options_all`, which is a 
hierarchical list of options settings, defined through the options-settting 
function `all_options()` and the default values are appropriate for basic 
forecast usage:

```
setup_dir()
```
```
portalcast()
```
```
cleanup_dir()
```

There are many options available for the user to control, and a full list
can be found by running `?all_options`, to return the help file for the 
function that generates the hierarchical options list. 

For further information about the `portalcasting` codebase see the 
[vignette](https://weecology.github.io/portalcasting/articles/codebase.html).

If you are interested in adding a model to the preloaded [set of four
models](https://weecology.github.io/portalcasting/articles/models.html),
see the [Adding a Model
vignette](https://weecology.github.io/portalcasting/articles/adding_a_model.html). 

## Acknowledgements 

The motivating study—the Portal Project—has been funded nearly continuously 
since 1977 by the [National Science Foundation](http://nsf.gov/), most recently
by [DEB-1622425](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1622425) 
to S. K. M. Ernest. Much of the computational work was supported by the 
[Gordon and Betty Moore Foundation’s Data-Driven Discovery 
Initiative](http://www.moore.org/programs/science/data-driven-discovery) 
through [Grant GBMF4563](http://www.moore.org/grants/list/GBMF4563) to E. P. 
White. We thank Henry Senyondo for help with continuous integration, Hao
Ye for feedback on documents and code, Heather Bradley for logistical 
support, John Abatzoglou for assistance with climate forecasts, and James
Brown for establishing the Portal Project.

## Author Contributions

All authors conceived the ideas, designed methodology, and developed the 
automated forecasting system. JLS is leading the transition of code from
the [Portal Predictions repo](https://github.com/weecology/portalPredictions)
to `portalcasting`. 