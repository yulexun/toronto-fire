#### Preamble ####
# Purpose: Generate legend for categorial figures
# Author: Lexun Yu
# Date: 16 Sep 2024
# Contact: lx.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

cleaned_data <-
  read_csv("data/analysis/cleaned_fire_data.csv", show_col_types = FALSE)

data <-
  cleaned_data$area_of_origin |>
  unique() |>
  sort.default()

write.table(data,
  file = "data/legend/area_of_origin.txt", sep = "\n",
  row.names = FALSE
)

data <-
  cleaned_data$ignition_source |>
  unique() |>
  sort.default()

write.table(data,
  file = "data/legend/ignition_source.txt", sep = "\n",
  row.names = FALSE
)
