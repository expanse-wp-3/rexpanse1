get_quantiles <- function(data,
                          write = FALSE,
                          dir = ".") {
  check_data(data)

  exposures_only <- data[exposure_names_clean]

  quantile_matrix <- apply(
    exposures_only,
    2,
    stats::quantile,
    prob = seq(0, 1, 0.25)
  )

  quantile_matrix
}
