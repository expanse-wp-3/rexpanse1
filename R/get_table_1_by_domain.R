##' Computes table 1 - summary of principal data
##'
##' The domains are SES and age.
##' @title Compute Table 1
##' @param data Data frame containing posible SES (max. 2)
##'   and Age, it can be at base line or real. 
##' @param ses_var Vector of length max. 2 containing the name of SES.
##'   this vector can be NULL.
##' @param age_var Name of age variable
##'
##' @return A list containing a summary of Age variable
##'   Number of individuos 
##'   Proportion of Indv. by SES.
##'   .
##' @author Fabian Coloma
##'
##' @export
##' @examples
##' data(expanse)
##' table1_extract(data, ses_var = "ses_cat_indv", age_var = "age_random")
##' table1_extract(data, ses_var = c("ses_cat_indv", "ses_cat_area"), age_var = "age_random")
##' table1_extract(data, ses_var = NULL, age_var = NULL)

table1_extract <- function(data, ses_var = NULL, age_var = NULL) {

  #
  #
  # Data information
  #
  #
  
  if(!length(age_var) == 0 ) {

    data_age_summary <- data.frame(unclass(summary(pull(data, age_var))),  # Convert summary to data frame
                           check.names = FALSE) %>% 
                    mutate(row_nam = rownames(.))

    rownames(data_age_summary) <- NULL

    names(data_age_summary) <- c("quantiles_age", "quantile")



  } else {
    data_age_summary <- NULL 
  }

  #
  #
  # SES information
  #
  #

  if(length(ses_var) == 1) {

    table_1_ses_1 <- data %>% select(ses_var[1]) %>% table() %>% as.data.frame() 

    names(table_1_ses_1) <- c(ses_var[1], paste(ses_var[1], "freq", sep = "_")) 

    result <- list(
      table_1_ses_a = table_1_ses_1,
      table_1_ses_b = NULL,
      data_age_quantiles = data_age_summary,
      n_total = nrow(data)
    )

  } else if (length(ses_var) == 2) {

    table_1_ses_1 <- data %>% select(ses_var[1]) %>% table() %>% as.data.frame() 

    names(table_1_ses_1) <- c(ses_var[1], paste(ses_var[1], "freq", sep = "_"))

    table_1_ses_2 <- data %>% select(ses_var[2]) %>% table() %>% as.data.frame() 

    names(table_1_ses_2) <- c(ses_var[2], paste(ses_var[2], "freq", sep = "_")) 

    result <- list(
      table_1_ses_a = table_1_ses_1,
      table_1_ses_b = table_1_ses_2,
      data_age_quantiles = data_age_summary,
      n_total = nrow(data)
    )

  } else {

    result <- list(
      table_1_ses_a = NULL,
      table_1_ses_b = NULL,
      data_age_quantiles = data_age_summary,
      n_total = nrow(data)
    )

  }

  result

}