# Libraries
library(dplyr)
library(tidyr)
library(plotly)

# Load in rda from github
load(file = "data/spotify_track_data.rda")

# Rename to allYears because I am high maintenance
allYears <- spotify_track_data

# Let's look at the extremes first
year1960 <- filter(allYears, year == 1960)
year2015 <- filter(allYears, year == 2015)

# There is a huge difference, as to be expected
summary1960 <- year1960 %>% 
               select(danceability, energy, loudness, speechiness, acousticness,
                      instrumentalness, liveness, valence, tempo) %>%
               summarise_all(funs(mean))
                        
summary2015 <- year2015 %>% 
               select(danceability, energy, loudness, speechiness, acousticness,
                      instrumentalness, liveness, valence, tempo) %>%
               summarise_all(funs(mean))

# Differences between 1960 and 2015
df1960 <- gather(summary1960, "metric", "year1960")
df2015 <- gather(summary2015, "metric", "year2015")
rangePastToPresent <- left_join(df1960, df2015, by = "metric") %>% 
                      mutate(change = year2015 - year1960)

# Aggregate examination
allAvg <- allYears %>% group_by(year) %>% summarise_all(mean)

# Use to write averages to CSV for Processing
write.csv(allAvg, file = "billboardHot100.csv")

# Explicitness
explicitBar <- plot_ly(allAvg, x = ~year, y = ~explicit, type = "bar")
plotly_build(explicitBar)

# Danceability
danceBar <- plot_ly(allAvg, x = ~year, y = ~danceability, type = "bar")
plotly_build(danceBar)

# Energy
energyBar <- plot_ly(allAvg, x = ~year, y = ~energy, type = "bar")
plotly_build(energyBar)

# Loudness
loudBar <- plot_ly(allAvg, x = ~year, y = ~loudness, type = "bar")
plotly_build(loudBar)

# Speechiness
speechBar <- plot_ly(allAvg, x = ~year, y = ~speechiness, type = "bar")
plotly_build(speechBar)

# Acousticness
acoustBar <- plot_ly(allAvg, x = ~year, y = ~acousticness, type = "bar")
plotly_build(acoustBar)

# Instrumentalness
instBar <- plot_ly(allAvg, x = ~year, y = ~instrumentalness, type = "bar")
plotly_build(instBar)

# Liveness
liveBar <- plot_ly(allAvg, x = ~year, y = ~liveness, type = "bar")
plotly_build(liveBar)

# Valence
valBar <- plot_ly(allAvg, x = ~year, y = ~valence, type = "bar")
plotly_build(valBar)

# Tempo
tempoBar <- plot_ly(allAvg, x = ~year, y = ~tempo, type = "bar")
plotly_build(tempoBar)

# Duration
durationBar <- plot_ly(allAvg, x = ~year, y = ~duration_ms, type = "bar")
plotly_build(durationBar)