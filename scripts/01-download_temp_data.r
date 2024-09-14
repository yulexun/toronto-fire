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
toronto_beach_temp <-
  # Each package is associated with a unique id  found in the "For 
  # Developers" tab of the relevant page from Open Data Toronto
  # https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/
  list_package_resources("toronto-beaches-observations") |>
  # Within that package, we are interested in the 2021 dataset
  filter(name == 
    "toronto-beaches-observations.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()

write.csv(
  x = toronto_beach_temp,
  file = "data/raw/toronto_beach_temp.csv"
)

head(toronto_beach_temp)

