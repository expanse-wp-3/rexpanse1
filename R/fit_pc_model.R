##' Fit a linear regression model assessing relationship between principal components and SES.
##'
##' @title Fit PC and SES model
##' @param pca List containing the principal component analysis result
##'   as obtained by get_pca() with `summary = FALSE` and `long = TRUE`.
##'   The data in the list should also contain variables `ses_var` and
##'   `other_vars` (if needed).
##' @param pc_var String indicating the name of the variable in `data`
##'   corresponding to the relevant principal component, to be used
##'   as the response variable in the regression model.
##' @param ses_var String indicating the name of the variable in `data`
##'   corresponding to the relevant SES variable to be used as a predictor
##'   in the linear regression model.
##' @param other_vars Character vector indicating any other variables in `data`
##'   that need to be included in the model as covariates.
##' @return A list.
##' @author Sergio Olmos

fit_pc_model <- function(pca, pc_var, ses_var, other_vars) {

  stopifnot(is.character(pc_var) & length(pc_var) == 1)
  stopifnot(is.character(ses_var) & length(ses_var) == 1)

  ## We need to check whether the principal component needs to be transformed
  ## by a factor of -1.
  if (!stringr::str_detect(pc_var, "pc[0-9]+_[a-z]+")) {
    stop("pc_var should have format pc1_air, pc2_built... as returned by get_pca_domains().")
  }

  pc_num <- stringr::str_extract(pc_var, "[0-9]+")
  pc_domain <- stringr::str_extract(pc_var, "_overall|_air|_built|_temp") %>%
    stringr::str_remove("^_")

  correction_factor_idx <- which(
    pca$pc_correction$pc == pc_num & pca$pc_correction$domain == pc_domain
  )

  stopifnot(length(correction_factor_idx) == 1)

  correction_factor <- pca$pc_correction$correction_factor[correction_factor_idx]

  pca_data <- pca$data

  if (correction_factor == -1) {
    
    pca_data[pc_var] <- pca_data[[pc_var]] * correction_factor
    warning(
      paste(
        "The principal component values of",
        pc_var,
        "were transformed by a factor of -1 to standardize interpretation."
      )
    )
  }

  model_formula <- paste(
    pc_var, "~",
    paste(ses_var, collapse = " + ")
  )

  if (!missing(other_vars)) {
    stopifnot(is.character(other_vars))
    model_formula <- paste(
      model_formula, "+",
      paste(other_vars, collapse = " + "))
  }

  model <- stats::lm(stats::as.formula(model_formula), data = pca_data)

  model_summary <- broom::tidy(model, conf.int = TRUE) %>%
    dplyr::mutate(
      outcome = pc_var,
      pc = pc_num,
      domain = pc_domain,
      correction_factor = correction_factor
    ) %>%
    dplyr::select(.data$outcome, .data$pc, .data$domain, dplyr::everything())

  model_summary
}
