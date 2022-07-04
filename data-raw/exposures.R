# Example exposure data set
set.seed(124)
n <- 1000
exposures <- tibble::tibble(
  id = seq_len(n),
  # Air pollution
  NO22010 = rnorm(n, 40, 10),
  BC2010 = rnorm(n, NO22010 * 0.1, 0.5),
  PM252010 = rnorm(n, NO22010 * 0.6, 4),
  O32010w = rnorm(n, 100 - 1 * NO22010, 10),
  # Built environment
  ndvi_2019_scaled = runif(n, -1, 1),
  ImpSurf_2015 = runif(n, 0, 1),
  Dist_water = runif(n, 0, 100),
  # Temperature
  temp_2010_cold = rnorm(n, 10, 3),
  temp_2010_cold_sd = runif(n, 2, 5),
  temp_2010_warm = rnorm(n, 25, 8),
  temp_2010_warm_sd = runif(n, 2, 8),
  # SES
  ses = rnorm(n, -4 + NO22010 - ndvi_2019_scaled + temp_2010_warm, 5),
  ses_std = (ses - mean(ses)) / sd(ses)
)

usethis::use_data(exposures, overwrite = TRUE)
