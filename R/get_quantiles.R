##' Computes exposure quantiles for making exposure boxplots.
##'
##' The data frame passed to `data` should contain the eleven exposure
##' variables with the agreed variable names:
##' - no2
##' - pm25
##' - bc
##' - o3
##' - ndvi
##' - imperv
##' - dist_water
##' - temp_warm_mean
##' - temp_warm_sd
##' - temp_cold_mean
##' - temp_cold_mean
##' @title Compute exposure quantiles
##' @param data Data frame containing the exposures of interest. See Details.
##' @return A matrix with quantiles (rows) for each exposure (columns).
##' @author Sergio Olmos
##' @export
##' @examples
##' data(expanse)
##' get_quantiles(expanse)
get_quantiles <- function(data) {
  exposures_only <- data[exposure_names_clean]

  quantile_matrix <- apply(
    exposures_only,
    2,
    stats::quantile,
    prob = seq(0, 1, 0.25)
  )

  quantile_matrix
}
