% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_access_to_phone_best.R
\name{add_access_to_phone_best}
\alias{add_access_to_phone_best}
\alias{add_access_to_phone_coverage}
\title{Add Best Phone Access and Coverage Information}
\usage{
add_access_to_phone_best(
  df,
  access_to_phone = "etc_access_to_phone",
  none = "none",
  smartphone = "smartphone",
  feature_phone = "feature_phone",
  basic_phone = "basic_phone",
  dnk = "dnk",
  pnta = "pnta",
  sep = "/"
)

add_access_to_phone_coverage(
  df,
  coverage_network_type = "etc_coverage_network_type",
  coverage_none = "no_coverage",
  coverage_no_internet = c("only_sms", "voice_sms", "only_voice"),
  coverage_yes_internet = c("voice_sms_internet", "only_internet"),
  coverage_undefined = c("dnk", "pnta"),
  access_to_phone_best = "etc_access_to_phone_best",
  access_to_phone_none = "none",
  access_to_basic_phone = "basic_phone",
  access_to_feature_phone = "feature_phone",
  access_to_smartphone = "smartphone",
  access_to_undefined = "undefined"
)
}
\arguments{
\item{df}{The input data frame}

\item{access_to_phone}{The name of the column that contains the access to phone information.}

\item{none}{The value for no phone.}

\item{smartphone}{The value for smartphone.}

\item{feature_phone}{The value for feature phone.}

\item{basic_phone}{The value for basic phone.}

\item{dnk}{The value for do not know.}

\item{pnta}{The value for prefer not to answer.}

\item{sep}{Separator for the binary columns.}

\item{coverage_network_type}{Network coverage column.}

\item{coverage_none}{Value for no coverage.}

\item{coverage_no_internet}{Vector of values for no internet.}

\item{coverage_yes_internet}{Value for yes internet.}

\item{coverage_undefined}{Vector of values for do not know.}

\item{access_to_phone_best}{The name of the column that contains the access to phone information.}

\item{access_to_phone_none}{Value for no phone.}

\item{access_to_basic_phone}{Value for basic phone.}

\item{access_to_feature_phone}{Value for feature phone.}

\item{access_to_smartphone}{Value for smartphone.}

\item{access_to_undefined}{Value for undefined.}
}
\value{
A data frame with an additional column 'etc_access_to_phone_best' containing the recoded best type of phone accessible.

A data frame with an additional column 'etc_access_to_phone_coverage' containing the recoded coverage and phone access information.
}
\description{
This function recodes the best type of phone accessible in the household and the coverage network type.
It provides two main functions:
\enumerate{
\item \code{add_access_to_phone_best()}: Recodes the best type of phone accessible in the household.
\item \code{add_access_to_phone_coverage()}: Recodes the coverage network type and the best type of phone owned in the household.
}
}
