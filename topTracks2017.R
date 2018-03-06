# Load dependencies
library(plotly)
library(dplyr)
library(tibble)

# Set working directory
setwd("~/Google Drive/School/GSA 2017-2018/7-Data Visualization/dataviz")

# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# Tracks by ascending duration
duration_asc <- arrange(tracks, duration_ms) %>% select(name, duration_ms)

# Add average duration in ms
duration_avg <- duration_asc %>% 
  summarise(name = "Average Length",
            duration_ms = mean(duration_ms)) %>% 
  bind_rows(duration_asc)

# Set factor level order for top-bottom ascending duration
duration_avg$y <- factor(duration_avg$name, levels = unique(duration_avg$name)[order(duration_avg$duration_ms, decreasing = TRUE)])

# Alternatively, set row number to column called number to replace "~y"
# tracks_asc <- rownames_to_column(tracks_asc, "number")

p1 <- plot_ly(duration_avg, type="bar", 
              orientation="h", 
              x = ~duration_ms, 
              y = ~y)
plotly_build(p1)


