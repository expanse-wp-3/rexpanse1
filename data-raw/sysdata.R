exposure_names_clean <- c(
  "NO22010", "PM252010", "BC2010", "O32010w",
  "ndvi_2019", "ImpSurf_2015", "Dist_water",
  "temp_2010_warm", "temp_2010_warm_sd", "temp_2010_cold", "temp_2010_cold_sd"
)

ses_var_clean <- c("ses_cat_indv", "ses_cat_area")

ses_var_factor_clean <- c("Low", "Middle", "High")

usethis::use_data(exposure_names_clean,
  ses_var_clean, 
  ses_var_factor_clean, 
  overwrite = TRUE, 
  internal = TRUE)
