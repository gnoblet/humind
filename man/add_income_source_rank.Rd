% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_income_source_rank.R
\name{add_income_source_rank}
\alias{add_income_source_rank}
\title{Add Income Source Categories, Count, and Ranking Top 3}
\usage{
add_income_source_rank(
  df,
  emergency = c("cm_income_source_assistance_n", "cm_income_source_support_friends_n",
    "cm_income_source_donation_n"),
  unstable = c("cm_income_source_casual_n", "cm_income_source_social_benefits_n",
    "cm_income_source_rent_n", "cm_income_source_remittances_n"),
  stable = c("cm_income_source_salaried_n", "cm_income_source_own_business_n",
    "cm_income_source_own_production_n"),
  other = "cm_income_source_other_n",
  id_col = "uuid"
)
}
\arguments{
\item{df}{A data frame containing income source information.}

\item{emergency}{A vector of column names containing emergency income sources.}

\item{unstable}{A vector of column names containing unstable income sources.}

\item{stable}{A vector of column names containing stable income sources.}

\item{other}{The name of the column containing other income sources.}

\item{id_col}{The name of the column containing the unique identifier.}
}
\value{
A data frame with additional columns:
\itemize{
\item cm_income_source_emergency_n: Count of emergency income sources.
\item cm_income_source_unstable_n: Count of unstable income sources.
\item cm_income_source_stable_n: Count of stable income sources.
\item cm_income_source_other_n: Count of other income sources.
\item cm_income_source_top1: Top income source.
\item cm_income_source_top2: Second top income source.
\item cm_income_source_top3: Third top income source.
}
}
\description{
This function categorizes income sources, counts them by type, and ranks the top 3 income sources.
It also adds categories for emergency, unstable, stable, and other income sources.

Prerequisite function:
\itemize{
\item add_income_source_zero_to_sl.R
}
}
