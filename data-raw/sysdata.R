exposure_names_clean <- c(
  "NO22010", "PM252010", "BC2010", "O32010w",
  "ndvi_2019_scaled", "ImpSurf_2015", "Dist_water",
  "temp_2010_warm", "temp_2010_warm_sd", "temp_2010_cold", "temp_2010_cold_sd"
)

usethis::use_data(exposure_names_clean, overwrite = TRUE, internal = TRUE)
