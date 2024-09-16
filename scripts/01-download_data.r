#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto,
# the data is "Fire Incidents Data"
# Author: Lexun Yu
# Date: 12 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)

#### Download data ####
toronto_fire <-
  list_package_resources("64a26694-01dc-4ec3-aa87-ad8509604f50") |>
  filter(name == "Fire Incidents Data.csv") |>
  get_resource()

write_csv(
  x = toronto_fire,
  file = "data/raw/toronto_fire_incidents.csv"
)

head(toronto_fire)
