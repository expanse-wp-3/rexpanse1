% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_pc_model.R
\name{fit_pc_model}
\alias{fit_pc_model}
\title{Fit PC and SES model}
\usage{
fit_pc_model(pca, pc_var, ses_var, other_vars)
}
\arguments{
\item{pca}{List containing the principal component analysis result
as obtained by get_pca() with \code{summary = FALSE} and \code{long = TRUE}.
The data in the list should also contain variables \code{ses_var} and
\code{other_vars} (if needed).}

\item{pc_var}{String indicating the name of the variable in \code{data}
corresponding to the relevant principal component, to be used
as the response variable in the regression model.}

\item{ses_var}{String indicating the name of the variable in \code{data}
corresponding to the relevant SES variable to be used as a predictor
in the linear regression model.}

\item{other_vars}{Character vector indicating any other variables in \code{data}
that need to be included in the model as covariates.}
}
\value{
A list.
}
\description{
Fit a linear regression model assessing relationship between principal components and SES.
}
\author{
Sergio Olmos
}
