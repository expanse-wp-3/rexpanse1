##' Computes exposure quantiles for making exposure boxplots, adding domain in this cases SES variable.
##'
##' The data frame passed to `data` should contain the eleven exposure
##' variables with the agreed variable names:
##' - NO22010
##' - PM252010
##' - BC2010
##' - O32010w
##' - ndvi_2019
##' - ImpSurf_2015
##' - Dist_water
##' - temp_2010_warm
##' - temp_2010_warm_sd
##' - temp_2010_cold
##' - temp_2010_cold_sd
##' - ses_cat_indv
##' - ses_cat_area
##' @title Compute exposure quantiles
##' @param data Data frame containing the exposures of interest. See Details.
##' @return A data frame with quantiles and domain (rows) for each exposure (columns).
##' @author Fabian Coloma
##' @export
##' @examples
##' data(expanse)
##' get_quantiles(expanse, domain = ses_cat_var)
get_quantiles_by_domain <- function(data, domain) {

general <- data %>%
  select(exposure_names_clean)

a <- data %>% 
  filter(get(domain[1]) == "Low") %>%
  select(exposure_names_clean)

b <- data %>% 
  filter(get(domain[1]) == "Middle") %>%
  select(exposure_names_clean)

c <- data %>% 
  filter(get(domain[1]) == "High") %>%
  select(exposure_names_clean)


quantiles_by_ses <- list(
    overall = list(summary = get_quantiles(general) %>% as.data.frame()  %>% mutate(quantile_id =  rownames(test)) ),

    low = list(summary = get_quantiles(a) %>% as.data.frame()  %>% mutate(quantile_id =  rownames(test)) ) ,

    middle = list(summary = get_quantiles(b) %>% as.data.frame()  %>% mutate(quantile_id =  rownames(test)) ),

    high = list(summary = get_quantiles(c) %>% as.data.frame()  %>% mutate(quantile_id =  rownames(test)) )
  )



quantiles_by_ses$overall$summary %>% View()

quant <- purrr::map_df(quantiles_by_ses, ~.$summary, .id = "domain")

quant 

}
