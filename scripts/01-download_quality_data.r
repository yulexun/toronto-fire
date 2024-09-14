#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Lexun Yu
# Date: 12 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 


### Water Quality Data 
library(opendatatoronto)
library(dplyr)

# get package
toronto_beach_quality <-
  # Each package is associated with a unique id  found in the "For 
  # Developers" tab of the relevant page from Open Data Toronto
  # https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/
  list_package_resources("92b0de8f-1ada-44a7-84cf-adc04868e990") |>
  # Within that package, we are interested in the 2021 dataset
  filter(name == 
    "toronto-beaches-water-quality - 4326.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()

write.csv(
  x = toronto_beach_quality,
  file = "data/raw/toronto_beach_quality.csv"
)

head(toronto_beach_quality)
