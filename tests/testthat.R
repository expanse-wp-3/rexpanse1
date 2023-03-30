library(testthat)
library(rexpanse1)

test_check("rexpanse1")


my_results <- run_pca(
  data,
  ses_var = c("ses_cat_indv", "ses_cat_area"),
  age_var = "age",
  cohort_name = "catalonia",
  write = TRUE,
  output_dir = "results"
)