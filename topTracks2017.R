# Load dependencies
library(plotly)
library(dplyr)
library(tibble)

# Set working directory
setwd("~/Google Drive/School/GSA 2017-2018/7-Data Visualization/dataviz")

# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# Isolating each metric so I can examine each one individually first

# ARTISTS
artists <- select(tracks, name, artists)

# Tracks per artist
artistPopularity <- artists %>% select(artists) %>% count(artists) %>% arrange(-n)
totalArtists <- nrow(artistPopularity)
topArtists <- artistPopularity %>% filter(n > 1)

# Top artists table
artistCol <- c("Artist Name","Number of Tracks")
kable(topArtists, row.names = NA, col.names = artistCol, caption = "Artists With More Than One Track")

# DANCEABILITY
dance <- select(tracks, name, artists, danceability)

# Danceability histogram
danceHist <- plot_ly(dance, x = ~danceability) %>% add_histogram(name = "danceability")
plotly_build(danceHist)

# ENERGY
energy <- select(tracks, name, artists, energy)

# Energy histogram
energyHist <- plot_ly(energy, x = ~energy) %>% add_histogram(name = "energy")
plotly_build(energyHist)

# KEY
key <- select(tracks, name, artists, key) 
keyCount <- key %>% count(key)

# Key bar chart
keyChart <- plot_ly(keyCount, x = ~key, y = ~n, type = "bar")
plotly_build(keyChart)

# LOUDNESS
loud <- select(tracks, name, artists, loudness)

# Loudness histogram
loudHist <- plot_ly(loud, x = ~loudness) %>% add_histogram(name = "loudness")
plotly_build(loudHist)

# MODE (1 Major or 0 Minor)
mode <- select(tracks, name, artists, mode)
modeCount <- mode %>% count(mode)

# Mode pie chart (One might even say...pie ala mode haha)
modePie <- plot_ly(modeCount, labels = ~mode, values = ~n, type = 'pie') %>%
  layout(title = 'Modes of the Top Tracks',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(modePie)

# SPEECHINESS
speech <- select(tracks, name, artists, speechiness)

# Speechiness histogram
speechHist <- plot_ly(speech, x = ~speechiness) %>% add_histogram(name = "speechiness")
plotly_build(speechHist)

# ACOUSTICNESS
acoustic <- select(tracks, name, artists, acousticness)

# Acousticness histogram
acoustHist <- plot_ly(acoustic, x = ~acousticness) %>% add_histogram(name = "acousticness")
plotly_build(acoustHist)

# INSTRUMENTALNESS — NEED TO WORK ON THIS
instrumental <- select(tracks, name, artists, instrumentalness)

# Instrumentalness histogram
instHist <- plot_ly(instrumental, x = ~instrumentalness) %>% add_histogram(name = "instrumentalness")
plotly_build(instHist)

# Instrumentalness bar
instBar <- plot_ly(instrumental, x = ~name, y = ~instrumentalness, type = "bar")
plotly_build(instBar)

# LIVENESS
live <- select(tracks, name, artists, liveness)

# Liveness histogram
liveHist <- plot_ly(live, x = ~liveness) %>% add_histogram(name = "liveness")
plotly_build(liveHist)

# VALENCE
valence <- select(tracks, name, artists, valence)

# Liveness histogram
valenceHist <- plot_ly(valence, x = ~valence) %>% add_histogram(name = "valence")
plotly_build(valenceHist)

# TEMPO
tempo <- select(tracks, name, artists, tempo)

# Tempo histogram
tempoHist <- plot_ly(tempo, x = ~tempo) %>% add_histogram(name = "tempo")
plotly_build(tempoHist)

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

# CHANGE TIME IN MS TO HUMAN TIME (minutes and seconds)
trackTime <- tracks %>% select(name, duration_ms) %>% 
                    mutate(duration = format(as.POSIXct(Sys.Date())+duration_ms/1000, "%M:%S"))

# TIME SIGNATURE
time <- count(tracks, time_signature)

# Time pie (no pun this time, sorry)
timePie <- plot_ly(time, labels = ~time_signature, values = ~n, type = 'pie') %>%
  layout(title = 'Modes of the Top Tracks',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(timePie)

# Observing multiple histograms that have values between 0 and 1
subplot(
  danceHist, energyHist, valenceHist, acoustHist,
  nrows = 4, shareX = TRUE
)

# CROSS EXAMINATION WITH SCATTERPLOT
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

# ED SHEERAN
ed <- filter(tracks, grepl("Ed Sheeran", artists))

# THE CHAINSMOKERS
tsc <- filter(tracks, grepl("The Chainsmokers", artists))
