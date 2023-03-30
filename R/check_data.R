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

  ################
  # Exposures part 
  ################

  missing_expo_names_idx <- !exposure_names_clean %in% colnames(data)

  missing_expo_names <- exposure_names_clean[missing_expo_names_idx]

  if (length(missing_expo_names) > 0) {
    stop(
      "Some exposure variables not found. They should have names:\n",
      paste("-", exposure_names_clean, "\n")
    )
  }

  ################
  # ses part 
  ################

  missing_ses_names_idx <- !ses_var_clean %in% colnames(data)

  missing_ses_names <- ses_var_clean[missing_ses_names_idx]

  if (length(missing_ses_names) > 0) {
    warning(
      paste(
      "Some SES variables not found. They should have names: - warning, it still working\n",
      paste("-", ses_var_factor_clean, "\n"), sep = "")
    )

  }

  ################
  # ses part 2 - confirm the factor order. 
  ################
  if(sum("ses_cat_indv" %in% missing_ses_names)>= 1) {
    warning("not individual variable - ses_cat_indv")
  } else {
  


  missing_ses_factor_indv_id <- !ses_var_factor_clean %in% unique(data$ses_cat_indv)

  missing_ses_factor_indv_names <- ses_var_factor_clean[missing_ses_factor_indv_id]

  if (length(missing_ses_factor_indv_names) > 0) {
    stop(
      paste(
      "Some SES factor for individual level not found. They should have names:\n",
      paste("-", ses_var_factor_clean, "\n"), sep = "")
    )
  }

    data$ses_cat_indv <- factor(data$ses_cat_indv, levels = ses_var_factor_clean)

}

  
  # Area level 
  if(sum("ses_cat_area" %in% missing_ses_names)>= 1) {
    warning("not area variable - ses_cat_area")
  } else { 

  missing_ses_factor_area_id <- !ses_var_factor_clean %in% unique(data$ses_cat_area)

  missing_ses_factor_area_names <- ses_var_factor_clean[missing_ses_factor_area_id]

  if (length(missing_ses_factor_area_names) > 0) {
    stop(
      paste(
      "Some SES factor for area level not found. They should have names:\n",
      paste("-", ses_var_factor_clean, "\n"), sep = "")
    )
  }

data$ses_cat_area <- factor(data$ses_cat_area, levels = ses_var_factor_clean)

}


  ################
  # complete cases part
  ################  

  complete_cases <- sum(!stats::complete.cases(data[exposure_names_clean]))
  if (complete_cases > 0) {
    stop("Exposure or ses variables must not contain missing values.")
  }
  
}
