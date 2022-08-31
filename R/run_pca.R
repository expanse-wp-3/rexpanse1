##' Generates all results for Paper 1.
##'
##' @title Run full analysis pipeline
##' @param data Data frame containing all exposures
##' @param ses_var Charcater vector of length one indicating the name of
##'   the SES variable in `data` which will be used as a predictor when looking
##'   at the association with the principal components.
##' @param other_vars Character vector indicating the names of any other
##'   variables in `data` that need to be included as covariates in the
##'   models assessing the association between the principal components
##'   and SES.
##' @param cohort_name Character vector of length one indicating the name of
##'   the cohort.
##' @param write Logical vector of length one indicating whether the output
##'   should be written to disk.
##' @param output_dir Character vector of length one indicating the path where
##'   the output file should be written if `write = TRUE`. Defaults to current
##'   working directory.
##' @return A list containing the following elements:
##' @author Sergio Olmos
##' @export
##' @examples
##' data(expanse)
##' results_dir <- tempdir()
##' run_pca(
##'   data = expanse,
##'   ses_var = "ses_cat",
##'   cohort_name = "catalonia",
##'   write = TRUE,
##'   output_dir = results_dir
##' )
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
  expo_quantiles <- get_quantiles(data[exposure_names_clean])

  cli::cli_alert("Computing PCA...")
  pca <- get_pca_domains(data, summary = FALSE)

  # TODO Add modeling of SES
  cli::cli_alert("Fitting PC ~ SES models...")
  pc_names <- colnames(pca$data)[grep("^pc[0-9]+_[a-z]+$", colnames(pca$data))]
  if (missing(other_vars)) {
    pc_models <- purrr::map_df(
      pc_names,
      function(x) {
        fit_pc_model(pca, pc_var = x, ses_var = ses_var)
      }
    )
  } else {
    pc_models <- purrr::map_df(
      pc_names,
      function(x) {
        fit_pc_model(pca, pc_var = x, ses_var = ses_var, other_vars = other_vars)
      }
    )
  }

  results <- list(
    cohort = cohort_name,
    quantiles = expo_quantiles,
    pca_summary = pca$summary,
    pc_ses_models = pc_models,
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