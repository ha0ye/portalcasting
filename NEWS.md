# portalcasting (development version)

Version numbers follow [Semantic Versioning](https://semver.org/).


# [portalcasting 0.11.0](https://github.com/weecology/portalcasting/releases/tag/v0.11.0)
*2019-09-14*

### Ensembling reintroduced
* Associated with the reconfiguration of portalcasting from v0.8.1 to 0.9.0, ensembling was removed temporarily.
* A basic ensemble is reintroduced, now as an unweighted average across all selected models, allowing us to have an ensemble but not have it be tied to AIC weighting (because AIC weighting is no longer possible with the split between interpolated and non-interpolated data for model fitting).
* In a major departure from v0.8.1 and earlier, the ensemble's output is not saved like the actual models'. Rather, it is only calculated when needed on the fly.
* In plotting, it is now the default to use the ensemble for `plot_cast_ts` and `plot_cast_point` and for the ensemble to be included in `plot_casts_err_lead` and `plot_casts_cov_RMSE`.

### Return of `most_abundant_species`
* Function used to select the most common species.
* Now uses the actual data and not the casts to determine the species.

# [portalcasting 0.10.0](https://github.com/weecology/portalcasting/releases/tag/v0.10.0)
*2019-09-13*

### Model evaluation and ensembling added back in
* Were removed with the updated version from 0.8.1 to 0.9.0 to allow time to develop the code with the new infrastructure. 
* Model evaluation happens within the cast tab output as before.

### Temporarily removed figures returned
* Associated with the evaluation.
* Plotting of error as a function of lead time for multiple species and multiple models. Now has a fall-back arrangement that works for a single species-model combination.
* Plotting RMSE and coverage within species-model combinations.

### Flexing model controls to allow user-defined lists for prefab models
* For sandboxing with existing models, it is useful to be able to change a parameter in the model's controls, such as the data sets. Previously, that would require a lot of hacking around. Now, it's as simple as inputting the desired controls and flipping `arg_checks = FALSE`. 

# [portalcasting 0.9.0](https://github.com/weecology/portalcasting/releases/tag/v0.9.0)
*2019-09-06*

### Major API update: increase in explicit top-level arguments
* Moved key arguments to focal top-level inputs, rather than nested within control options list. Allows full control, but with default settings working cleanly. [addresses](https://github.com/weecology/portalcasting/issues/123)
* Restructuring of the controls lists, retained usage in situations where necessary: model construction, data set construction, file naming, climate data downloading.
* Openness for new `setup` functions, in particular `setup_sandbox`. [addresses](https://github.com/weecology/portalcasting/issues/125)
* Simplification of model naming inputs. Just put the names in you need, only use the `model_names` functions when you need to (usually in coding inside of functions or for setting default argument levels). [addresses](https://github.com/weecology/portalcasting/issues/119)

###  Directory tree structure simplified
* `dirtree` was removed
* `base` (both as a function and a concept) was removed. To make that structure use `main = "./name"`.
* "PortalData" has been removed as a sub and replaced with "raw", which includes all raw versions of files (post unzipping) downloaded: Portal Data and Portal Predictions and covariate forecasts (whose saving is also new here).

### Tightened messaging
* Expanded use of `quiet` and `verbose` connected throughout the pipeline.
* Additional messaging functions to reduce code clutter.
* Formatting of messages to reduce clutter and highlight the outline structure.

### Download capacity generalized
* Flexible interface to downloading capacity through a url, with generalized and flexible functions for generating Zenodo API urls (for retrieving the raw data and historical predictions) and NMME API urls (for retrieving weather forecasts) to port into the `download` function. [addresses](https://github.com/weecology/portalcasting/issues/121) and [addresses](https://github.com/weecology/portalcasting/issues/107) and [addresses](https://github.com/weecology/portalcasting/issues/53)

### Changes for users adding their own models to the prefab set
* Substantial reduction in effort for users who wish to add models (i.e. anyone who is sandboxing). You can even just plunk your own R script (which could be a single line calling out to an external program if desired) without having to add any model script writing controls, and just add the name of the model to the models argument in `portalcast` and it will run it with everything else.
* Outlined in the updated [Getting Started](https://weecology.github.io/portalcasting/articles/howto.html) and [Adding a Model/Data](https://weecology.github.io/portalcasting/articles/adding_a_model_or_data.html) vignettes.
* Users adding models to the prefab suite should now permanently add their model's control options to the source code in `model_script_controls` rather than write their own control functions.
* Users adding models to the prefab suite should permanently add their model's function code to the `prefab_models` script (reusing and adding to the documentation in `prefab_model_functions`), rather than to its own script. 
* Users should still add their model's name to the source code in `model_names`.

### Relaxed model requirements
* Models are no longer forced to use interpolated data.
* Models are no longer required to output a rigidly formatted data-table. Presently, the requirement is just a list, but soon some specifications will be added to improve reliability.
* Outlined in the updated [Adding a Model/Data](https://weecology.github.io/portalcasting/articles/adding_a_model_or_data.html) vignette. 

### More organization via metadata
* Generalized cast output is now tracked using a unique id in the file name associated with the cast, which is related to a row in a metadata table, newly included here. [addresses](https://github.com/weecology/portalcasting/issues/105) and [addresses](https://github.com/weecology/portalcasting/issues/106) and [addresses](https://github.com/weecology/portalPredictions/issues/316)
* Additional control information (like data set setup) is sent to the model metadata and saved out.
* Directory setting up configuration information is now tracked in a `dir_config.yaml` file, which is pulled from to save information about what was used to create, setup, and run the particular casts.

### Changes for users interested in analyzing their own data sets not in the standard data set configuration
* Users are now able to define rodent observation data sets that are not part of the standard data set ("all" and "controls", each also with interpolation of missing data) by giving the name in the `data_sets` argument and the controls defining the data set (used by portalr's `summarize_rodent_data` function) in the `controls_rodents` argument. 
* In order to actualize this, a user will need to flip off the argument checking (the default in a sandbox setting, if using a standard or production setting, set `arg_checks = FALSE` in the relevant function).
* Users interested in permanently adding the treatment level to the available data sets should add the source code to the `rodents_controls` function, just like with the models.
* [addresses](https://github.com/weecology/portalcasting/issues/133)
* Internal code points the pipeline to the files named via the data set inputs. The other data files are pointed to using the `control_files` (see `file_controls`) input list, which allows for some general flexibility with respect to what files the pipeline is reading in from the `data` subdirectory.

### Split of standard data sets 
* The prefab `all` and `controls` were both default being interpolated for all models because of the use of AIC for model comparison and ensemble building. That forced all models to use interpolated data.
* Starting in this version, the models are not required to have been fit in the same fashion (due to generalization of comparison and post-processing code), and so interpolation is not required if not needed, and we have split out the data to standard and interpolated versions.

### Application of specific models to specific data sets now facilitated
*  `write_model` and `model_template` have a `data_sets` argument that is used to write the code out, replacing the hard code requirement of analyzing "all" and "controls" for every model. Now, users who wish to analyze a particular data component can easily add it to the analysis pipeline. 

### Generalization of code terms
* Throughout the codebase, terminology has been generalized from "fcast"/"forecast"/"hindcast" to "cast" except where a clear distinction is needed (here primarily due to where the covariate values used come from).
* Nice benefits: highlights commonality between the two (see next section) and reduces code volume.
* `start_newmoon` is now `start_moon` like `end_moon`
* [addresses](https://github.com/weecology/portalcasting/issues/134)

### "Hindcasting" becomes more similar to "forecasting"
* In the codebase now, "hindcasting" is functionally "forecasting" with a forecast origin (`end_moon`) that is not the most recently occurring moon.
* Indeed, "hindcast" is nearly entirely removed from the codebase and "forecast" is nearly exclusively retained in documentation (and barely in the code itself), with both functionally being replaced with the generalized (and shorter) "cast". 
* `cast_type` is retained in the metadata file for posterity, but functionality is more generally checked by considering `end_moon` and `last_moon` in combination, where `end_moon` is the forecast origin and `last_moon` is the most recent 
* Rather than the complex machinery used to iterate through multiple forecasts ("hindcasting") that involved working backwards and skipping certain moons (which didn't need to be skipped anymore due to updated code from a while back that allows us to forecast fine even without the most recent samples yet), a simple for loop is able to manage iterating. This is also facilitated by the downloading of the raw portalPredictions repository from Zenodo and critically its retention in the "raw" subdirectory, which allows quick re-calculation of historic predictions of covariates. [addresses](https://github.com/weecology/portalcasting/issues/11)
* `cast_type` has been removed as an input, it's auto determined now based on `end_moon` and the last moon available (if they're equal it's a "forecast", if not it's a "hindcast").

### Softer handling of model failure
* Within `cast`, the model scripts are now sourced within a for-loop (rather than sapply) to allow for simple error catching of each script. [addresses](https://github.com/weecology/portalcasting/issues/22)

### Improved argument checking flow
* Arg checking is now considerably tighter, code-wise. 
* Each argument is either recognized and given a set of attributes (from an internally defined list) or unrecognized and stated to the user that it's not being checked (to help notify anyone building in the code that there's a new argument).
* The argument's attributes define the logical checking flow through a series of pretty simple options. 
* There is also now a `arg_checks` logical argument that goes into `check_args` to turn off all of the underlying code, enabling the user to go off the production restrictions that would otherwise through errors, even though they might technically work under the hood.

### Substantial re-writes of the vignettes
* Done in general to update with the present version of the codebase.
* Broke the `adding a model or data` vignette into "working locally" and "adding to the pipeline", also added checklists and screen shots. [addresses](https://github.com/weecology/portalcasting/issues/113)
* Reorganized the `getting started` vignette to an order that makes sense. [addresses](https://github.com/weecology/portalcasting/issues/120)

### Additional things
* `drop_spp` is now changed to `species` (so focus on inclusion, not exclusion). [addresses](https://github.com/weecology/portalcasting/issues/128)
* Improved examples, also now as `\donttest{}`. [addresses](https://github.com/weecology/portalcasting/issues/127)
* Tightened testing with `skip_on_cran` used judiciously. [addresses](https://github.com/weecology/portalcasting/issues/124)
* No longer building the AIC-based ensemble. [addresses](https://github.com/weecology/portalcasting/issues/102)
* Default confidence limit is now the more standard 0.95.

# [portalcasting 0.8.1](https://github.com/weecology/portalcasting/releases/tag/v0.8.1)
*2019-07-11*

### Hookup with Zenodo
Inclusion of json file and some minor editing of documentation, but no functional coding changes

# [portalcasting 0.8.0](https://github.com/weecology/portalcasting/releases/tag/v0.8.0)
*2019-03-21*

### `plot_cov_RMSE_mod_spp` now only plots the most recent -cast by default
* If `cast_dates = NULL` (the default), the plot only uses the most recent -cast
to avoid swamping more current -casts with historic -casts.

### Added specific checks for no casts returned in plot functions
* There's a bit of leeway with respect to argument validity, in particular around
model names (to facilitate users making new models with new names, we don't want
to hardwire a naming scheme in `check_arg`), so now there are checks to see if 
the tables returned from `select_casts` have any rows or not.

### Handling the edge cases in model function testing
* The trimming of the data sets for model function testing (happens in the AutoArima
test script) now includes addition of some dummy values for edge cases (all 0 
observations and nearly-all-0 observations), which allows better coverage of testing
for the -GARCH model functions in particular.

### Fixing a typo bug within `pevGARCH`
* There was a mismatch between `fcast` and `forecast` for one of the edge cases.

# [portalcasting 0.7.0](https://github.com/weecology/portalcasting/releases/tag/v0.7.0)
*2019-03-21*

### Addressing `nbGARCH` and `nbsGARCH` when even the Poisson fallback fails
* In `nbGARCH` and then extended into `nbsGARCH`, the models fall back
to a Poisson distribution if the negative binomial fit fails. Previously
(with only `nbGARCH`) the Poisson fit always succeeded in those back-ups,
but now (with `nbsGARCH`) that sometimes isn't the case (because the predictor
model is more complex) and even the Poisson fit can fail. So now for both 
models, if that fit fails, we follow what occurs in `pevGARCH` which is to
use the `fcast0` forecast of 0s and an arbitrarily high AIC (`1e6`).

# [portalcasting 0.6.0](https://github.com/weecology/portalcasting/releases/tag/v0.6.0)
*2019-03-20*

### Addressing covariate forecasts in `pevGARCH` under hindcasting
* `pevGARCH()` was not set up to leverage the `covariate_forecasts` file.
* It's now set up with a toggle based on the `cast_type` in the metadata list 
(which has replaced the formerly named `filename_suffix` element) to load
the `covariate_forecasts` file (using a new `read_covariate_forecasts` function)
and then select the specific hindcast based on the `source` and `date_made` columns
as selected by new elements in the metadata list (`covariate_source` and
`covariate_date_made`).

# [portalcasting 0.5.0](https://github.com/weecology/portalcasting/releases/tag/v0.5.0)
*2019-03-19* 

### Adding nbsGARCH
* Model `nbsGARCH` has been added to the base set of models.

### `foy` function
* `foy()` calculates the fraction of the year for a given date or set
of dates.

# [portalcasting 0.4.1](https://github.com/weecology/portalcasting/releases/tag/v0.4.1)
*2019-03-19*

### Move to usage of CRAN *portalr*
* To aid with stability, we're now using the [CRAN release of portalr](https://cran.r-project.org/package=portalr)

### `model_scripts` function
* Provides a simple way to list the scripts in the `models` subdirectory.

### Including the package version message in `setup_dir` and `portalcast`
* Including a simple message to report the version of portalcasting 
loaded in top level functions.

### Vignette updates
* Adding plot (from pre-constructed images) to the how-to vignette.

### Patching a bug in `model_template`
* There was a lingering old name from the argument switch over that was
causing model templates to be written with a `""` argument for the `model`
model name input into `save_forecast_output`.

# [portalcasting 0.4.0](https://github.com/weecology/portalcasting/releases/tag/v0.4.0)
*2019-03-16* 

### Tidied functionality for checking function arguments
* Introduction of `check_args` and `check_arg` which collaborate to
check the validity of function arguments using a standardized set
of requirements based on the argument names, thereby helping to unify
and standardize the use of the codebase's arguments.

### Updated function names
* `prep_rodents` is now  `prep_rodents_list`
* `rodents_data` is now `prep_rodents`
* `update_rodents` is now `update_rodents_list`
* `read_data` has been split out into `read_all`, `read_controls`,
`read_covariates`, `read_moons`, and `read_metadata`
* `model_path` is now `model_paths`
* `sub_path` and `sub_paths` have been merged into `sub_paths`, which 
returns all if `specific_subs` is NULL
* `lag_data` is now `lag_covariates`

### Updated argument (names to leverage `check_args`, etc.)
* In multiple functions `data` has been replaced with `rodents` to be
specific.
* `CI_level` is now subsumed by `confidence_level`
* `name` is now subsumed by `model`
* `set` is not split into `species_set` and `model_set`
* The order of arguments in `model_names` is now back to `model_set`, 
`add`.
* The default `subs_type` for `subdirs` is now `"portalcasting"`.
* The four model functions have a reduced set of inputs to leverage the 
directory tree, and the script generation is updated to match.
* Updating the `cast` argument to `cast_to_check` in `cast_is_valid` and 
removing the `verbose` argument from `verify_cast` to allow `check_arg` to 
leverage `check_arg` for `verify_cast`.

### Removal of classes
* The `models` class has been removed.
* The `subdirs` class has been removed.

### `messageq` function
* `messageq` function is added to tidy code around messages being printed
based on the `quiet` arguments.

### Inclusion of `"wEnsemble"` as an option in `model_names`
* Produces the `prefab` list with an `"Ensemble"` entry added, to allow for
that simply without using the `NULL` options, which collects all model names.
* This facilitated addition of `models` as an argument in the evaluations 
plots.

# [portalcasting 0.3.1](https://github.com/weecology/portalcasting/pull/93)
*2019-03-12* 

### Bug fix in `plot_cast_ts()`
* `plot_cast_ts` did not cleanly plot time series where observations had 
been made after the start of the prediction window.
* The function has been set up to now split observations that occurred
during the prediction window out, execute the plot as if they didn't 
exist, then add them on top. 
* Functionality has now been added to allow the toggling on and off of
those points via the `add_obs` input (defaults to `TRUE`).

# [portalcasting 0.3.0](https://github.com/weecology/portalcasting/releases/tag/v0.3.0)
*2019-03-04*

### Completed migration of plotting code
* `plot_cast` is now `plot_cast_ts` and is now fully vetted and tested
* `plotcastts_ylab` and `plotcastts_xaxis` provide tidied functions for
producing the y label and x axis (respectively) for `plot_cast_ts`.
* `plot_cast_point` is now added to replace `plot_species_forecast`.
* `plotcastpoint_yaxis` provides tidied functionality for the y axis of 
`plot_cast_point`.
* `select_most_ab_spp` allows for a simple selection of the most abundant
species from a -cast.
* `plot_err_lead_spp_mods` and `plot_cov_RMSE_mod_spp` now added to 
replace the raw code in the evaluation page.

### Processing of forecasts
* `read_casts` (old) is now `read_cast` and specifically works for only one -cast.
* `read_casts` (new) reads in multiple -casts.
* `select_cast` is now `select_casts` and allows a more flexible selection
by default.
* `make_ensemble` now returns a set of predictions with non-`NA` bounds when 
only one model is included (it returns that model as the ensemble).
* `most_recent_cast` returns the date of the most recent -cast. Can be dependent
on the presence of a census.
* `verify_cast` and `cast_is_valid` replace `forecast_is_valid` from the 
repo codebase. `verify_cast` is a logical wrapper on `cast_is_valid` that 
facilitates a pipeline integration. `cast_is_valid` does the major set of
checks of the cast data frame.  
* `append_observed_to_cast` is provided to add the observed data to the forecasts
and add columns for the raw error, in-forecast-window, and lead time as well.
* `measure_cast_error` allows for summarization of errors at the -cast level.

### Processing of data
* `most_recent_census` returns the date of the most recent census.

### Minor changes
* Argument order in `models` is reversed (`add` then `set`) and defaults in general
are now `NULL` and `NULL`, but `set = "prefab"` within the options functions, to
make it easy to run a novel model set.
* Argument order in `subdirs` is reversed (`subs` then `type`) and defaults in 
general are now `NULL` and `NULL`, but `type = "portalcasting"` within options
functions and `dirtree` to make it easier to manage a single subdirectory.
* `fdate` argument has been replaced throughout with `cast_date` for generality.

### Utilities
* `na_conformer` provides tidy functionality for converting non-character `NA` 
entries (can get read in from the data due to the `"NA"` species) to `"NA"`. 
Works for both vectors and data frames.

# [portalcasting 0.2.2](https://github.com/weecology/portalcasting/pull/82)
*2019-02-12* 

### Beginning to migrate plotting code
* `plot_cast` is developed but not yet fully vetted and tested, nor integrated
in the main repository. It will replace `forecast_viz` as a main plotting
function.

### Added `"moons"` to `read_data`
* `read_data`'s options have been expanded to include `"moons"`.
* Not fully implemented everywhere, but now available.

### Bug fix in `interpolate_data`
* `interpolate_data` was using `rodent_spp` in a way that assumed the `"NA"` 
species was coded as `"NA."`, which it wasn't. 
* Expansion of `rodent_spp` to include an `nadot` logical argument, with default
value of `FALSE`.

# [portalcasting 0.2.1](https://github.com/weecology/portalcasting/pull/81)
*2019-02-12* 

### Bug fix in `read_data`
* `read_data` was reading the All rodents file for Controls as well, which caused
the forecasts for the Controls to be duplicated of the All forecasts.
* Simple correction here.

# [portalcasting 0.2.0](https://github.com/weecology/portalcasting/pull/79)
*2019-02-04* 

### Code testing
* All of the code is now tested via [`testthat`](https://github.com/weecology/portalcasting/tree/master/tests).
* Test coverage is tracked via [Codecov](https://codecov.io/gh/weecology/portalcasting).
* The only functionality not covered in testing on Codecov is associated with
`download_predictions()`, which intermittently hangs on Travis. Testing is
available, but requires manual toggling of the `test_location` value to
`"local"` in the relevant test scripts (02-directory and 12-prepare_predictions).

### Enforcement of inputs
* Most of the functions previously did not have any checks on input argument 
classes, sizes, etc.
* Now all functions specifically check each argument's value for validity
and throw specific errors.

### Documentation
* All of the functions have fleshed out documentation that specify argument
requirements, link to each other and externally, and include more information.

### Data classes
* To smooth checking of different data structures, we now define data
objects with classes in addition to their existing (`data.frame` or
`list`) definitions.
* `rodents`, `rodents_list`, `covariates`, `metadata`, `moons`
* These classes do not presently have any specified methods or functions.

### Options list classes 
* To smooth checking of different list structures, we now define the options
list objects with classes in addition to their existing `list` definitions.
* `all_options`, `dir_options`, `PortalData_options`, `data_options`, 
`moons_options`, `rodents_options`, `covariates_options`, `metadata_options`,
`predictions_options`, `models_options`, and `cast_options`
* Each of these classes is created by a function of that name.
* These classes do not presently have any specified methods or functions 
that operate on them.

### Added functions
* `classy()` allows for easy application of classes to objects in a `%>%` pipeline
* `read_data()` provides simple interface for loading and applying classes to
model-ready data files.
* `remove_incompletes()` removes any incomplete entries in a table, as defined
by an `NA` in a specific column.
* `check_options_args()` provides a tidy way to check the input arguments (wrt
class, length, numeric limitations, etc.) to the options functions.

### Vignettes
* Three vignettes were added:
  * [current models vignette](https://weecology.github.io/portalcasting/articles/models.html) was brought from the [forecasting website](https://portal.naturecast.org/models.html).
  * [codebase vignette](https://weecology.github.io/portalcasting/articles/codebase.html) was created from the earlier `README.md` file.
  * [adding a model vignette](https://weecology.github.io/portalcasting/articles/adding_a_model.html) was constructed based on two pages from the 
    [Portal Predictions repository](https://github.com/weecology/portalPredictions) wiki
    ([1](https://github.com/weecology/portalPredictions/wiki/Adding-a-new-model) and 
    [2](https://github.com/weecology/portalPredictions/wiki/Forecast-file-format)) and with substantial additional text added.

### Retention of all forecasts of covariates
* Previous versions retained only one covariate forecast per newmoon.
* We now enable retention of multiple covariate forecasts per newmoon and tag 
the forecast date with a time stamp as well.

### Website
* Added a website driven by [pkgdown](https://pkgdown.r-lib.org/).

### Changelog
* Developed this changelog as part of the package.

### Support documents
* Added [code of conduct](https://github.com/weecology/portalcasting/blob/master/CODE_OF_CONDUCT.md) 
and [contribution guidelines](https://github.com/weecology/portalcasting/blob/master/CONTRIBUTING.md)
to the repository.

# [portalcasting 0.1.1](https://github.com/weecology/portalcasting/commit/05ed76f76a82f32a5a3120eb7c9ef0dc95bd8ae4)
*2019-01-13*

### Addressing Portal Data download
* Setting default back to the Zenodo link via updated portalr function.
* Updated `fill_PortalData()` and new `PortalData_options()` allow 
for control over download source.

# [portalcasting 0.1.0](https://github.com/weecology/portalcasting/tree/77fb0c8a32de5ff39715e652ce8e5b813ad02ff3) 
*true code edits 2018-12-14, version number updated 2019-01-02*

### Migration from Portal Predictions repository
* Code was brought over from the forecasting repository to be housed in its 
own package.
* Multiple updates to the codebase were included, but intentionally just
"under the hood", meaning little or no change to the output and simplification
of the input.
* A major motivation here was also to facilitate model development, which 
requires being able to set up a local version of the repository to play with
in what we might consider a ["sandbox"](https://en.wikipedia.org/wiki/Sandbox_(software_development)).
This will allow someone to develop and test new forecasting models in a space
that isn't the forecasting repo itself (or a clone or a fork), but a truly novel
location. At this point, the sandbox setup isn't fully robust from within this 
package, but rather requires some additional steps (to be documented).

### Development of code pipeline
* The previous implementation of the R codebase driving the forecasting 
(housed within the [portalPredictions](https://github.com/weecology/portalPredictions/tree/ac032f3938a6695a8e5d27ee380032195b2af396)
repo) was a mix of functions and loose code and hard-coded to the repo.
* The package implementation generalizes the functionality and organizes
the code into a set of hierarchical functions that drive creation and use
of the code within the repo or elsewhere. 
* See the [codebase vignette](https://weecology.github.io/portalcasting/articles/codebase.html) for further details.

### Explicit directory tree
* To facilitate portability of the package (a necessity for smooth sandboxing
and the development of new models), we now include explicit, controllable
definition of the forecasting directory tree.
* See the [codebase vignette](https://weecology.github.io/portalcasting/articles/codebase.html) for further details.

### Introduction of options lists
* To facilitate simple control via defaults argument inputs and flexibility to 
changes to inputs throughout the code hierarchy, we include a set of functions
that default options for all aspects of the codebase.
* See the [codebase vignette](https://weecology.github.io/portalcasting/articles/codebase.html) for further details.

# [pre-portalcasting](https://github.com/weecology/portalPredictions/tree/ac032f3938a6695a8e5d27ee380032195b2af396) 
*2018-11-06*

* This is the last iteration of the code that now exists in portalcasting in
its previous home within the portalPredictions repo. 
* It was not referred to by the name portalcasting at the time.
