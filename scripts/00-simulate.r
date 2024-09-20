#### Preamble ####
# Purpose: Simulation of Toronto Fire Incident
# Author: Lexun Yu
# Date: 12 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(dplyr)
library(lubridate)

#### Simulate Data ####
# number of rows to simulate
n <- 100

# Generate random alarm times (dates within the last 5 years)
set.seed(123)
alarm_times <- sample(seq(ymd_hms("2018-01-01 00:00:00"),
  ymd_hms("2023-01-01 00:00:00"),
  by = "min"
), n, replace = TRUE)

# Generate random time differences for arrival times
time_diff <- runif(n, min = 2, max = 10)

# Calculate arrival times based on alarm times and time difference
arrival_times <- alarm_times + time_diff * 60

# Simulate categorical columns
area_of_origin <- sample(c(
  "24 - Cooking Area or Kitchen",
  "12 - Hallway, Corridor",
  "79 - Other Outside Area"
), n, replace = TRUE)

extent_of_fire <- sample(c(
  "1 - Confined to object of origin",
  "2 - Confined to part of room/area of origin"
), n, replace = TRUE)

ignition_source <- sample(c(
  "41 - Other Heating Equipment",
  "11 - Stove, Range-top burner",
  "24 - Circuit Wiring - Copper"
), n, replace = TRUE)

fire_alarm_system_presence <- sample(c("P", "N"), n, replace = TRUE)
smoke_alarm_at_fire_origin <- sample(c("PO", "N", "p"), n, replace = TRUE)
sprinkler_system_operation <- sample(c("P", "N", "PO"), n, replace = TRUE)

# Simulate numerical columns
estimated_dollar_loss <- sample(0:60000, n, replace = TRUE)

# Create the simulated dataframe
simulated_data <- data.frame(
  tfs_alarm_time = alarm_times,
  tfs_arrival_time = arrival_times,
  area_of_origin = area_of_origin,
  estimated_dollar_loss = estimated_dollar_loss,
  extent_of_fire = extent_of_fire,
  fire_alarm_system_presence = fire_alarm_system_presence,
  ignition_source = ignition_source,
  smoke_alarm_at_fire_origin = smoke_alarm_at_fire_origin,
  sprinkler_system_operation = sprinkler_system_operation,
  time_diff = time_diff
)

# View the first few rows of the simulated data
head(simulated_data)
