##' Generates all results for Paper 1.
##'
##' @title Run full analysis pipeline
##' @param data Data frame containing all exposures
##' @param ses_var Charcater vector of length one or two indicating the name of
##'   the SES variable (individual, and by region) in `data` which will be used as a predictor when looking
##'   at the association with the principal components.
##' @param age_var character indicating the name of Age at baseline variable as numeric.
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
##'   age_var = "age",
##'   cohort_name = "catalonia",
##'   write = TRUE,
##'   output_dir = results_dir
##' )
##'
##' results_dir <- tempdir()
##' run_pca(
##'   data = expanse,
##'   ses_var = c("ses_cat_inv", "ses_cat_reg"),
##'   age_var = "age",
##'   cohort_name = "catalonia",
##'   write = TRUE,
##'   output_dir = results_dir
##' )

run_pca <- function(data,
                    ses_var = NULL,
                    age_var = "age",
                    other_vars,
                    cohort_name,
                    write = TRUE,
                    output_dir = ".") {

  rexpanse1_version <- utils::packageVersion("rexpanse1")

  cli::cli_h1("Running analysis pipeline with rexpanse1 version {rexpanse1_version}")


  # cli::cli_alert(variable_new)

  cli::cli_alert("Checking data...")
  check_data(data)

  if (!missing(other_vars)) {
    data <- data[c(exposure_names_clean, ses_var, other_vars)]
  }

  cli::cli_alert("Computing table 1...")

  table_1result <- table1_extract(data, ses_var = ses_var, age_var = age_var)

  cli::cli_alert("Computing exposure quantiles...")
  expo_quantiles <- get_quantiles(data[exposure_names_clean])

  cli::cli_alert("Computing PCA...")
  pca <- get_pca_domains(data, summary = FALSE)

  # TODO Add modeling of SES
  cli::cli_alert("Fitting PC ~ SES models...")

  pc_names <- colnames(pca$data)[grep("^pc[0-9]+_[a-z]+$", colnames(pca$data))]

  if(length(ses_var) == 1){ 

    if (missing(other_vars)) {

      pc_models_1 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[1])
        }
      )
    } else {
      pc_models_1 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[1], other_vars = other_vars)
        }
      )
    }

    ses_quantile <- get_quantiles_by_domain(data, ses_var[1])

    results <- list(
      cohort = cohort_name,
      table_1 = table_1result,
      quantiles = expo_quantiles,
      ses_information = ses_var[1],
      ses_quantiles_1 = ses_quantile,
      pca_summary = pca$summary,
      pc_ses_models_1 = pc_models_1,
      package_version = paste0("rexpanse1-", rexpanse1_version)
    )
  } else if (length(ses_var) == 2) {

    if (missing(other_vars)) {

      pc_models_1 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[1])
        }
      )

      pc_models_2 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[2])
        }
      )

    } else {

      pc_models_1 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[1], other_vars = other_vars)
        }
      )

      pc_models_2 <- purrr::map_df(
        pc_names,
        function(x) {
          fit_pc_model(pca, pc_var = x, ses_var = ses_var[2], other_vars = other_vars)
        }
      )
    }

    ses_quantile_1 <- get_quantiles_by_domain(data, ses_var[1])
    ses_quantile_2 <- get_quantiles_by_domain(data, ses_var[2])

    results <- list(
      cohort = cohort_name,
      table_1 = table_1result,
      quantiles = expo_quantiles,
      ses_information = c(ses_var[1], ses_var[2]),
      ses_quantiles_1 = ses_quantile_1,
      ses_quantiles_2 = ses_quantile_2,
      pca_summary = pca$summary,
      pc_ses_models_1 = pc_models_1,
      pc_ses_models_2 = pc_models_2,
      package_version = paste0("rexpanse1-", rexpanse1_version)
    )

  } else {

    cli::cli_alert("Imposible modelling... Check the numer of SES inside the vector (MAX 2)")

    results <- list(
      cohort = cohort_name,
      table_1 = table_1result,
      quantiles = expo_quantiles,
      ses_information = "no ses",
      ses_quantiles = NULL,
      pca_summary = pca$summary,
      pc_ses_models_1 = NULL,
      package_version = paste0("rexpanse1-", rexpanse1_version)
    )
  }
  

  if (write) {
    file_name <- paste0(cohort_name, "_results.rds")
    file_path <- file.path(output_dir, file_name)
    cli::cli_alert("Writing results to {file_path}")
    saveRDS(results, file_path)
  }

  results
}
