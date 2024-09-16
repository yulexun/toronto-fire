#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Lexun Yu
# Date: 12 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 


#### Workspace setup ####

### Water Temperature Data 

library(opendatatoronto)
library(dplyr)
 
# get package
toronto_fire <-
  # Each package is associated with a unique id  found in the "For 
  # Developers" tab of the relevant page from Open Data Toronto
  # https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/
  list_package_resources("64a26694-01dc-4ec3-aa87-ad8509604f50") |>
  # Within that package, we are interested in the 2021 dataset
  filter(name == 
    "Fire Incidents Data.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()

write.csv(
  x = toronto_fire,
  file = "data/raw/toronto_fire_incidents.csv"
)

head(toronto_fire)

