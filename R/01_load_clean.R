# R/01_load_clean.R
# Load, clean, and merge NYC flights datasets (H2 2022)
suppressPackageStartupMessages({
  library(tidyverse)  # includes dplyr, tidyr, readr, ggplot2
  library(readr)
})

# ---- paths ----
flights_path  <- "data/flights2022-h2.csv"
airlines_path <- "data/airlines.csv"
airports_path <- "data/airports.csv"

# ---- read ----
flights  <- readr::read_csv(flights_path, show_col_types = FALSE)
airlines <- readr::read_csv(airlines_path, show_col_types = FALSE)
airports <- readr::read_csv(airports_path, show_col_types = FALSE)

# ---- minimal clean & standardize ----
flights <- flights %>%
  janitor::clean_names() %>%
  mutate(
    # harmonize column names if needed; add derived fields
    flight_duration_hr = air_time / 60,
    dep_hour = ifelse(!is.na(dep_time), floor(dep_time / 100), NA)
  )

# ---- merge lookups ----
flights_joined <- flights %>%
  left_join(airlines %>% rename(airline_name = name), by = "carrier") %>%
  left_join(airports %>% rename(dest_airport_name = name),
            by = c("dest" = "faa"))

# ---- save for next steps ----
dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
saveRDS(flights_joined, file = "outputs/flights_joined.rds")

message("Loaded & merged: ", nrow(flights_joined), " rows → outputs/flights_joined.rds")