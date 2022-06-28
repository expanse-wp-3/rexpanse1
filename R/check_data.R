check_data <- function(data) {
  missing_expo_names <- expo_names[!exposure_names_clean %in% colnames(data)]

  complete_cases_rows <- nrow(stats::complete.cases(data[exposure_names_clean]))
  if (complete_cases_rows != nrow(data)) {
    stop("Exposure variables must not contain missing values.")
  }

  cli::cli_alert_success("Your data passed all tests.")
}
