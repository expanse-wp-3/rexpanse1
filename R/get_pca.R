get_pca <- function(data, summary = TRUE, suffix) {
  pca <- prcomp(data, center = TRUE, scale. = TRUE)
  pca_loadings <- pca$rotation
  pca_variance <- summary(pca)$importance

  pca_output <- list(
    loadings = pca_loadings,
    variance = pca_variance
  )

  if (summary == FALSE) {
    # TODO Should id be provided?
    pca_data <- pca$x %>%
      as_tibble()

    if (missing(suffix)) {
      colnames(pca_data) <- tolower(colnames(pca_data))
    } else {
      colnames(pca_data) <- paste0(tolower(colnames(pca_data)), "_", suffix)
    }

    pca_output$data <- pca_data
  }

  pca_output
}
