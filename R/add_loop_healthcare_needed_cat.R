#' @title Add Healthcare Needed Category to Individual Data
#'
#' @description This function adds healthcare need categories to individual-level data, including disability information if provided. It creates dummy variables for different healthcare need scenarios and optionally includes disability-specific indicators.
#' 
#' Prerequisite function:
#' 
#' * add_loop_wgq_ss.R - if WG-SS data collected
#'
#' @param loop A data frame of individual-level data.
#' @param ind_healthcare_needed The name of the variable that indicates if healthcare is needed.
#' @param ind_healthcare_needed_no Level for "no" in ind_healthcare_needed.
#' @param ind_healthcare_needed_yes Level for "yes" in ind_healthcare_needed.
#' @param ind_healthcare_needed_dnk Level for "don't know" in ind_healthcare_needed.
#' @param ind_healthcare_needed_pnta Level for "prefer not to answer" in ind_healthcare_needed.
#' @param ind_healthcare_received The name of the variable that indicates if healthcare is received.
#' @param ind_healthcare_received_no Level for "no" in ind_healthcare_received.
#' @param ind_healthcare_received_yes Level for "yes" in ind_healthcare_received.
#' @param ind_healthcare_received_dnk Level for "don't know" in ind_healthcare_received.
#' @param ind_healthcare_received_pnta Level for "prefer not to answer" in ind_healthcare_received.
#' @param wgq_dis The name of the variable that indicates if the individual has a disability (usual cut-offs are 3).
#' @param ind_age The name of the variable that indicates the age of the individual.
#'
#'
#' @return A data frame with additional columns:
#' 
#' * health_ind_healthcare_needed_d: Dummy variable for healthcare needed.
#' * health_ind_healthcare_received_d: Dummy variable for healthcare received.
#' * health_ind_healthcare_needed_cat: Categorized healthcare need: "no_need", "yes_unmet_need", or "yes_met_need".
#' * health_ind_healthcare_needed_no: Dummy variable for no healthcare need.
#' * health_ind_healthcare_needed_yes_unmet: Dummy variable for unmet healthcare need.
#' * health_ind_healthcare_needed_yes_met: Dummy variable for met healthcare need.
#' * health_ind_healthcare_needed_no_wgq_dis: Dummy variable for no healthcare need with disability (if wgq_dis provided).
#' * health_ind_healthcare_needed_yes_unmet_wgq_dis: Dummy variable for unmet healthcare need with disability (if wgq_dis provided).
#' * health_ind_healthcare_needed_yes_met_wgq_dis: Dummy variable for met healthcare need with disability (if wgq_dis provided).
#'
#' @export
add_loop_healthcare_needed_cat <- function(
    loop,
    ind_healthcare_needed = "health_ind_healthcare_needed",
    ind_healthcare_needed_no = "no",
    ind_healthcare_needed_yes = "yes",
    ind_healthcare_needed_dnk = "dnk",
    ind_healthcare_needed_pnta = "pnta",
    ind_healthcare_received = "health_ind_healthcare_received",
    ind_healthcare_received_no = "no",
    ind_healthcare_received_yes = "yes",
    ind_healthcare_received_dnk = "dnk",
    ind_healthcare_received_pnta = "pnta",
    wgq_dis = NULL,
    ind_age = "ind_age"){

  #------ Checks

  # Check if the variables are in the data frame
  if_not_in_stop(loop, c(ind_healthcare_needed, ind_healthcare_received), "loop")
  if (!is.null(wgq_dis)) if_not_in_stop(loop, c(wgq_dis, ind_age), "loop")

  # Create levels vectors
  ind_healthcare_needed_levels <- c(ind_healthcare_needed_no, ind_healthcare_needed_yes, ind_healthcare_needed_dnk, ind_healthcare_needed_pnta)
  ind_healthcare_received_levels <- c(ind_healthcare_received_no, ind_healthcare_received_yes, ind_healthcare_received_dnk, ind_healthcare_received_pnta)

  # Check that values are in set
  are_values_in_set(loop, ind_healthcare_needed, ind_healthcare_needed_levels)
  are_values_in_set(loop, ind_healthcare_received, ind_healthcare_received_levels)

  # Check that wgq_dis have values in set 1 and 0, and if ind_age is below 5, then wgq_dis should be NA
  if (!is.null(wgq_dis)) {
    are_values_in_set(loop, wgq_dis, c(0, 1))
    if (any(loop[[ind_age]] < 5 & !is.na(loop[[wgq_dis]]))) {
      rlang::abort("If ind_age is below 5, then wgq_dis should be NA.")
    }
  }

  # Warn if health_ind_healthcare_needed_d exists in loop and will be replaced
  if ("health_ind_healthcare_needed_d" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_d already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_cat
  if ("health_ind_healthcare_needed_cat" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_cat already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_no exists in loop and will be replaced
  if ("health_ind_healthcare_needed_no" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_no already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_yes_unmet exists in loop and will be replaced
  if ("health_ind_healthcare_needed_yes_unmet" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_yes_unmet already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_yes_met exists in loop and will be replaced
  if ("health_ind_healthcare_needed_yes_met" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_yes_met already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_no_wgq_dis exists in loop and will be replaced
  if (!is.null(wgq_dis) & "health_ind_healthcare_needed_no_wgq_dis" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_no_wgq_dis already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_yes_unmet_wgq_dis exists in loop and will be replaced
  if (!is.null(wgq_dis) & "health_ind_healthcare_needed_yes_unmet_wgq_dis" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_yes_unmet_wgq_dis already exists in loop. It will be replaced.")
  }

  # Warn if health_ind_healthcare_needed_yes_met_wgq_dis exists in loop and will be replaced
  if (!is.null(wgq_dis) & "health_ind_healthcare_needed_yes_met_wgq_dis" %in% colnames(loop)) {
    rlang::warn("health_ind_healthcare_needed_yes_met_wgq_dis already exists in loop. It will be replaced.")
  }

  #------ Compute

  # Calculate dummy variables
  loop <- dplyr::mutate(
    loop,
    health_ind_healthcare_needed_d = dplyr::case_when(
      !!rlang::sym(ind_healthcare_needed) == ind_healthcare_needed_no ~ 0,
      !!rlang::sym(ind_healthcare_needed) == ind_healthcare_needed_yes ~ 1,
      !!rlang::sym(ind_healthcare_needed) %in% c(ind_healthcare_needed_dnk, ind_healthcare_needed_pnta) ~ NA_real_,
      .default = NA_real_),
    health_ind_healthcare_received_d = dplyr::case_when(
      !!rlang::sym(ind_healthcare_received) == ind_healthcare_received_no ~ 0,
      !!rlang::sym(ind_healthcare_received) == ind_healthcare_received_yes ~ 1,
      !!rlang::sym(ind_healthcare_received) %in% c(ind_healthcare_received_dnk, ind_healthcare_received_pnta) ~ NA_real_,
      .default = NA_real_)
  )

  # Add final recoding
  loop <- dplyr::mutate(
    loop,
    health_ind_healthcare_needed_cat = dplyr::case_when(
      health_ind_healthcare_needed_d == 0 ~ "no_need",
      health_ind_healthcare_needed_d == 1 & health_ind_healthcare_received_d == 0 ~ "yes_unmet_need",
      health_ind_healthcare_needed_d == 1 & health_ind_healthcare_received_d == 1 ~ "yes_met_need",
      .default = NA_character_
    )
  )

  # Add dummy for each (no NA)
  loop <- dplyr::mutate(
    loop,
    health_ind_healthcare_needed_no = dplyr::case_when(
      health_ind_healthcare_needed_cat == "no_need" ~ 1,
      health_ind_healthcare_needed_cat %in% c("yes_met_need", "yes_unmet_need") ~ 0,
      .default = 0
    ),
    health_ind_healthcare_needed_yes_unmet = dplyr::case_when(
      health_ind_healthcare_needed_cat == "yes_unmet_need" ~ 1,
      health_ind_healthcare_needed_cat %in% c("no_need", "yes_met_need") ~ 0,
      .default = 0
    ),
    health_ind_healthcare_needed_yes_met = dplyr::case_when(
      health_ind_healthcare_needed_cat == "yes_met_need" ~ 1,
      health_ind_healthcare_needed_cat %in% c("no_need", "yes_unmet_need") ~ 0,
      .default = 0
    )
  )

  # If wgq_dis is not null had dummy if wgq_dis is 1
  if (!is.null(wgq_dis)) {
    loop <- dplyr::mutate(
      loop,
      health_ind_healthcare_needed_no_wgq_dis = dplyr::case_when(
        health_ind_healthcare_needed_no == 1 & !!rlang::sym(wgq_dis) == 1 ~ 1,
        health_ind_healthcare_needed_no == 1 & !!rlang::sym(wgq_dis) == 0 ~ 0,
        health_ind_healthcare_needed_no == 0 ~ 0,
        .default = 0
      ),
      health_ind_healthcare_needed_yes_unmet_wgq_dis = dplyr::case_when(
        health_ind_healthcare_needed_yes_unmet == 1 & !!rlang::sym(wgq_dis) == 1 ~ 1,
        health_ind_healthcare_needed_yes_unmet == 1 & !!rlang::sym(wgq_dis) == 0 ~ 0,
        health_ind_healthcare_needed_yes_unmet == 0 ~ 0,
        .default = 0
      ),
      health_ind_healthcare_needed_yes_met_wgq_dis = dplyr::case_when(
        health_ind_healthcare_needed_yes_met == 1 & !!rlang::sym(wgq_dis) == 1 ~ 1,
        health_ind_healthcare_needed_yes_met == 1 & !!rlang::sym(wgq_dis) == 0 ~ 0,
        health_ind_healthcare_needed_yes_met == 0 ~ 0,
        .default = 0
      )
    )
  }

  return(loop)
}


#' @rdname add_loop_healthcare_needed_cat
#'
#' @title Add Healthcare Needed Categories to Main Dataset
#' @description This function aggregates individual-level healthcare need data to the household level, including disability-specific information if provided.
#'
#' @param main A data frame of household-level data.
#' @param loop A data frame of individual-level data.
#' @param ind_healthcare_needed_no The binary variable that indicates if healthcare is not needed.
#' @param ind_healthcare_needed_yes_unmet The binary variable that indicates if healthcare is needed but unmet.
#' @param ind_healthcare_needed_yes_met The binary variable that indicates if healthcare is needed and met.
#' @param ind_healthcare_needed_no_wgq_dis The binary variable that indicates if healthcare is not needed and the individual has a disability.
#' @param ind_healthcare_needed_yes_unmet_wgq_dis The binary variable that indicates if healthcare is needed but unmet and the individual has a disability.
#' @param ind_healthcare_needed_yes_met_wgq_dis The binary variable that indicates if healthcare is needed and met and the individual has a disability.
#' @param id_col_main The column name for the unique identifier in the main data frame.
#' @param id_col_loop The column name for the unique identifier in the loop data frame.
#'
#' @return A data frame with additional columns:
#' 
#' * health_ind_healthcare_needed_no_n: Count of individuals not needing healthcare.
#' * health_ind_healthcare_needed_yes_unmet_n: Count of individuals with unmet healthcare needs.
#' * health_ind_healthcare_needed_yes_met_n: Count of individuals with met healthcare needs.
#' * health_ind_healthcare_needed_no_wgq_dis_n: Count of individuals with disabilities not needing healthcare (if applicable).
#' * health_ind_healthcare_needed_yes_unmet_wgq_dis_n: Count of individuals with disabilities and unmet healthcare needs (if applicable).
#' * health_ind_healthcare_needed_yes_met_wgq_dis_n: Count of individuals with disabilities and met healthcare needs (if applicable).
#'
#' @export
add_loop_healthcare_needed_cat_to_main <- function(
    main,
    loop,
    ind_healthcare_needed_no = "health_ind_healthcare_needed_no",
    ind_healthcare_needed_yes_unmet = "health_ind_healthcare_needed_yes_unmet",
    ind_healthcare_needed_yes_met = "health_ind_healthcare_needed_yes_met",
    ind_healthcare_needed_no_wgq_dis = NULL,
    ind_healthcare_needed_yes_unmet_wgq_dis = NULL,
    ind_healthcare_needed_yes_met_wgq_dis = NULL,
    id_col_main = "uuid",
    id_col_loop = "uuid"){

  #------ Checks

  # Check if vars are in loop
  vars <- c(ind_healthcare_needed_no, ind_healthcare_needed_yes_unmet, ind_healthcare_needed_yes_met)
  if_not_in_stop(loop, vars, "loop")
  if (!is.null(ind_healthcare_needed_no_wgq_dis)) if_not_in_stop(loop, c(ind_healthcare_needed_no_wgq_dis), "loop")
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) if_not_in_stop(loop, c(ind_healthcare_needed_yes_unmet_wgq_dis), "loop")
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) if_not_in_stop(loop, c(ind_healthcare_needed_yes_met_wgq_dis), "loop")

  # Check if id_cols are in df
  if_not_in_stop(main, id_col_main, "main")
  if_not_in_stop(loop, id_col_loop, "loop")

  # Check if values are in set
  are_values_in_set(loop, vars, c(0, 1))
  if (!is.null(ind_healthcare_needed_no_wgq_dis)) are_values_in_set(loop, ind_healthcare_needed_no_wgq_dis, c(0, 1))
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) are_values_in_set(loop, ind_healthcare_needed_yes_unmet_wgq_dis, c(0, 1))
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) are_values_in_set(loop, ind_healthcare_needed_yes_met_wgq_dis, c(0, 1))

  # Create new colnames
  vars_n <- paste0(vars, "_n")

  # Same for dis if not null
  if (!is.null(ind_healthcare_needed_no_wgq_dis)) new_colname_no_wgq_dis <- paste0(ind_healthcare_needed_no_wgq_dis, "_n")
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) new_colname_yes_unmet_wgq_dis <- paste0(ind_healthcare_needed_yes_unmet_wgq_dis, "_n")
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) new_colname_yes_met_wgq_dis <- paste0(ind_healthcare_needed_yes_met_wgq_dis, "_n")

  # Check if all these colnames are in main and throw a warning if they are
  if (vars_n[1] %in% colnames(main)) rlang::warn(paste0(vars_n[1], " already exists in 'main'. It will be replaced."))
  if (vars_n[2] %in% colnames(main)) rlang::warn(paste0(vars_n[2], " already exists in 'main'. It will be replaced."))
  if (vars_n[3] %in% colnames(main)) rlang::warn(paste0(vars_n[3], " already exists in 'main'. It will be replaced."))

  if (!is.null(ind_healthcare_needed_no_wgq_dis)) {
    if (ind_healthcare_needed_no_wgq_dis %in% colnames(main)) rlang::warn(paste0(ind_healthcare_needed_no_wgq_dis, " already exists in 'main'. It will be replaced."))
  }
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) {
    if (ind_healthcare_needed_yes_unmet_wgq_dis %in% colnames(main)) rlang::warn(paste0(ind_healthcare_needed_yes_unmet_wgq_dis, " already exists in 'main'. It will be replaced."))
  }
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) {
    if (ind_healthcare_needed_yes_met_wgq_dis %in% colnames(main)) rlang::warn(paste0(ind_healthcare_needed_yes_met_wgq_dis, " already exists in 'main'. It will be replaced."))
  }

  #------ Compute

  # Group loop by id_col_loop
  loop <- dplyr::group_by(loop, !!rlang::sym(id_col_loop))

  # Sum the dummy variable
  loop_vars <- dplyr::summarize(
    loop,
    dplyr::across(
      dplyr::all_of(vars),
      \(x) sum(x, na.rm = TRUE),
      .names = "{.col}_n")
  )

  # Sum the dis dummy variable (if not null)
  if (!is.null(ind_healthcare_needed_no_wgq_dis)) {
    loop_no_wgq_dis <- dplyr::summarize(
      loop,
      "{new_colname_no_wgq_dis}" := sum(!!rlang::sym(ind_healthcare_needed_no_wgq_dis), na.rm = TRUE)
    )
  }
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) {
    loop_yes_unmet_wgq_dis <- dplyr::summarize(
      loop,
      "{new_colname_yes_unmet_wgq_dis}" := sum(!!rlang::sym(ind_healthcare_needed_yes_unmet_wgq_dis), na.rm = TRUE)
    )
  }
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) {
    loop_yes_met_wgq_dis <- dplyr::summarize(
      loop,
      "{new_colname_yes_met_wgq_dis}" := sum(!!rlang::sym(ind_healthcare_needed_yes_met_wgq_dis), na.rm = TRUE)
    )
  }

  # Get existing data frames to bind
  df_names <- c("loop_no_wgq_dis", "loop_yes_unmet_wgq_dis", "loop_yes_met_wgq_dis")

  # Bind rows
  loop <- loop_vars
  if (!is.null(ind_healthcare_needed_no_wgq_dis)) loop <- dplyr::left_join(loop, loop_no_wgq_dis, by = dplyr::join_by(!!rlang::sym(id_col_loop)))
  if (!is.null(ind_healthcare_needed_yes_unmet_wgq_dis)) loop <- dplyr::left_join(loop, loop_yes_unmet_wgq_dis, by = dplyr::join_by(!!rlang::sym(id_col_loop)))
  if (!is.null(ind_healthcare_needed_yes_met_wgq_dis)) loop <- dplyr::left_join(loop, loop_yes_met_wgq_dis, by = dplyr::join_by(!!rlang::sym(id_col_loop)))

  # Remove columns in main that exists in loop, but the grouping ones
  cols_uuids <- c(id_col_main, id_col_loop)
  cols_from_loop_in_main <- intersect(colnames(loop), colnames(main))
  cols_from_loop_in_main <- setdiff(cols_from_loop_in_main, cols_uuids)
  main <- dplyr::select(main, -dplyr::all_of(cols_from_loop_in_main))
  # Need a change of behavior of df_diff towards: if it exists, keep them and no need to remove from df_b
  # main <- impactR.utils::df_diff(main, loop, !!rlang::sym(id_col_main))

  # Join the data
  main <- dplyr::left_join(main, loop, by = dplyr::join_by(!!rlang::sym(id_col_main) == !!rlang::sym(id_col_loop)))

  return(main)

}
