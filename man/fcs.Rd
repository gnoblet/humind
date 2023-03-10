% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fcs.R
\name{fcs}
\alias{fcs}
\title{FCS - Food Consumption Score}
\usage{
fcs(
  df,
  fcs_cereal = "fcs_cereal",
  fcs_legumes = "fcs_legumes",
  fcs_dairy = "fcs_dairy",
  fcs_meat = "fcs_meat",
  fcs_veg = "fcs_veg",
  fcs_fruit = "fcs_fruit",
  fcs_oil = "fcs_oil",
  fcs_sugar = "fcs_sugar",
  cat = "normal"
)
}
\arguments{
\item{df}{A data frame}

\item{fcs_cereal}{Cereals component column}

\item{fcs_legumes}{Legumes component column}

\item{fcs_dairy}{Dairy component column}

\item{fcs_meat}{Meat component column}

\item{fcs_veg}{Vegetables component column}

\item{fcs_fruit}{Fruit component column}

\item{fcs_oil}{Oil component column}

\item{fcs_sugar}{Sugar component column}

\item{cat}{Cut-offs categories, either "normal" (21.5/35) or "alternate" (28/42)}
}
\value{
Ten new columns: each component weight (fcs_w_), the score (fcs_score) and category (fcs_cat).
}
\description{
FCS - Food Consumption Score
}
