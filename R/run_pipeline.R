run_pipeline <- function(data,
                         air_vars,
                         built_vars,
                         temp_vars,
                         id_var,
                         other_vars,
                         cohort_name,
                         write = TRUE,
                         output_dir = ".") {
  data_expo <- data[c(air_vars, built_vars, temp_vars)]
  check_data(data_expo)
  expo_quantiles <- get_quantiles(data_expo)
  pca_summary <- get_pca(data_expo, air_vars, built_vars, temp_vars)
  rexpanse1_version <- utils::packageVersion("rexpanse1")

  results <- list(
    cohort = cohort_name,
    quantiles = expo_quantiles,
    pca_summary = pca_summary,
    package_version = paste0("rexpanse-", rexpanse1_version)
  )

  if (write) {
    file_name <- paste0(cohort_name, "_results.rds")
    file_path <- file.path(output_dir, file_name)
    saveRDS(results, file_path)
  }

  results
}
