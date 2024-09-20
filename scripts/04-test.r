#### Preamble ####
# Purpose: Test the cleaned data for
# missing values or incorrect data types
# Author: Lexun Yu
# Date: 16 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace Setup ####
library(tidyverse)
library(readr)

#### Read data ####
cleaned_data <- read_csv("data/analysis/cleaned_fire_data_simple.csv", show_col_types = FALSE)

#### Test data ####
# test1: Tests that there is no empty value
test1 <-
  sum(is.na(cleaned_data)) == 0

print(test1)

# test3: test if the
# estimated dollar loss are non-negative
test2 <-
  cleaned_data$estimated_dollar_loss |> min() >= 0

print(test2)

# test4, 5, 6: test if the fire alarm,
# smoke and sprinkler system value is simplified
test3 <-
  cleaned_data$fire_alarm_system_presence |>
    unique() == c("P", "N")

print(test3)

test4 <-
  cleaned_data$smoke_alarm_at_fire_origin |>
    unique() == c("PO", "N", "P")

print(test4)

test5 <-
  cleaned_data$sprinkler_system_operation |>
    unique() == c("P", "N", "PO")

print(test5)
