exposure_names_clean <- c(
  "no2", "pm25", "bc", "o3",
  "ndvi", "imperv", "dist_water",
  "temp_warm_mean", "temp_warm_sd", "temp_cold_mean", "temp_cold_sd"
)

usethis::use_data(exposure_names_clean, overwrite = TRUE, internal = TRUE)
