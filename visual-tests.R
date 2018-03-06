# Load dependencies
library(plotly)
library(dplyr)

# Use state data as example data set
df <- as.data.frame(state.x77)

# Create plotly object
p <- plot_ly(df, type="scatter", mode="markers", x = ~Population, y = ~Income, color = ~Illiteracy)

# Build plotly object
plotly_build(p)

# Make state names column 1
df_names <- add_rownames(df, "State")

# Remove spaces from columns
names(df_names)[5] <- "LifeExp"
names(df_names)[7] <- "HSGrad"

# Create scatter plot with trace
p_trace <- plot_ly(df_names, type="scatter", mode="markers",
                   x = ~Population,
                   y = ~Income,
                   text = df_names$State,
                   color = ~LifeExp)

# Build plot
plotly_build(p_trace)

