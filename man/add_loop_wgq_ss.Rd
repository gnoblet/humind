% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_loop_wgq_ss.R
\name{add_loop_wgq_ss}
\alias{add_loop_wgq_ss}
\alias{add_loop_wgq_ss_to_main}
\title{Prepare Washington Group Short Set (WG-SS) Disability Indicators}
\usage{
add_loop_wgq_ss(
  loop,
  ind_age = "ind_age",
  vision = "wgq_vision",
  hearing = "wgq_hearing",
  mobility = "wgq_mobility",
  cognition = "wgq_cognition",
  self_care = "wgq_self_care",
  communication = "wgq_communication",
  no_difficulty = "no_difficulty",
  some_difficulty = "some_difficulty",
  lot_of_difficulty = "lot_of_difficulty",
  cannot_do = "cannot_do",
  undefined = c("dnk", "pnta")
)

add_loop_wgq_ss_to_main(
  main,
  loop,
  wgq_dis_4 = "wgq_dis_4",
  wgq_dis_3 = "wgq_dis_3",
  wgq_dis_2 = "wgq_dis_2",
  wgq_dis_1 = "wgq_dis_1",
  ind_age_above_5 = "ind_age_above_5",
  id_col_main = "uuid",
  id_col_loop = "uuid"
)
}
\arguments{
\item{loop}{A data frame of individual-level data.}

\item{ind_age}{The individual age column.}

\item{vision}{Vision component column.}

\item{hearing}{Hearing component column.}

\item{mobility}{Mobility component column.}

\item{cognition}{Cognition component column.}

\item{self_care}{Self-care component column.}

\item{communication}{Communication component column.}

\item{no_difficulty}{Level for no difficulty.}

\item{some_difficulty}{Level for some difficulty.}

\item{lot_of_difficulty}{Level for a lot of difficulty.}

\item{cannot_do}{Level for cannot do at all.}

\item{undefined}{Vector of undefined responses, such as Prefer not to answer and Don't know.}

\item{main}{A data frame of household-level data.}

\item{wgq_dis_4}{Column name for the disability 4 cut-offs binary.}

\item{wgq_dis_3}{Column name for the disability 3 cut-offs binary.}

\item{wgq_dis_2}{Column name for the disability 2 cut-offs binary.}

\item{wgq_dis_1}{Column name for the disability 1 cut-offs binary.}

\item{ind_age_above_5}{Column name for the age above 5 dummy in the individual-level dataset.}

\item{id_col_main}{Column name for the unique identifier in the main dataset.}

\item{id_col_loop}{Column name for the unique identifier in the loop dataset.}
}
\value{
A data frame with additional columns:
\itemize{
\item *_cannot_do_d: Binary indicators for "cannot do" level for each component.
\item *_lot_of_difficulty_d: Binary indicators for "a lot of difficulty" level for each component.
\item *_some_difficulty_d: Binary indicators for "some difficulty" level for each component.
\item *_no_difficulty_d: Binary indicators for "no difficulty" level for each component.
\item wgq_cannot_do_n: Sum of "cannot do" indicators across all components.
\item wgq_lot_of_difficulty_n: Sum of "a lot of difficulty" indicators across all components.
\item wgq_some_difficulty_n: Sum of "some difficulty" indicators across all components.
\item wgq_no_difficulty_n: Sum of "no difficulty" indicators across all components.
\item wgq_cannot_do_d: Binary indicator for any "cannot do" across all components.
\item wgq_lot_of_difficulty_d: Binary indicator for any "a lot of difficulty" across all components.
\item wgq_some_difficulty_d: Binary indicator for any "some difficulty" across all components.
\item wgq_no_difficulty_d: Binary indicator for any "no difficulty" across all components.
\item wgq_dis_4: Disability cut-off 4: any domain coded as "cannot do at all".
\item wgq_dis_3: Disability cut-off 3: any domain coded as "a lot of difficulty" or "cannot do at all".
\item wgq_dis_2: Disability cut-off 2: at least 2 domains coded as "some difficulty" or any domain coded as "a lot of difficulty" or "cannot do at all".
\item wgq_dis_1: Disability cut-off 1: at least one domain coded as "some difficulty", "a lot of difficulty", or "cannot do at all".
}
}
\description{
This function prepares dummy variables for each WG-SS component (vision, hearing, mobility, cognition, self-care, communication) and their levels (no difficulty, some difficulty, a lot of difficulty, cannot do at all). It combines them into sum scores for each level and creates disability binary cut-offs variables.
}
