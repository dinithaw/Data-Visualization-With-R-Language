install.packages("ggplot2")

library(ggplot2)

# Load the Climate.csv file
df <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//Data-Visualization-With-R-Language//Climate.csv")

head(df)
str(df)

# Examine the dataset
table(df$ClimateZone)

# Draw a plot to see the data points spread
ggplot(df, aes(x=Temperature, y=Rainfall)) +
  geom_point(size=3, alpha=0.7) +
  labs(title="Temperature against Rainfall",
       x="Temperature",
       y="Rainfall") +
  theme_minimal()

# Implementation of cluster model using K Means

# Remove ClimateZone column
model_data <- df[, c("Temperature", "Rainfall")]
head(model_data)

# KMeans Model
set.seed(150)
results <- kmeans(model_data, centers=4)

# Adding labels to clusters
df$Cluster <- as.factor(results$cluster)

# Drawing cluster results with more appealing colors
ggplot(df, aes(x=Temperature, y=Rainfall, color=Cluster)) +
  stat_ellipse(aes(fill=Cluster), geom="polygon", alpha=0.4) +
  geom_point(size=3, alpha=0.8) +
  scale_color_manual(values=c("#E41A1C", "#377EB8", "#4DAF4A", "#FF7F00")) +
  scale_fill_manual(values=c("#E41A1C", "#377EB8", "#4DAF4A", "#FF7F00")) +
  labs(title="Temperature against Rainfall distribution of Clusters",
       x="Temperature",
       y="Rainfall") +
  theme_minimal()

table(df$ClimateZone, df$Cluster)