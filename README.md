
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

tibble [1,000 x 18] (S3: tbl_df/tbl/data.frame)
 $ id               : int [1:1000] 1 2 3 4 5 6 7 8 9 10 ...
 $ NO22010          : num [1:1000] 26.1 40.4 32.4 42.1 54.3 ...
 $ BC2010           : num [1:1000] 2.97 4.06 2.94 4.87 5.06 ...
 $ PM252010         : num [1:1000] 16.8 26.9 15.5 28.2 35.3 ...
 $ O32010w          : num [1:1000] 75.4 58.1 74.1 50.6 46 ...
 $ ndvi_2019        : num [1:1000] -0.893 -0.0142 -0.8284 -0.5419 -0.5357 ...
 $ ImpSurf_2015     : num [1:1000] 0.462 0.104 0.11 0.32 0.937 ...
 $ Dist_water       : num [1:1000] 61.2 99.3 19.3 37.5 26.2 ...
 $ temp_2010_cold   : num [1:1000] 8.26 9.35 7.37 7.92 13.6 ...
 $ temp_2010_cold_sd: num [1:1000] 2.39 2.22 2.93 3.83 3.64 ...
 $ temp_2010_warm   : num [1:1000] 24.9 16 24.5 19.4 23.2 ...
 $ temp_2010_warm_sd: num [1:1000] 6.15 3.12 3.12 4.87 3.72 ...
 $ ses_area         : num [1:1000] 46.6 46.2 45.7 46.8 74.9 ...
 $ ses_cat_area     : Factor w/ 3 levels "Low","Middle",..: 2 2 2 2 3 3 2 2 2 2 ...
 $ ses_indv         : num [1:1000] 53.9 48.2 47.8 61.7 79.1 ...
 $ ses_cat_indv     : Factor w/ 3 levels "Low","Middle",..: 2 2 2 2 3 3 2 2 2 3 ...
 $ age              : num [1:1000] 43.6 51.8 49.5 42.2 47 ...
 $ pop_density      : num [1:1000] 0.37 0.302 0.914 0.258 0.645 ...
```

For producing results for your cohort you should use your data instead.

> **Important**: Note that exposure variables must be named as in the
> example data set and as shown below.

| Variable name       | Description                                          | Year | Version |
|---------------------|------------------------------------------------------|------|---------|
| `NO22010`           | Annual average NO2 concentration                     | 2010 | 1       |
| `PM252010`          | Annual average PM2.5 concentration                   | 2010 | 1       |
| `BC2010`            | Annual average BC concentration                      | 2010 | 1       |
| `O32010w`           | Warm season average O3 concentration                 | 2010 | 1       |
| `ndvi_2019`         | NDVI                                                 | 2019 | 1       |
| `ImpSurf_2015`      | Percentage of impervious surfaces                    | 2015 | 1       |
| `Dist_water`        | Distance to water (km)                               |      | 1       |
| `temp_2010_cold`    | Mean temperature during warm season (May-October)    | 2010 | 1       |
| `temp_2010_cold_sd` | Temperature standard deviation during warm season    | 2010 | 1       |
| `temp_2010_warm`    | Mean temperature during cold season (November-April) | 2010 | 1       |
| `temp_2010_warm_sd` | Temperature standard deviation during cold season    | 2010 | 1       |

### Sociodemographic variables
The following SES variables are defined by every cohort. 

> **Important**: Note that SES variables must be inside of these categories
> "Low" "Middle" "High" as **FACTOR**

| Variable name       | Description                                          | Year | Version |
|---------------------|------------------------------------------------------|------|---------|
| `ses_cat_indv`      | SES at individual level                              | 2010 | 1       |
| `ses_cat_area`      | SES at area level                                    | 2010 | 1       |
| `age`               | age at baseline time                                 |      |         |

**The inclusion of these two variable is not mandatory, please create both if possible**

### Results

All the results can be produced by running a single function,
`run_pca()`, with the appropriate arguments. See `?run_pca` for details.

Using the example data set:

1.  Install the rexpanse1 R package via GitHub:

<!-- end list -->

``` r
# install.packages("remotes")
remotes::install_github("expanse-wp-3/rexpanse1")
```

3.  Load rexpanse1 and dplyr:

<!-- end list -->

``` r
library(rexpanse1)
library(dplyr)
```

2.  Read your data into a data frame:

<!-- end list -->

``` r
my_data <- read.csv("my-clean-data.csv")
```



3.  Run the whole analysis and store the output in the directory
    specified in `output_dir` (default is current working directory): 

**IMPORTANT:** 

- **Note that this data frame should contain all raw exposure variables defined above and contain no missing values (complete cases only).**

- **If you want to save the outputs in a folder called "results" as shown in the code below, please make sure that this folder exists or create it before running the code.**

<!-- end list -->

``` r
my_results <- run_pca(
  my_data,
  ses_var = c("ses_cat_indv", "ses_cat_area"),
  age_var = "age",
  cohort_name = "catalonia",
  write = TRUE,
  output_dir = "results"
)
```

    ## 
    ## ── Running analysis pipeline with rexpanse1 version 0.0.0.9000 ───────────────────────────────────────────
    ## → Checking data...
    ## → Computing exposure quantiles...
    ## → Computing PCA...

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

### Details

`run_pca()` returns a list with the following elements.

#### Cohort name

The cohort name specified:

``` r
my_results$cohort
[1] "catalonia"
```

#### Exposure quantiles

A set of quantiles of the exposure variables:

``` r
my_results$quantiles

       NO22010  PM252010    BC2010  O32010w    ndvi_2019 ImpSurf_2015
