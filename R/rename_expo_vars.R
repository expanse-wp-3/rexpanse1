rename_expo_vars <- function(data,
                             no2,
                             pm25,
                             bc,
                             o3,
                             ndvi,
                             imperv_surf,
                             temp_cold_mean,
                             temp_cold_sd,
                             temp_warm_mean,
                             temp_warm_sd) {
  dplyr::rename(
    data,
    no2 = no2,
    pm25 = pm25,
    bc = bc,
    o3 = o3,
    ndvi = ndvi,
    imperv_surf = imperv_surf,
    temp_cold_mean = temp_cold_mean,
    temp_cold_sd = temp_cold_sd,
    temp_warm_mean = temp_warm_mean,
    temp_warm_sd = temp_warm_sd
  )
}
