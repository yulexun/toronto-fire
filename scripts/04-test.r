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
cleaned_data <- read_csv("data/analysis/cleaned_fire_data.csv", show_col_types = FALSE)

#### Test data ####
# test1: Tests that there is no empty value
test1 <-
  sum(is.na(cleaned_data)) == 0

print(test1)

# test2: Tests that there are 70 unique area of fire hazard origin
test2 <-
cleaned_data$area_of_origin |>
  unique() |>
  length() == 70

print(test2)

# test3: test if the cimivilian casualties and
# estimated dollar loss are non-negative
test3 <-
  cleaned_data$civilian_casualties |> min() >= 0
  cleaned_data$estimated_dollar_loss |> min() >= 0

print(test3)

# test4: 
test2 <-
cleaned_data$fire_alarm_system_presence|>
  unique()

print(test2)