#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: Install required packages: opendatatoronto, tidyverse, dplyr
# Any other information needed? [...UPDATE THIS...]



#### Workspace setup ####

library(opendatatoronto)
library(tidyverse)
library(dplyr)


# [...UPDATE THIS...]


#### Download data ####

fire_incidents_data <-
  # Each package is associated with a unique id found in the "For
  # Developers" tab of the relevant page from Open Data Toronto
  list_package_resources("64a26694-01dc-4ec3-aa87-ad8509604f50") |>
  # Within that package, we are interested in the 2021 dataset
  filter(name ==
           "Fire Incidents Data.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()
head(fire_incidents_data)

#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(fire_incidents_data, "inputs/data/fire_incidents_data.csv") 

