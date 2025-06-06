% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_msni.R
\name{add_msni}
\alias{add_msni}
\title{Add Multi-Sectoral Needs Index (MSNI) Score and Related Indicators}
\usage{
add_msni(
  df,
  comp_foodsec_score = "comp_foodsec_score",
  comp_snfi_score = "comp_snfi_score",
  comp_wash_score = "comp_wash_score",
  comp_prot_score = "comp_prot_score",
  comp_health_score = "comp_health_score",
  comp_edu_score = "comp_edu_score",
  comp_foodsec_in_need = "comp_foodsec_in_need",
  comp_snfi_in_need = "comp_snfi_in_need",
  comp_wash_in_need = "comp_wash_in_need",
  comp_prot_in_need = "comp_prot_in_need",
  comp_health_in_need = "comp_health_in_need",
  comp_edu_in_need = "comp_edu_in_need"
)
}
\arguments{
\item{df}{A data frame containing sectoral composite scores and in-need indicators.}

\item{comp_foodsec_score}{Column name for the food security composite score.}

\item{comp_snfi_score}{Column name for the SNFI composite score.}

\item{comp_wash_score}{Column name for the WASH composite score.}

\item{comp_prot_score}{Column name for the protection composite score.}

\item{comp_health_score}{Column name for the health composite score.}

\item{comp_edu_score}{Column name for the education composite score.}

\item{comp_foodsec_in_need}{Column name for food security in need.}

\item{comp_snfi_in_need}{Column name for SNFI in need.}

\item{comp_wash_in_need}{Column name for WASH in need.}

\item{comp_prot_in_need}{Column name for protection in need.}

\item{comp_health_in_need}{Column name for health in need.}

\item{comp_edu_in_need}{Column name for education in need.}
}
\value{
A data frame with 5 new columns:
\itemize{
\item msni_score: The Multi-Sectoral Needs Index score.
\item msni_in_need: Binary indicator for households in need.
\item msni_in_acute_need: Binary indicator for households in acute need.
\item sector_in_need_n: Number of sectoral needs identified.
\item sector_needs_profile: Profile of sectoral needs identified (NA if no sectoral need is identified).
}
}
\description{
This function calculates the MSNI score, determines if households are in need or acute need, counts the number of sectoral needs, and creates a sectoral needs profile.

Prerequisite functions:
\itemize{
\item add_comp_edu.R
\item add_comp_foodsec.R
\item add_comp_health.R
\item add_comp_prot.R
\item add_comp_snfi.R
\item add_comp_wash.R
}
}
