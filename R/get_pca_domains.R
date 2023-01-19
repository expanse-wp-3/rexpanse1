##' Computes principal component analysis for all domains.
##'
##' The domains are overall, air pollution, built environment and temperature.
##' @title Compute PCA for all domains
##' @param data Data frame containing all 11 exposure variables across the three
##'   different domains.
##' @param summary Logical vector of length one indicating whether only
##'   a summary of the PCA should be returned. See Details.
##' @return A list containing a summary of the PCA, the actual principal component
##'   values together with the variables used, and a table identifying the
##'   correction factor of each principal component for standardizing
##'   the interpretation across cohorts.
##' @author Sergio Olmos
##'
##' @export
##' @examples
##' data(expanse)
##' get_pca_domains(expanse)
get_pca_domains <- function(data,
                            summary = TRUE) {

  air_vars <- exposure_names_clean[1:4]
  built_vars <- exposure_names_clean[5:7]
  temp_vars <- exposure_names_clean[8:11]

  pca_domains <- list(
    overall = get_pca(
      data = data[c(air_vars, built_vars, temp_vars)],
      summary = summary,
      long = TRUE,
      suffix = "overall"
    ),

    air = get_pca(
      data[air_vars],
      summary = summary,
      long = TRUE,
      suffix = "air"
    ),

    built = get_pca(
      data[built_vars],
      summary,
      TRUE,
      "built"
    ),

    temp = get_pca(
      data[temp_vars],
      summary,
      TRUE,
      "temp"
    )
  )

  pca_summary <- purrr::map_df(pca_domains, ~.$summary, .id = "domain")

  # We want that the principal components all have similar interpretations,
  # so we always transform the PCs to have positive loading for NO2 and NDVI.
  # We include a data frame with the correction factor (1 or -1) that needs
  # to be applied to each principal component for this standardization.

  pc_correction <- pca_summary %>%
    dplyr::group_by(
      .data$domain, 
      .data$pc
    ) %>%
    dplyr::summarise(
      is_negative_loading = sum(.data$var %in% c("NO22010", "ndvi_2019") & .data$loading < 0) > 0
    ) %>%
    dplyr::mutate(correction_factor = ifelse(.data$is_negative_loading, -1, 1)) %>%
    dplyr::select(-.data$is_negative_loading)

  # I add a column with the standardized loading value
  pca_summary <- pca_summary %>%
    dplyr::left_join(pc_correction, by = c("domain", "pc")) %>%
    dplyr::mutate(
      loading_std = ifelse(
        !is.na(.data$correction_factor),
        .data$loading * .data$correction_factor,
        .data$loading
      )
    )

  pca_domains_output <- list(
    summary = pca_summary,
    data = NULL,
    pc_correction = pc_correction
  )

  if (summary == FALSE) {
    ## Select the columns containing the principal component values
    pcs <- purrr::map_dfc(
      pca_domains,
      ~dplyr::select(.$data, dplyr::matches("pc[0-9]+_"))
    )
    pca_data <- dplyr::bind_cols(data, pcs)

    pca_domains_output$data <- pca_data
  }

  pca_domains_output
}
