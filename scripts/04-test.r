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
cleaned_data <- read_csv("data/analysis/cleaned_fire_data.csv")

#### Test data ####
# test1: Tests that there is no empty value
test1 <-
  sum(is.na(cleaned_data)) == 0

all(test1)
