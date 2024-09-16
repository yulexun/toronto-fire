#### Preamble ####
# Purpose: Cleans the raw fire incident data by renaming the headers and
# deleting columns that are not related to the research question. Moreover,
# invalid data including undetermined cause of fire, or empty data are deleted
# entirely.
# Author: Lexun Yu
# Date: 16 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Data Cleaning ####
raw_fire_data <- read.csv("data/raw/toronto_fire_incidents.csv")

cleaned_fire_data <-
  raw_fire_data |>
  janitor::clean_names()

selected_cleaned_fire_data <-
  cleaned_fire_data |>
  select(
    tfs_alarm_time,
    tfs_arrival_time,
    area_of_origin,
    civilian_casualties,
    estimated_dollar_loss,
    extent_of_fire,
    fire_alarm_system_presence,
    ignition_source,
    smoke_alarm_at_fire_origin,
    sprinkler_system_operation
  ) |>
  drop_na()

# Convert every column to character
selected_cleaned_fire_data <-
  selected_cleaned_fire_data %>% mutate(across(everything(), as.character))

# Replace multiple specific values with NA
selected_cleaned_fire_data <- selected_cleaned_fire_data %>%
  mutate(across(everything(), ~ na_if(., ""))) %>%
  mutate(across(everything(), ~ na_if(
    ., "99 - Undetermined  (formerly 98)"
  ))) %>%
  mutate(across(everything(), ~ na_if(., "990 - Under Investigation"))) %>%
  mutate(across(everything(), ~ na_if(., "97 - Other - unclassified"))) %>%
  mutate(across(everything(), ~ na_if(., "99 - Undetermined"))) %>%
  mutate(across(everything(), ~ na_if(., "9 - Undetermined"))) %>%
  mutate(across(everything(), ~ na_if(
    .,
    "8 - Not applicable (bldg not classified by OBC OR detached/semi/town home)"
  ))) %>%
  mutate(across(everything(), ~ na_if(., "999 - Undetermined"))) %>%
  mutate(across(everything(), ~ na_if(., "9990 - Under Investigation"))) %>%
  mutate(across(everything(), ~ na_if(., "98 - Other"))) %>%
  mutate(across(everything(), ~ na_if(
    ., "9 - Floor/suite of fire origin: Smoke alarm presence undetermined"
  ))) %>%
  mutate(across(everything(), ~ na_if(
    ., "9 - Smoke alarm presence undetermined                       "
  ))) %>%
  mutate(across(everything(), ~ na_if(
    ., "9 - Activation/operation undetermined"
  )))

# Convert columns 'civilian_casualties'
# and 'estimated_dollar_loss' back to numeric
selected_cleaned_fire_data <- selected_cleaned_fire_data %>%
  mutate(
    civilian_casualties = as.numeric(civilian_casualties),
    estimated_dollar_loss = as.numeric(estimated_dollar_loss)
  ) %>%
  drop_na() # Remove rows with NA values

# Preview the cleaned data
head(selected_cleaned_fire_data)

# Write the cleaned data to a new csv
write.csv(
  x = selected_cleaned_fire_data,
  file = "data/analyzed/cleaned_fire_data.csv"
)
