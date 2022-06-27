check_data <- function(data, air_vars, built_vars, temp_vars) {
  expo_names <- c(air_vars, built_vars, temp_vars)
  missing_expo_names <- expo_names[!expo_names %in% colnames(data)]

  complete_cases_rows <- complete.cases(data[expo_names]) %>%
    nrows()
  if (complete_cases_rows != nrow(data)) {
    stop("Exposure variables must not contain missing values.")
  }

  cli::cli_alert_success("Your data passed all tests.")
}
