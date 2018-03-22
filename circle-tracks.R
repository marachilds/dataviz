# Load dependencies
library(plotly)
library(dplyr)
library(tibble)

# SWD to source file location
# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

tracks <- rownames_to_column(tracks, "rank")

p1 <- plot_ly(tracks, x = ~rank, y = ~danceability, type = "scatter", mode = "markers")
plotly_build(p1)

danceability <- tracks %>% 
                filter(rank == 1) %>% 
                select(name, artists, danceability) %>%
                mutate(danceabilityPercent = 1 - danceability)

p2 <- danceability %>%
      filter(rank == 1) %>% 
      plot_ly(labels = ~name, values = ~danceability) %>%
      add_pie(hole = 0.6) %>%
      layout(title = "Danceability",  showlegend = F,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(p2)