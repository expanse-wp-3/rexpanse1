##' Computes principal components for all variables in the passed data frame.
##'
##' If `summary = TRUE` (default), the returned list will have elements
##' `loadings` and `variance`, with the loadings and variance explained
##' of theprincipal components.
##' If `summary = FALSE`, an element `data` will be included in the
##' returned list, containing a data frame with the values of the
##' principal components for each observation in `data`,
##' together with all the variables in the original data.
##' @title Compute principal component analysis
##' @param data Data frame with only the variables to be included in the PCA.
##' @param summary Logical vector of length one indicating whether only
##'   a summary of the PCA should be returned. See Details.
##' @param suffix A character vector of length one with the suffix to
##'   to be appended to the principal component variable names.
##' @return A list with the PCA output.
##' @author Sergio Olmos
##' @export
##' @examples
##' data(exposures, package = "rexpanse1")
##' exposures_air <- exposures[c("no2", "pm25", "bc", "o3")]
##' get_pca(exposures_air, summary = FALSE, suffix = "air")
get_pca <- function(data, summary = TRUE, suffix) {
  pca <- stats::prcomp(data, center = TRUE, scale. = TRUE)
  pca_loadings <- pca$rotation
  pca_variance <- summary(pca)$importance

  pca_output <- list(
    loadings = pca_loadings,
    variance = pca_variance
  )

  if (summary == FALSE) {
    # TODO Should id be provided?
    pca_data <- tibble::as_tibble(pca$x)

    if (missing(suffix)) {
      colnames(pca_data) <- tolower(colnames(pca_data))
    } else {
      colnames(pca_data) <- paste0(tolower(colnames(pca_data)), "_", suffix)
    }

    pca_output$data <- pca_data
  }

  pca_output
}
