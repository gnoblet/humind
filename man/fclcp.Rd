% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fclcp.R
\name{fclcp}
\alias{fclcp}
\title{FEWS NET Food Consumption-Livelihood Coping Phase}
\usage{
fclcp(
  df,
  fcp,
  lcsi_cat,
  lcsi_levels = c("None", "Stress", "Crisis", "Emergency")
)
}
\arguments{
\item{df}{A data frame.}

\item{fcp}{The food consumption phase column.}

\item{lcsi_cat}{The Livelihood Coping Strategies categories column.}

\item{lcsi_levels}{LCSI levels in that order: "None", "Stress", "Crisis", "Emergency.}
}
\value{
Two new columns with the FEWS NET Food Consumption-Livelihood Coping matrix phases: numbers (fclp) and categories (fclp_cat).
}
\description{
FEWS NET Food Consumption-Livelihood Coping Phase
}
