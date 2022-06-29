##' Generates all results for Paper 1.
##'
##' @title Run full analysis pipeline
##' @param data
##' @param ses_var
##' @param other_vars
##' @param cohort_name
##' @param write
##' @param output_dir
##' @return
##' @author Sergio Olmos
run_pca <- function(data,
                    ses_var,
                    other_vars,
                    cohort_name,
                    write = TRUE,
                    output_dir = ".") {
  rexpanse1_version <- utils::packageVersion("rexpanse1")
  cli::cli_h1("Running analysis pipeline with rexpanse1 version {rexpanse1_version}")
  cli::cli_alert("Checking data...")
  check_data(data)

  if (!missing(other_vars)) {
    data <- data[c(exposure_names_clean, ses_var, other_vars)]
  }

  cli::cli_alert("Computing exposure quantiles...")
  expo_quantiles <- get_quantiles(data)

  cli::cli_alert("Computing PCA...")
  pca <- get_pca_domains(data, summary = FALSE)
  pca_summary <- pca[c("overall", "air", "built", "temp")]

  # TODO Add modeling of SES

  results <- list(
    cohort = cohort_name,
    quantiles = expo_quantiles,
    pca_summary = pca_summary,
    package_version = paste0("rexpanse1-", rexpanse1_version)
  )

  if (write) {
    file_name <- paste0(cohort_name, "_results.rds")
    file_path <- file.path(output_dir, file_name)
    cli::cli_alert("Writing results to {file_path}")
    saveRDS(results, file_path)
  }

  results
}
