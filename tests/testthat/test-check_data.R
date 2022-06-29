test_that("missing variable names", {
  df_missing_expo_var <- exposures[, 1:4]
  expect_error(check_data(df_missing_expo_var))
})

test_that("missing values in exposure variables", {
  exposures$no2[1:5] <- NA
  expect_error(check_data(exposures))
})
