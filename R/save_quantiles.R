save_quantiles <- function(data, cohort_name, dir = getwd()) {
  quantile_matrix <- get_quantiles(data)

  file_name <- paste0(cohort_name, "_quantiles.rds")
  file_path <- file.path(dir, file_name)

  cat("Saving exposure quantiles file in", file_path, "\n")
  saveRDS(quantile_matrix, file_path)
}
