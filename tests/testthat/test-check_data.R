test_that("missing variable names", {
  df_missing_expo_var <- expanse[, 1:4]
  expect_error(check_data(df_missing_expo_var))
})

test_that("missing values in exposure variables", {
  expanse$no2[1:5] <- NA
  expect_error(check_data(expanse))
})
