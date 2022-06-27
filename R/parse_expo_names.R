parse_expo_names <- function(x) {
  x_lower <- tolower(x)
  temp_cold_mean_names <- c(
    "temp_2010_cold",
    "temp_cold_mean",
    "tempmeanc"
  )
  temp_warm_mean_names <- c(
    "temp_2010_warm",
    "temp_warm_mean",
    "tempmeanw"
  )
  temp_warm_sd_names <- c(
    "temp_2010_warm_sd",
    "temp_warm_sd",
    "tempsdw"
  )
  temp_cold_sd_names <- c(
    "temp_2010_cold_sd",
    "temp_cold_sd",
    "tempsdc"
  )
  exposure <- case_when(
    str_detect(x_lower, "no2") ~ "NO2",
    str_detect(x_lower, "pm25") ~ "PM2.5",
    str_detect(x_lower, "bc") ~ "BC",
    str_detect(x_lower, "o3") ~ "O3",
    str_detect(x_lower, "imp") ~ "Imperviousness",
    str_detect(x_lower, "water") ~ "Dist. water",
    str_detect(x_lower, "ndvi") ~ "NDVI",
    x_lower %in% temp_warm_mean_names ~ "Temp warm mean",
    x_lower %in% temp_cold_mean_names ~ "Temp cold mean",
    x_lower %in% temp_warm_sd_names ~ "Temp warm SD",
    x_lower %in% temp_cold_sd_names ~ "Temp cold SD",
  )

  if (sum(is.na(exposure)) != 0) {
    warning("Some variable names are not defined.")
  }

  exposure
}
