
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

### Data

For illustration, we will load the example data set, `expanse`, included
with the package.

``` r
library(rexpanse1)

# Example data set
data(expanse)
str(expanse)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    1000 obs. of  16 variables:
#>  $ id            : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ no2           : num  26.1 40.4 32.4 42.1 54.3 ...
#>  $ bc            : num  2.97 4.06 2.94 4.87 5.06 ...
#>  $ pm25          : num  16.8 26.9 15.5 28.2 35.3 ...
#>  $ o3            : num  75.4 58.1 74.1 50.6 46 ...
#>  $ ndvi          : num  -0.893 -0.0142 -0.8284 -0.5419 -0.5357 ...
#>  $ imperv        : num  0.462 0.104 0.11 0.32 0.937 ...
#>  $ dist_water    : num  61.2 99.3 19.3 37.5 26.2 ...
#>  $ temp_cold_mean: num  8.26 9.35 7.37 7.92 13.6 ...
#>  $ temp_cold_sd  : num  2.39 2.22 2.93 3.83 3.64 ...
#>  $ temp_warm_mean: num  24.9 16 24.5 19.4 23.2 ...
#>  $ temp_warm_sd  : num  6.15 3.12 3.12 4.87 3.72 ...
#>  $ ses           : num  46.6 46.2 45.7 46.8 74.9 ...
#>  $ ses_std       : num  -0.968 -0.995 -1.028 -0.948 1.052 ...
#>  $ ses_cat       : Factor w/ 3 levels "low","medium",..: 2 2 2 2 3 3 2 2 2 2 ...
#>  $ pop_density   : num  0.882 0.252 0.202 0.648 0.119 ...
```

For producing results for your cohort you should use your data instead.

> **Important**: Note that exposure variables must be named as in the
> example data set and as shown below.

| Variable name    | Original name | Domain            | Description                          | Year | Version |
| ---------------- | ------------- | ----------------- | ------------------------------------ | ---- | ------- |
| `no2`            | `NO2FULLt`    | Air pollution     | Annual average NO2 concentration     | 2010 | Pilot   |
| `pm25`           |               | Air pollution     | Annual average PM2.5 concentration   | 2010 | Pilot   |
| `bc`             |               | Air pollution     | Annual average BC concentration      | 2010 | Pilot   |
| `o3`             |               | Air pollution     | Warm season average O3 concentration | 2010 | Pilot   |
| `ndvi`           |               | Built environment | NDVI                                 | 2019 | Pilot   |
| `imperv`         |               | Built environment | Percentage of impervious surfaces    |      | Pilot   |
| `dist_water`     |               | Built environment | Distance to water (km)               |      | Pilot   |
| `temp_cold_mean` |               |                   |                                      |      |         |
| `temp_cold_sd`   |               |                   |                                      |      |         |
| `temp_warm_mean` |               |                   |                                      |      |         |
| `temp_warm_sd`   |               |                   |                                      |      |         |

### Results

All the results can be produced by running a single function,
`run_pca()`, with the appropriate arguments. See `?run_pca` for details.

Using the example data set:

``` r
# I create a temporary directory to store the results.
# You do not need to do this.
my_results_dir <- tempdir()

# Run entire analysis.
catalonia_pca <- run_pca(
  expanse,
  ses_var = "ses_cat",
  cohort_name = "catalonia",
  write = TRUE,
  output_dir = my_results_dir
)
#> 
#> ── Running analysis pipeline with rexpanse1 version 0.0.0.9000 ──────────────────────────────────────────
#> → Checking data...
#> → Computing exposure quantiles...
#> → Computing PCA...
#> → Fitting PC ~ SES models...
#> → Writing results to /tmp/RtmpO7XdTZ/catalonia_results.rds
```

Note that you may get some warnings informing you that some of the
principal components have been multiplied by -1 to make the
interpretation somewhat consistent across the cohorts.

Principal components are transformed this way if the loading for `no2`
or `ndvi` are negative.

You should pass your data frame formatted as decribed in the previous
section.

Note that when `write = TRUE`, you need to specify an appropriate
directory (folder) path to `output_dir`. The defult directory is the
current working directory.

`run_pca()` returns a list with the following elements.

#### Cohort name

``` r
catalonia_pca$cohort
#> [1] "catalonia"
```

#### Exposure quantiles

``` r
catalonia_pca$quantiles
#>            no2      pm25        bc       o3         ndvi      imperv
#> 0%    8.046865  1.259855 0.5889552 15.47434 -0.999472837 0.001507511
#> 25%  32.808522 18.874794 3.1905654 50.95743 -0.503008266 0.276746408
#> 50%  39.194696 23.702071 3.9358686 61.27195 -0.009137054 0.547535983
#> 75%  45.784346 28.424070 4.6540855 70.82986  0.488273838 0.762002524
#> 100% 68.612485 45.423504 7.5603516 99.90618  0.999148477 0.998674971
#>       dist_water temp_warm_mean temp_warm_sd temp_cold_mean temp_cold_sd
#> 0%    0.01124465      -2.626869     2.001096       0.463393     2.006105
#> 25%  25.84877096      19.755001     3.463665       7.986223     2.797981
#> 50%  50.61429742      24.663473     5.033699      10.074166     3.496788
#> 75%  77.14485044      30.093024     6.455118      12.104675     4.244186
#> 100% 99.98015247      50.482130     7.996707      19.484335     4.994085
```

#### PCA by domain summary

``` r
head(catalonia_pca$pca_summary)
#> # A tibble: 6 × 9
#>   domain var    loading    pc pc_sd pc_var_prop pc_cum_var_prop correction_fact…
#>   <chr>  <chr>    <dbl> <int> <dbl>       <dbl>           <dbl>            <dbl>
#> 1 overa… no2   -0.539       1 1.78       0.289            0.289               -1
#> 2 overa… no2   -0.00723     2 1.07       0.105            0.394               -1
#> 3 overa… no2   -0.0162      3 1.03       0.0966           0.491               -1
#> 4 overa… no2   -0.0191      4 1.01       0.0924           0.583               -1
#> 5 overa… no2   -0.00922     5 1.00       0.0911           0.674               -1
#> 6 overa… no2   -0.0161      6 0.984      0.0880           0.762               -1
#> # … with 1 more variable: loading_std <dbl>
```

#### Associations with SES

``` r
head(catalonia_pca$pc_ses_models)
#> # A tibble: 6 × 11
#>   outcome     pc    domain term  estimate std.error statistic   p.value conf.low
#>   <chr>       <chr> <chr>  <chr>    <dbl>     <dbl>     <dbl>     <dbl>    <dbl>
#> 1 pc1_overall 1     overa… (Int…   -2.25     0.125     -18.0  3.84e- 63   -2.49 
#> 2 pc1_overall 1     overa… ses_…    2.19     0.135      16.1  3.34e- 52    1.92 
#> 3 pc1_overall 1     overa… ses_…    4.10     0.163      25.2  1.61e-108    3.78 
#> 4 pc2_overall 2     overa… (Int…    0.416    0.0931      4.47 8.61e-  6    0.234
#> 5 pc2_overall 2     overa… ses_…   -0.359    0.101      -3.55 4.04e-  4   -0.557
#> 6 pc2_overall 2     overa… ses_…   -0.941    0.122      -7.73 2.63e- 14   -1.18 
#> # … with 2 more variables: conf.high <dbl>, correction_factor <dbl>
```

#### Package version

``` r
catalonia_pca$package_version
#> [1] "rexpanse1-0.0.0.9000"
```
