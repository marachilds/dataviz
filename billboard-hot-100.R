# Libraries
library(dplyr)
library(tidyr)
library(plotly)

# Load in rda from github
load(file = "data/spotify_track_data.rda")

# Rename to allYears because I am high maintenance
all_years <- spotify_track_data

# Let's look at the extremes first
year_1960 <- filter(all_years, year == 1960)
year_2015 <- filter(all_years, year == 2015)

# There is a huge difference, as to be expected
summary_1960 <- year_1960 %>% 
                select(danceability, energy, loudness, speechiness, acousticness,
                      instrumentalness, liveness, valence, tempo) %>%
                summarise_all(funs(mean))
                        
summary_2015 <- year_2015 %>% 
               select(danceability, energy, loudness, speechiness, acousticness,
                      instrumentalness, liveness, valence, tempo) %>%
               summarise_all(funs(mean))

# Differences between 1960 and 2015
df_1960 <- gather(summary_1960, "metric", "year1960")
df_2015 <- gather(summary_2015, "metric", "year2015")
past_to_present <- left_join(df_1960, df_2015, by = "metric") %>% 
                      mutate(change = year2015 - year1960)

# Aggregate examination
all_avg <- all_years %>% group_by(year) %>% summarise_all(mean)

# Use to write averages to CSV for Processing
write.csv(all_avg, file = "billboardHot100.csv")

# Explicitness
explicit_bar <- plot_ly(all_avg, x = ~year, y = ~explicit, type = "bar")
plotly_build(explicit_bar)

# Danceability
dance_bar <- plot_ly(all_avg, x = ~year, y = ~danceability, type = "bar")
plotly_build(dance_bar)

# Energy
energy_bar <- plot_ly(all_avg, x = ~year, y = ~energy, type = "bar")
plotly_build(energy_bar)

# Loudness
loud_bar <- plot_ly(all_avg, x = ~year, y = ~loudness, type = "bar")
plotly_build(loud_bar)

# Speechiness
speech_bar <- plot_ly(all_avg, x = ~year, y = ~speechiness, type = "bar")
plotly_build(speech_bar)

# Acousticness
acoust_bar <- plot_ly(all_avg, x = ~year, y = ~acousticness, type = "bar")
plotly_build(acoust_bar)

# Instrumentalness
instrumentalness_bar <- plot_ly(all_avg, x = ~year, y = ~instrumentalness, type = "bar")
plotly_build(instrumentalness_bar)

# Liveness
liveness_bar <- plot_ly(all_avg, x = ~year, y = ~liveness, type = "bar")
plotly_build(liveness_bar)

# Valence
valence_bar <- plot_ly(all_avg, x = ~year, y = ~valence, type = "bar")
plotly_build(valence_bar)

# Tempo
tempo_bar <- plot_ly(all_avg, x = ~year, y = ~tempo, type = "bar")
plotly_build(tempo_bar)

# Duration
duration_bar <- plot_ly(all_avg, x = ~year, y = ~duration_ms, type = "bar")
plotly_build(duration_bar)