# Load dependencies
library(plotly)
library(dplyr)

# Set working directory
setwd("~/Google Drive/School/GSA 2017-2018/7-Data Visualization/dataviz")

# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# Tracks by ascending duration
tracks_asc <- arrange(tracks, duration_ms)

# Set factor level order for top-bottom ascending duration
tracks_asc$y <- factor(tracks_asc$name, levels = unique(tracks_asc$name)[order(tracks_asc$duration_ms, decreasing = TRUE)])

p1 <- plot_ly(tracks_asc, type="bar", 
              orientation="h", 
              x = ~duration_ms, 
              y = ~y)
plotly_build(p1)
