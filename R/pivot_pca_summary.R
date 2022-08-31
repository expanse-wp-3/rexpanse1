##' Reshapes the PCA summary information into a long format.
##'
##' Each row corresponds to a variable in each component.
##' Note that the variables pc_sd, pc_var_pop, and pc_cum_var_prop refer to
##' the principal component and have therefore the same value for all variables
##' within a principal component.
##' @title Pivot PCA summary into long format
##' @param pca List as returned by get_pca().
##' @return A tibble with PCA summary in long format.
##' @author Sergio Olmos
pivot_pca_summary <- function(pca) {
  loadings <- pca$loadings %>%
    tibble::as_tibble(rownames = "var") %>%
    tidyr::pivot_longer(cols = -.data$var, names_to = "pc", values_to = "loading")

  variance <- pca$variance %>%
    t() %>%
    tibble::as_tibble(rownames = "pc") %>%
    stats::setNames(c("pc", "pc_sd", "pc_var_prop", "pc_cum_var_prop"))

  pca_long <- loadings %>%
    dplyr::left_join(variance, by = "pc") %>%
    dplyr::mutate(
      pc = as.integer(stringr::str_remove(.data$pc, "PC"))
    ) %>%
    dplyr::select(.data$var, .data$loading, dplyr::everything())

  pca_long
}
