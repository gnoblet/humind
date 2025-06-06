library(testthat)
library(dplyr)

# Create dummy data
df_dummy <- data.frame(
  snfi_shelter_type_cat = c("none", "inadequate", "adequate", "undefined", NA),
  snfi_shelter_issue_cat = c("none", "7_to_8", "4_to_6", "1_to_3", "undefined"),
  hlp_occupancy_cat = c("high_risk", "medium_risk", "low_risk", "undefined", NA),
  snfi_fds_cannot_cat = c("4_to_5_tasks", "2_to_3_tasks", "1_task", "none", "undefined")
)

# Define tests
test_that("comp_snfi function works correctly with default parameters", {
  result <- add_comp_snfi(df_dummy)
  expect_equal(result$comp_snfi_score_shelter_type_cat, c(5, 3, 1, NA, NA))
  expect_equal(result$comp_snfi_score_shelter_issue_cat, c(1, 4, 3, 2, NA))
  expect_equal(result$comp_snfi_score_occupancy_cat, c(3, 2, 1, NA, NA))
  expect_equal(result$comp_snfi_score_fds_cannot_cat, c(4, 3, 2, 1, NA))
  expect_equal(result$comp_snfi_score, c(5, 4, 3, 2, NA))
})

test_that("comp_snfi handles NA values correctly", {
  df_test <- df_dummy
  df_test$snfi_shelter_type_cat[1] <- NA
  result <- add_comp_snfi(df_test)
  expect_true(is.na(result$comp_snfi_score_shelter_type_cat[1]))
})

test_that("comp_snfi throws error for missing columns", {
  df_test <- df_dummy
  df_test <- df_test %>% select(-snfi_shelter_type_cat)
  expect_error(add_comp_snfi(df_test), class = "error")
})

test_that("comp_snfi assigns in need status correctly", {
  result <- add_comp_snfi(df_dummy)
  expect_equal(result$comp_snfi_in_need, c(1, 1, 1, 0, NA))
})


