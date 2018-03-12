# Load dependencies
library(plotly)
library(dplyr)
library(tibble)

# Set working directory
setwd("~/Google Drive/School/GSA 2017-2018/7-Data Visualization/dataviz")

# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# ARTISTS
artists <- tracks %>% select(name, artists)

# Tracks per artist
artistPopularity <- artists %>% select(artists) %>% count(artists) %>% arrange(-n)

# Table
artistCol <- c("Artist Name","Total Tracks")

#DURATION
# Tracks by ascending duration
durationAsc <- arrange(tracks, duration_ms) %>% select(name, duration_ms)

# Add average duration in ms
durationAvg <- durationAsc %>% 
  summarise(name = "Average Length",
            duration_ms = mean(duration_ms)) %>% 
  bind_rows(durationAsc)

# Set factor level order for top-bottom ascending duration
durationAvg$y <- factor(durationAvg$name, levels = unique(durationAvg$name)[order(durationAvg$duration_ms, decreasing = TRUE)])

# Alternatively, set row number to column called number to replace "~y"
# duration_asc <- rownames_to_column(duration_asc, "number")

p1 <- plot_ly(durationAvg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y)
plotly_build(p1)

# Let's change some colors
# Add column to handle plotly colors, this might be a yikes
durationAvg$color <- "rgba(204,204,204,1)"
durationAvg[1, "color"] <- "rgba(222,45,38,0.8)"

# Make it into a list
c <- as.vector(durationAvg$color)
  
# Another chart, this time with the average
p2 <- plot_ly(durationAvg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y,
              marker = (list(color = c)))
plotly_build(p2)

# Let's make a scatter plot
t3 <- list(family = "sans-serif",
          size = 12,
          color = "black")

p3 <- plot_ly(tracks, type="scatter",
              mode="markers",
              x = ~tempo,
              y = ~danceability,
              size = ~loudness,
              color = ~(-acousticness),
              colors = "BuPu",
              text = ~paste(name, "<br>", artists)) %>% 
      layout(title = "Spotify's Top Tracks 2017",
             yaxis = list(zeroline = FALSE),
             xaxis = list(zeroline = FALSE),
             font = t3)
plotly_build(p3)
