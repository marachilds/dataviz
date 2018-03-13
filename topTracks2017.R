# Load dependencies
library(plotly)
library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)
library(reshape2)

# SWD to source file location
# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# Isolating each metric so I can examine each one individually first, I could have just used the tracks
# dataframe and targeted each column but I wasn't sure of what I would be doing later so I made
# them most manageable to begin with

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
keyNames <- c("C", "C♯", "D", "	D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B")
keyCount <- key %>% count(key)
keyCount$key <- keyNames

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

# Instrumentalness count
instCount <- instrumental %>% count(instrumentalness)

# Instrumentalness pie
instPie <- plot_ly(instCount, labels = ~instrumentalness, values = ~n, type = 'pie') %>%
  layout(title = 'Instrumentalness of Top Tracks',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
plotly_build(instPie)

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

duration1 <- plot_ly(durationAvg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y)
plotly_build(duration1)

# Let's change some colors
# Add column to handle plotly colors, this might be a yikes
durationAvg$color <- "rgba(204,204,204,1)"
durationAvg[1, "color"] <- "rgba(222,45,38,0.8)"

# Make it into a list
c <- as.vector(durationAvg$color)
  
# Another chart, this time with the average
duration2 <- plot_ly(durationAvg, type="bar",
              orientation="h",
              x = ~duration_ms,
              y = ~y,
              marker = (list(color = c)))
plotly_build(duration2)

# Histogram perhaps
durHist <- plot_ly(tracks, x = ~duration_ms) %>% add_histogram(name = "duration_ms")
plotly_build(durHist)

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

# DISTINCTNESS
trackDistinct <- summarise_all(tracks, funs(n_distinct))
trackDistinctDF <- gather(trackDistinct, "metric", "distinctness", 1:16)
distBar <- plot_ly(trackDistinctDF, x = ~metric, y = ~ distinctness, type = "bar")
plotly_build(distBar)

# Scatterplot
t <- list(family = "sans-serif",
          size = 12,
          color = "black")
p1 <- plot_ly(tracks, type="scatter",
              mode="markers",
              x = ~energy,
              y = ~loudness,
              # size = ~speechiness,
              color = ~(-duration_ms),
              colors = "BuPu",
              text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Energy",
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE),
         font = t)
plotly_build(p1)

# CORRELATION HEAT MAP
trackNum <- select(tracks, -id, -name, -artists)
qplot(x=Var1, y=Var2, data=melt(cor(trackNum)), fill=value, geom="tile")

# ED SHEERAN
ed <- filter(tracks, grepl("Ed Sheeran", artists))
ed1 <- plot_ly(ed, x = ~name, y = ~danceability, type = "bar")
plotly_build(ed1)
edSummary <- select(ed, danceability, energy, loudness, speechiness, acousticness, liveness,
                    valence, tempo, duration_ms) %>% 
                    summarise_all(funs(mean))
edBar <- gather(edSummary, "metric", "average", 1:9)

# THE CHAINSMOKERS
tsc <- filter(tracks, grepl("The Chainsmokers", artists))
tsc1 <- plot_ly(tsc, x = ~name, y = ~danceability, type = "bar")
plotly_build(tsc1)
tscSummary <- select(tsc, danceability, energy, loudness, speechiness, acousticness, liveness,
                     valence, tempo, duration_ms) %>% 
                     summarise_all(funs(mean))
tscBar <- gather(tscSummary, "metric", "average", 1:9)

# ALL TRACK AVERAGES
trackAvg <- select(tracks, danceability, energy, loudness, speechiness, acousticness, liveness,
                   valence, tempo, duration_ms) %>% 
                   summarise_all(funs(mean))
trackAvgBar <- gather(trackAvg, "metric", "average", 1:9)

# Compare Ed, TSC, and all track averages
topTwoCompare <- left_join(edBar, tscBar, by = "metric")
allAvgCompare <- left_join(topTwoCompare, trackAvgBar, by = "metric")
avgName <- c("metric", "Ed", "TSC", "All")
names(allAvgCompare) <- avgName
allAvgCompareX <- slice(allAvgCompare, 1:7)
allAvgCompareX <- slice(allAvgCompareX, -3)

avgCompare <- plot_ly(allAvgCompareX, x = ~metric, y = ~Ed, type = 'bar', name = "Ed Sheeran") %>%
  add_trace(y = ~TSC, name = "The Chainsmokers") %>%
  add_trace(y = ~All, name = "All Track Average") %>% 
  layout(yaxis = list(title = 'Count'), barmode = 'group')
plotly_build(avgCompare)

# allSummary <- as.data.frame(summary(tracks)) %>% select(Var2, Freq)