0%    8.046865  1.259855 0.5889552 15.47434 -0.999472837  0.001507511
25%  32.808522 18.874794 3.1905654 50.95743 -0.503008266  0.276746408
50%  39.194696 23.702071 3.9358686 61.27195 -0.009137054  0.547535983
75%  45.784346 28.424070 4.6540855 70.82986  0.488273838  0.762002524
100% 68.612485 45.423504 7.5603516 99.90618  0.999148477  0.998674971
      Dist_water temp_2010_warm temp_2010_warm_sd temp_2010_cold
0%    0.01124465      -2.626869          2.001096       0.463393
25%  25.84877096      19.755001          3.463665       7.986223
50%  50.61429742      24.663473          5.033699      10.074166
75%  77.14485044      30.093024          6.455118      12.104675
100% 99.98015247      50.482130          7.996707      19.484335
     temp_2010_cold_sd
0%            2.006105
25%           2.797981
50%           3.496788
75%           4.244186
100%          4.994085
```

#### PCA by domain summary

A summary of the PCA by domain in long format for easy plotting.

``` r
 my_results$pca_summary
# A tibble: 162 x 9
   domain  var      loading    pc pc_sd pc_var_prop pc_cum_var~1 corre~2 loadi~3
   <chr>   <chr>      <dbl> <int> <dbl>       <dbl>        <dbl>   <dbl>   <dbl>
 1 overall NO22010 -0.539       1 1.78       0.289         0.289      -1 0.539
 2 overall NO22010 -0.00723     2 1.07       0.105         0.394      -1 0.00723
 3 overall NO22010 -0.0162      3 1.03       0.0966        0.491      -1 0.0162 
 4 overall NO22010 -0.0191      4 1.01       0.0924        0.583      -1 0.0191
 5 overall NO22010 -0.00922     5 1.00       0.0911        0.674      -1 0.00922
 6 overall NO22010 -0.0161      6 0.984      0.0880        0.762      -1 0.0161 
 7 overall NO22010 -0.0157      7 0.960      0.0838        0.846      -1 0.0157
 8 overall NO22010 -0.00780     8 0.938      0.0799        0.926      -1 0.00780
 9 overall NO22010  0.149       9 0.664      0.0401        0.966       1 0.149
10 overall NO22010  0.147      10 0.533      0.0258        0.992       1 0.147  
# ... with 152 more rows, and abbreviated variable names 1: pc_cum_var_prop,
#   2: correction_factor, 3: loading_std

```

#### Associations with SES

The estimated coefficients for the linear models with each principal
component as outcome and the SES variable supplied to `ses_var`. There
is an option to include more variables using the `other_vars` argument
in `run_pca()`.

```{r}
my_results$ses_information
[1] "ses_cat_indv" "ses_cat_area"
```

``` r
my_results$pc_ses_models_1
# A tibble: 66 x 11
   outcome   pc    domain term  estim~1 std.e~2 stati~3  p.value conf.~4 conf.~5
   <chr>     <chr> <chr>  <chr>   <dbl>   <dbl>   <dbl>    <dbl>   <dbl>   <dbl>
 1 pc1_over~ 1     overa~ (Int~ -2.02    0.136  -14.9   1.47e-45  -2.29   -1.76
 2 pc1_over~ 1     overa~ ses_~  1.84    0.147   12.5   1.27e-33   1.55    2.13
 3 pc1_over~ 1     overa~ ses_~  3.71    0.168   22.0   1.00e-87   3.38    4.04 
 4 pc2_over~ 2     overa~ (Int~  0.545   0.0969   5.63  2.33e- 8   0.355   0.735
 5 pc2_over~ 2     overa~ ses_~ -0.487   0.105   -4.65  3.77e- 6  -0.692  -0.281
 6 pc2_over~ 2     overa~ ses_~ -1.03    0.120   -8.54  4.77e-17  -1.26   -0.791
 7 pc3_over~ 3     overa~ (Int~  0.0457  0.0967   0.473 6.36e- 1  -0.144   0.235
 8 pc3_over~ 3     overa~ ses_~ -0.0522  0.105   -0.500 6.17e- 1  -0.257   0.153
 9 pc3_over~ 3     overa~ ses_~ -0.0496  0.120   -0.414 6.79e- 1  -0.285   0.186
10 pc4_over~ 4     overa~ (Int~ -0.448   0.0924  -4.86  1.39e- 6  -0.630  -0.267
# ... with 56 more rows, 1 more variable: correction_factor <dbl>, and
#   abbreviated variable names 1: estimate, 2: std.error, 3: statistic,
#   4: conf.low, 5: conf.high

my_results$pc_ses_models_2
...
...
...

```

#### Package version

The version of the rexpanse1 package that was used to produce the
results.

``` r
 my_results$package_version
[1] "rexpanse1-0.0.0.9002"

```
