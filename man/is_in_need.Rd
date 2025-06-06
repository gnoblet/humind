% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_in_need.R
\name{is_in_need}
\alias{is_in_need}
\alias{is_in_acute_need}
\title{Add Dummy Variable for 'In Need' Status}
\usage{
is_in_need(df, score, new_colname = NULL)

is_in_acute_need(df, score, new_colname = NULL)
}
\arguments{
\item{df}{A dataframe containing the score variable.}

\item{score}{The variable containing the score on a 1-5 scale.}

\item{new_colname}{The name of the new column. If NULL, the function will create a new column with the name 'score_in_need' or 'score_in_acute_need'.}
}
\value{
A dataframe with an additional column:
\itemize{
\item new_colname: A binary variable indicating if the score meets the threshold for being "in need" (1) or not (0).
}
}
\description{
This set of functions adds new binary variables indicating if a score is above certain thresholds. \code{\link[=is_in_need]{is_in_need()}} adds a variable for scores above 3 (indicating "in need"), while \code{\link[=is_in_acute_need]{is_in_acute_need()}} adds a variable for scores above 4 (indicating "in acute need").
}
