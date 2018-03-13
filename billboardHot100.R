# Libraries
library(dplyr)

# Load in rda from github
load(file = "data/spotify_track_data.rda")

# Rename to allYears
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

# Aggregate examination
allAvg <- allYears %>% group_by(year) %>% summarise_all(mean)

# Explicitness
explicitBar <- 