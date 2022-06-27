get_quantiles <- function(data,
                          write = FALSE,
                          dir = ".") {
  if (ncol(data) != 11) {
    stop(
      cli::cli_alert_danger(
        "Data should (only) contain the 11 exposure variables."
      )
    )
  }

  quantile_matrix <- apply(data, 2, quantile, prob = seq(0, 1, 0.25))

  quantile_matrix
}
