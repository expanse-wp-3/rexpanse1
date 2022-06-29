##' Computes principal component analysis for all domains.
##'
##' The domains are overall, air pollution, built environment and temperature.
##' @title Compute PCA for all domains
##' @param data Data frame containing all 11 exposure variables across the three
##'   different domains.
##' @param summary Logical vector of length one indicating whether only
##'   a summary of the PCA should be returned. See Details.
##' @return
##' @author Sergio Olmos
##'
##' @export
##' @examples
##' data(exposures)
##' get_pca_domains(exposures)
get_pca_domains <- function(data,
                            summary = TRUE) {
  air_vars <- c("no2", "pm25", "bc", "o3")
  built_vars <- c("ndvi", "imperv", "dist_water")
  temp_vars <- c(
    "temp_warm_mean",
    "temp_warm_sd",
    "temp_cold_mean",
    "temp_cold_sd"
  )
  pca_domains <- list(
    overall = get_pca(
      data = data[c(air_vars, built_vars, temp_vars)],
      summary = summary,
      suffix = "all"
    ),
    air = get_pca(data[air_vars], summary, "air"),
    built = get_pca(data[built_vars], summary, "built"),
    temp = get_pca(data[temp_vars], summary, "temp")
  )

  if (summary == FALSE) {
    pca_domains_data <- dplyr::bind_cols(
      data,
      purrr::map_dfc(pca_domains, ~ .$data)
    )

    pca_domains_lean <- purrr::map(
      pca_domains,
      ~ .[c("loadings", "variance")]
    )

    pca_domains_lean$data_merged <- pca_domains_data

    return(pca_domains_lean)
  }

  pca_domains
}
