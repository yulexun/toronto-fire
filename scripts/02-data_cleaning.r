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
library(lubridate)
library(readr)


#### Data Cleaning ####
raw_fire_data <- read_csv("data/raw/toronto_fire_incidents.csv")

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
    ., "9 - Smoke alarm presence undetermined"
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

# # Convert str to factor
# selected_cleaned_fire_data <-
#   selected_cleaned_fire_data %>%
#   mutate_at(vars(
#     area_of_origin, extent_of_fire,
#     fire_alarm_system_presence, ignition_source,
#     smoke_alarm_at_fire_origin, sprinkler_system_operation
#   ), as.factor)

# Convert time
selected_cleaned_fire_data$tfs_alarm_time <-
  ymd_hms(selected_cleaned_fire_data$tfs_alarm_time)
selected_cleaned_fire_data$tfs_arrival_time <-
  ymd_hms(selected_cleaned_fire_data$tfs_arrival_time)

# Calculate the time difference in minutes
selected_cleaned_fire_data$time_diff <-
  difftime(selected_cleaned_fire_data$tfs_arrival_time,
    selected_cleaned_fire_data$tfs_alarm_time,
    units = "mins"
  )

# Simplify the presence and operation of fie alarm system,
# smoke detector and sprinkler system
cleaned_fire_data_simple <-
  selected_cleaned_fire_data |>
  mutate(
    smoke_alarm_at_fire_origin =
      case_match(
        smoke_alarm_at_fire_origin,
        "2 - Floor/suite of fire origin: Smoke alarm present and operated"
        ~ "PO",
        "1 - Floor/suite of fire origin: No smoke alarm" ~ "N",
        "2 - Smoke alarm present and operated" ~ "PO",
        "1 - No smoke alarm" ~ "N",
        "3 - Floor/suite of fire origin: Smoke alarm present did not operate"
        ~ "P",
        "4 - Floor/suite of fire origin: Smoke alarm present, operation undetermined"
        ~ "P",
        "4 - Smoke alarm present, operation undetermined" ~ "P",
        "3 - Smoke alarm present did not operate" ~ "P"
      )
  )

cleaned_fire_data_simple <-
  cleaned_fire_data_simple |>
  mutate(
    sprinkler_system_operation =
      case_match(
        sprinkler_system_operation,
        "1 - Sprinkler system activated"
        ~ "PO",
        "8 - Not applicable - no sprinkler system present" ~ "N",
        "3 - Did not activate: fire too small to trigger system"
        ~ "P",
        "2 - Did not activate: remote from fire"
        ~ "P",
        "5 - Did not activate: reason unknown"
        ~ "P",
        "4 - Other reason for non activation/operation"
        ~ "P",
      )
  )

cleaned_fire_data_simple <-
  cleaned_fire_data_simple |>
  mutate(
    fire_alarm_system_presence =
      case_match(
        fire_alarm_system_presence,
        "2 - No Fire alarm system" ~ "N",
        "1 -  Fire alarm system present"
        ~ "P",
      )
  )


# Write the cleaned data to a new csv
write_csv(
  x = cleaned_fire_data_simple,
  file = "data/analysis/cleaned_fire_data_simple.csv"
)

write_csv(
  x = selected_cleaned_fire_data,
  file = "data/analysis/cleaned_fire_data.csv"
)
