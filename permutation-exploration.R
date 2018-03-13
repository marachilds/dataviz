# Load dependencies
library(plotly)
library(dplyr)
library(tibble)

# SWD to source file location
# Read in Spotify Top Songs 2017 csv
tracks <- read.csv("data/toptracks2017.csv", stringsAsFactors = FALSE)

# CROSS EXAMINATION WITH SCATTERPLOTS
# Let's make a scatter plot
t <- list(family = "sans-serif",
          size = 12,
          color = "black")

# Master
p1 <- plot_ly(tracks, type="scatter",
              mode="markers",
              x = ~energy,
              y = ~loudness,
              # size = ~tempo,
              # color = ~(danceability),
              colors = "BuPu",
              text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Energy",
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE),
         font = t)
plotly_build(p1)

# Danceability - Energy
# No correlation
danceEnergy <- plot_ly(tracks, type="scatter",
              mode="markers",
              x = ~danceability,
              y = ~energy,
              text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Energy",
         font = t)
plotly_build(danceEnergy)

# Danceability - Loudness
# No correlation
danceLoud <- plot_ly(tracks, type="scatter",
                       mode="markers",
                       x = ~danceability,
                       y = ~loudness,
                       text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Loudness",
         font = t)
plotly_build(danceLoud)

# Danceability - Speechiness
# No correlation
danceSpeech <- plot_ly(tracks, type="scatter",
                     mode="markers",
                     x = ~danceability,
                     y = ~speechiness,
                     text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Speechiness",
         font = t)
plotly_build(danceSpeech)

# Danceability - Acousticness
# No correlation
danceAcoust <- plot_ly(tracks, type="scatter",
                       mode="markers",
                       x = ~danceability,
                       y = ~acousticness,
                       text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Acousticness",
         font = t)
plotly_build(danceAcoust)

# Danceability - Liveness
# No correlation
danceLive <- plot_ly(tracks, type="scatter",
                       mode="markers",
                       x = ~danceability,
                       y = ~liveness,
                       text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Liveness",
         font = t)
plotly_build(danceLive)

# Danceability - Valence
# No correlation
danceVal <- plot_ly(tracks, type="scatter",
                       mode="markers",
                       x = ~danceability,
                       y = ~valence,
                       text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Valence",
         font = t)
plotly_build(danceVal)

# Danceability - Tempo
# No correlation
danceTempo <- plot_ly(tracks, type="scatter",
                       mode="markers",
                       x = ~danceability,
                       y = ~tempo,
                       text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Danceability - Tempo",
         font = t)
plotly_build(danceTempo)

# Energy - Loudness
# Weak positive correlation
energyLoud <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~energy,
                      y = ~loudness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Loudness",
         font = t)
plotly_build(energyLoud)

# Energy - Speechiness
# No correlation
energySpeech <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~energy,
                      y = ~speechiness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Speechiness",
         font = t)
plotly_build(energySpeech)

# Energy - Acousticness
# No correlation
energyAcoust <- plot_ly(tracks, type="scatter",
                        mode="markers",
                        x = ~energy,
                        y = ~acousticness,
                        text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Acousticness",
         font = t)
plotly_build(energyAcoust)

# Energy - Liveness
# No correlation
energyLive <- plot_ly(tracks, type="scatter",
                        mode="markers",
                        x = ~energy,
                        y = ~liveness,
                        text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Liveness",
         font = t)
plotly_build(energyLive)

# Energy - Valence
# No correlation
energyVal <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~energy,
                      y = ~valence,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Valence",
         font = t)
plotly_build(energyVal)

# Energy - Tempo
# No correlation
energyTempo <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~energy,
                      y = ~tempo,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Energy - Tempo",
         font = t)
plotly_build(energyTempo)

# Loudness - Speechiness
# Almost weak negative correlation
loudSpeech <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~loudness,
                      y = ~speechiness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Speechiness",
         font = t)
plotly_build(loudSpeech)

# Loudness - Acousticness
# Almost weak negative correlation
loudAcoust <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~loudness,
                      y = ~acousticness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Acousticness",
         font = t)
plotly_build(loudAcoust)

# Loudness - Liveness
# No correlation
loudLive <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~loudness,
                      y = ~liveness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Liveness",
         font = t)
plotly_build(loudLive)

# Loudness - Valence
# Very weak positive correlation
loudVal <- plot_ly(tracks, type="scatter",
                    mode="markers",
                    x = ~loudness,
                    y = ~valence,
                    text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Valence",
         font = t)
plotly_build(loudVal)

# Loudness - Tempo
# No correlation
loudTempo <- plot_ly(tracks, type="scatter",
                   mode="markers",
                   x = ~loudness,
                   y = ~tempo,
                   text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Loudness - Tempo",
         font = t)
plotly_build(loudTempo)

# Speechiness - Acousticness
# No correlation
speechAcoust <- plot_ly(tracks, type="scatter",
                     mode="markers",
                     x = ~speechiness,
                     y = ~acousticness,
                     text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Speechiness - Acousticness",
         font = t)
plotly_build(speechAcoust)

# Speechiness - Liveness
# No correlation
speechLive <- plot_ly(tracks, type="scatter",
                        mode="markers",
                        x = ~speechiness,
                        y = ~liveness,
                        text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Speechiness - Liveness",
         font = t)
plotly_build(speechLive)

# Speechiness - Valence
# No correlation
speechVal <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~speechiness,
                      y = ~valence,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Speechiness - Valence",
         font = t)
plotly_build(speechVal)

# Speechiness - Tempo
# No correlation
speechTempo <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~speechiness,
                      y = ~tempo,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Speechiness - Tempo",
         font = t)
plotly_build(speechTempo)

# Acousticness - Liveness
# No correlation
acoustLive <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~acousticness,
                      y = ~liveness,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Acousticness - Liveness",
         font = t)
plotly_build(acoustLive)

# Acousticness - Valence
# No correlation
acoustVal <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~acousticness,
                      y = ~valence,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Acousticness - Valence",
         font = t)
plotly_build(acoustVal)

# Acousticness - Tempo
# No correlation
acoustTempo <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~acousticness,
                      y = ~tempo,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Acousticness - Tempo",
         font = t)
plotly_build(acoustTempo)

# Liveness - Valence
# No correlation
liveVal <- plot_ly(tracks, type="scatter",
                      mode="markers",
                      x = ~liveness,
                      y = ~valence,
                      text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Liveness - Valence",
         font = t)
plotly_build(liveVal)

# Liveness - Tempo
# No correlation
liveTempo <- plot_ly(tracks, type="scatter",
                   mode="markers",
                   x = ~liveness,
                   y = ~tempo,
                   text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Liveness - Tempo",
         font = t)
plotly_build(liveTempo)

# Valence - Tempo
# No correlation
valTempo <- plot_ly(tracks, type="scatter",
                     mode="markers",
                     x = ~valence,
                     y = ~tempo,
                     text = ~paste(name, "<br>", artists)) %>% 
  layout(title = "Valence - Tempo",
         font = t)
plotly_build(valTempo)