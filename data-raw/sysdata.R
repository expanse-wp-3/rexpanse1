exposure_names_clean <- c(
  "no2", "pm25", "bc", "o3",
  "ndvi", "imperv", "dist_water",
  "temp_warm_mean", "temp_warm_sd", "temp_cold_mean", "temp_cold_sd"
)

variable_new <- "xds - soy newkkw"

usethis::use_data(exposure_names_clean, variable_new, overwrite = TRUE, internal = TRUE)
