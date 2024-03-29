# Example data set
set.seed(124)
n <- 1000
expanse <- tibble::tibble(
  id = seq_len(n),
  # Air pollution
  NO22010 = rnorm(n, 40, 10),
  BC2010 = rnorm(n, NO22010 * 0.1, 0.5),
  PM252010 = rnorm(n, NO22010 * 0.6, 4),
  O32010w = rnorm(n, 100 - 1 * NO22010, 10),
  # Built environment
  ndvi_2019 = runif(n, -1, 1),
  ImpSurf_2015 = runif(n, 0, 1),
  Dist_water = runif(n, 0, 100),
  # Temperature
  temp_2010_cold = rnorm(n, 10, 3),
  temp_2010_cold_sd = runif(n, 2, 5),
  temp_2010_warm = rnorm(n, 25, 8),
  temp_2010_warm_sd = runif(n, 2, 8),
  # SES
  ses_area = rnorm(n, -4 + NO22010 - ndvi_2019 + temp_2010_warm, 5),
  ses_cat_area = cut(ses_area, breaks = 3, labels = c("Low", "Middle", "High")),
  ses_indv = rnorm(n, -4 + NO22010 - ndvi_2019 + temp_2010_warm, 5),
  ses_cat_indv = cut(ses_indv, breaks = 3, labels = c("Low", "Middle", "High")),
  # SES
  age = rnorm(n, 47, 3),
  # Other vars
  pop_density = runif(n, 0, 1)
)

usethis::use_data(expanse, overwrite = TRUE)
