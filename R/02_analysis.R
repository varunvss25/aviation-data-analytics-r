# R/02_analysis.R
# Compute grouped metrics and correlations for route efficiency

suppressPackageStartupMessages({
  library(tidyverse)
})

flights_joined <- readRDS("outputs/flights_joined.rds")

# ---- grouped summaries ----
route_summary <- flights_joined %>%
  filter(!is.na(flight_duration_hr)) %>%
  group_by(carrier, origin, dest) %>%
  summarize(
    flights = n(),
    avg_air_time_hr = mean(flight_duration_hr, na.rm = TRUE),
    median_air_time_hr = median(flight_duration_hr, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(flights))

readr::write_csv(route_summary, "outputs/route_summary.csv")

# ---- correlation analysis example ----
# Explore correlation between departure hour and delays (if columns exist)
corr_summary <- flights_joined %>%
  filter(!is.na(dep_hour), !is.na(dep_delay)) %>%
  group_by(carrier) %>%
  summarize(
    n = n(),
    cor_depHour_depDelay = suppressWarnings(cor(dep_hour, dep_delay, use = "complete.obs")),
    .groups = "drop"
  ) %>%
  arrange(desc(abs(cor_depHour_depDelay)))

readr::write_csv(corr_summary, "outputs/corr_summary.csv")

message("Wrote outputs: outputs/route_summary.csv, outputs/corr_summary.csv")