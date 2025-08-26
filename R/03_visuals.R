# R/03_visuals.R
# ggplot2 visuals: heatmaps, facets, delay distributions

suppressPackageStartupMessages({
  library(tidyverse)
  library(ggplot2)
  library(scales)
})

flights_joined <- readRDS("outputs/flights_joined.rds")

dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)

# ---- delay distribution ----
p_delay <- flights_joined %>%
  filter(!is.na(dep_delay)) %>%
  ggplot(aes(x = dep_delay)) +
  geom_histogram(bins = 60) +
  coord_cartesian(xlim = c(-20, 180)) +
  labs(title = "Departure Delay Distribution",
       x = "Departure delay (minutes)",
       y = "Count")

ggsave("outputs/figures/departure_delay_distribution.png", p_delay, width = 8, height = 5, dpi = 160)

# ---- carrier facets for avg duration ----
p_carrier_facet <- flights_joined %>%
  filter(!is.na(flight_duration_hr)) %>%
  group_by(carrier, dest) %>%
  summarize(avg_air_time_hr = mean(flight_duration_hr, na.rm = TRUE),
            flights = n(), .groups = "drop") %>%
  ggplot(aes(x = reorder(dest, avg_air_time_hr), y = avg_air_time_hr)) +
  geom_col() +
  facet_wrap(~ carrier, scales = "free_x") +
  coord_flip() +
  labs(title = "Average Air Time by Destination (faceted by Carrier)",
       x = "Destination", y = "Avg air time (hr)")

ggsave("outputs/figures/avg_air_time_by_dest_faceted.png", p_carrier_facet, width = 10, height = 7, dpi = 160)

# ---- hour x day heatmap of delays (if columns exist) ----
# Create day-of-week if 'dep_time' or date is present (example assumes 'dep_time' and possibly 'day_of_week')
flights_joined <- flights_joined %>%
  mutate(
    dow = ifelse(!is.na(time_hour), weekdays(as.Date(time_hour)), NA_character_)
  )

p_heat <- flights_joined %>%
  filter(!is.na(dep_hour), !is.na(dep_delay), !is.na(dow)) %>%
  group_by(dow, dep_hour) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = factor(dep_hour), y = fct_relevel(as.factor(dow),
       "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))) +
  geom_tile(aes(fill = avg_dep_delay)) +
  scale_fill_gradient(name = "Avg delay (min)", low = "white", high = "red") +
  labs(title = "Avg Departure Delay by Hour x Day", x = "Hour of day", y = "Day of week")

ggsave("outputs/figures/avg_dep_delay_heatmap.png", p_heat, width = 9, height = 6, dpi = 160)

message("Saved figures to outputs/figures/")