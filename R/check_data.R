##' Checks if the data is appropriate for subsequent analysis.
##'
##' Checks for missing variables, missing values in exposure variables, ...
##' @title Check the data is ready to be analyzed
##' @param data Data frame to be passed to run_pca() `data` argument.
##' @return NULL
##' @author Sergio Olmos
##' @export
##' @examples
##' library(dplyr)
##
##' data(expanse)
##' check_data(expanse)
##'
##' expanse_invalid_column <- expanse %>%
##'   rename(no2_2010_annual = no2)
##' try(check_data(expanse_invalid_column))
##'
##' expanse_missing <- expanse %>%
##'   mutate(ndvi = ifelse(ndvi < 1, NA, ndvi))
##' try(check_data(expanse_missing))
check_data <- function(data) {

  missing_expo_names_idx <- !exposure_names_clean %in% colnames(data)

  missing_expo_names <- exposure_names_clean[missing_expo_names_idx]

  if (length(missing_expo_names) > 0) {
    stop(
      "Some exposure variables not found. They should have names:\n",
      paste("-", exposure_names_clean, "\n")
    )
  }

  complete_cases <- sum(!stats::complete.cases(data[exposure_names_clean]))
  if (complete_cases > 0) {
    stop("Exposure variables must not contain missing values.")
  }
  
}
