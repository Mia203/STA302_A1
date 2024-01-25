#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(janitor)
library(lubridate)
#### Clean data ####
raw_data <- read_csv("inputs/data/fire_incidents_data.csv")

fire_incidents_data_clean <-
  clean_names(fire_incidents_data) |>
  select(x_id, estimated_dollar_loss, possible_cause, tfs_alarm_time)

fire_incidents_data_clean <- 
  fire_incidents_data_clean |>
  filter(!is.na(estimated_dollar_loss))

fire_incidents_data_clean <-
  fire_incidents_data_clean |>
  filter(possible_cause != "99 - Undetermined")|>
  filter(possible_cause != "98 - Unintentional, cause undetermined")|>
  filter(possible_cause != "60 - Other unintentional cause, not classified")  

fire_incidents_data_clean <-
  fire_incidents_data_clean |>
  rename(
    possible_cause_detail = possible_cause
  )

fire_incidents_data_clean <- 
  fire_incidents_data_clean |>
  mutate(possible_cause = case_when(
    fire_incidents_data_clean[[3]] == "01 - Suspected Arson" ~ "Intentional",
    fire_incidents_data_clean[[3]] == "02 - Riot/Civil Commotion" ~ "Intentional",
    fire_incidents_data_clean[[3]] == "03 - Suspected Vandalism" ~ "Intentional",
    fire_incidents_data_clean[[3]] == "04 - Suspected Youth Vandalism (Ages 12 to 17)"~ "Intentional",
    fire_incidents_data_clean[[3]] == "11 - Children Playing (Ages 11 and under)"~ "Unintentional",
    fire_incidents_data_clean[[3]] == "12 - Vehicle Accident/Collision"~ "Unintentional",
    fire_incidents_data_clean[[3]] == "20 - Design/Construction/Installation/Maintenance Deficiency"~ "Design/Construction/Maintenance deficiency",
    fire_incidents_data_clean[[3]] == "28 - Routine maintenance deficiency, eg creosote, lint, grease buildup"~ "Design/Construction/Maintenance deficiency",
    fire_incidents_data_clean[[3]] == "44 - Unattended" ~ "Misuse of ignition source/material ignited",
    fire_incidents_data_clean[[3]] == "45 - Improperly Discarded" ~ "Misuse of ignition source/material ignited",
    fire_incidents_data_clean[[3]] == "46 - Used or Placed too close to combustibles" ~ "Misuse of ignition source/material ignited",
    fire_incidents_data_clean[[3]] == "47 - Improper handling of ignition source or ignited material"~ "Misuse of ignition source/material ignited",
    fire_incidents_data_clean[[3]] == "48 - Used for purpose not intended"~ "Misuse of ignition source/material ignited",
    fire_incidents_data_clean[[3]] == "49 - Improper Storage"~ "Misuse of ignition source/material ignitedl",
    fire_incidents_data_clean[[3]] == "50 - Other misuse of ignition source/material ignited"~ "Misuse of ignition source/material ignitedl",
    fire_incidents_data_clean[[3]] == "51 - Mechanical Failure"~ "Mechanical/Electrical Failure",
    fire_incidents_data_clean[[3]] == "52 - Electrical Failure"~ "Mechanical/Electrical Failure",
    fire_incidents_data_clean[[3]] == "72 - Rekindle"~ "Other",
    fire_incidents_data_clean[[3]] == "73 - Natural Cause"~ "Other",
    fire_incidents_data_clean[[3]] == "80 - Exposure fire"~ "Other",
    #TRUE ~ NA_character_  default case, can be changed as needed
  ))

fire_incidents_data_clean<- 
  fire_incidents_data_clean |> 
  mutate(month = month(ymd_hms(tfs_alarm_time),label = TRUE, abbr = FALSE))

fire_incidents_data_clean <- 
  fire_incidents_data_clean |> 
  mutate(day_of_week = wday(tfs_alarm_time, label = TRUE, abbr = FALSE))


#### Save data ####
write_csv(fire_incidents_data_clean, "outputs/data/cleaned_fire_incidents_data.csv")

