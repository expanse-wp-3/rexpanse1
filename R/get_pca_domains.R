get_pca_domains <- function(data,
                            air_vars,
                            built_vars,
                            temp_vars,
                            summary = TRUE,
                            id_var,
                            write = FALSE,
                            dir = ".") {
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
    stopifnot(!missing(id_var))
    pca_data_merged <- dplyr::bind_cols(
      id = data[id_var],
      purrr::map_dfc(pca_domains, ~ .$data)
    )

    pca_domains_clean <- purrr::map(
      pca_domains,
      ~ .[c("loadings", "variance")]
    )

    pca_domains_clean$data_merged <- pca_data_merged

    return(pca_domains_clean)
  }

  pca_domains
}
