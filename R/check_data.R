check_data <- function(data) {
  missing_expo_names_idx <- !exposure_names_clean %in% colnames(data)
  missing_expo_names <- exposure_names_clean[missing_expo_names_idx]
  if (length(missing_expo_names) > 0) {
    stop(
      "Some exposure variables not found. They should have names: ",
      exposure_names_clean
    )
  }

  complete_cases <- sum(!stats::complete.cases(data[exposure_names_clean]))
  if (complete_cases > 0) {
    stop("Exposure variables must not contain missing values.")
  }

  cli::cli_alert_success("Your data passed all tests. Producing results...")
}
