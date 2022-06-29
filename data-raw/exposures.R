# Example exposure data set
set.seed(124)
n <- 1000
exposures <- tibble::tibble(
  id = seq_len(n),
  # Air pollution
  no2 = rnorm(n, 40, 10),
  bc = rnorm(n, no2 * 0.1, 0.5),
  pm25 = rnorm(n, no2 * 0.6, 4),
  o3 = rnorm(n, 100 - 1 * no2, 10),
  # Built environment
  ndvi = runif(n, -1, 1),
  imperv = runif(n, 0, 1),
  dist_water = runif(n, 0, 100),
  # Temperature
  temp_cold_mean = rnorm(n, 10, 3),
  temp_cold_sd = runif(n, 2, 5),
  temp_warm_mean = rnorm(n, 25, 8),
  temp_warm_sd = runif(n, 2, 8),
  # SES
  ses = rnorm(n, -4 + no2 - ndvi + temp_warm_mean, 5),
  ses_std = (ses - mean(ses)) / sd(ses)
)

usethis::use_data(exposures, overwrite = TRUE)
