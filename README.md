
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rexpanse1

<!-- badges: start -->

<!-- badges: end -->

The goal of rexpanse1 is to provide the necessary functions for
generating the results of the paper *Socioeconomic inequalities in urban
exposome profiles across the life span in European cohorts*.

## Installation

You can install the latest version of rexpanse1 like so:

``` r
# install.packages("remotes")
remotes::install_github("expanse-wp-3/rexpanse1")
```

## Getting started

For illustration, we will load the example data set, `exposures`,
included with the package.

``` r
library(rexpanse1)

# Example data set. Use your data instead.
data(exposures)
str(exposures)
```

You should use your data instead. Note that exposure variables must be
named as in the example data set:

| Variable name    | Original name | Description                          | Year | Version |
| ---------------- | ------------- | ------------------------------------ | ---- | ------- |
| `no2`            | `NO2FULLt`    | Annual average NO2 concentration     | 2010 | Pilot   |
| `pm25`           |               | Annual average PM2.5 concentration   | 2010 | Pilot   |
| `bc`             |               | Annual average BC concentration      | 2010 | Pilot   |
| `o3`             |               | Warm season average O3 concentration | 2010 | Pilot   |
| `ndvi`           |               | NDVI                                 | 2019 | Pilot   |
| `imperv`         |               | Percentage of impervious surfaces    |      | Pilot   |
| `dist_water`     |               | Distance to water (km)               |      | Pilot   |
| `temp_cold_mean` |               |                                      |      |         |
| `temp_cold_sd`   |               |                                      |      |         |
| `temp_warm_mean` |               |                                      |      |         |
| `temp_warm_sd`   |               |                                      |      |         |

### Quantiles

Get quantiles necessary for producing boxplots:

``` r
expo_quantiles <- get_quantiles(data = exposures, write = FALSE)
```

### PCA

Principal component analysis *summary* by domain:

``` r
pca_summary <- get_pca(data = exposures, summary = TRUE)
```
