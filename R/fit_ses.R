fit_ses <- function(data, pc_var, ses_var, other_vars) {

  model_formula <- paste(
    ses_var, "~",
    paste(pc_var, collapse = " + ")
  )

  if (!missing(other_vars)) {
    model_formula <- paste(
      model_formula, "+",
      paste(other_vars, collapse = " + "))
  }

  model <- lm(as.formula(model_formula), data = data)

  model_output <- list(
    summary = broom::tidy(model),
    formula = model_formula
  )

  model_output
}
