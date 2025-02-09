install.packages("ggplot2")

library(ggplot2)

df <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//Data-Visualization-With-R-Language//origin.csv")

head(df)
str(df)

#examine the DS
table(df$Country)

#lets draw a plot to see the data points spread
ggplot(df, aes (x=Height, y = Weight))+
  geom_point(size=3, alpha=0.7)+
  labs(title="Height against weight",
       x="Height",
       y = "Weight")+
  theme_minimal()

#implementation cluster model using K Means

#let's remove country column
model_data <- df[,c("Height", "Weight")]
head(model_data)

#KMeans Model
set.seed(150)
results <- kmeans(model_data,centers=3)

#adding labels to clusters
df$Cluster <- as.factor(results$cluster)

#drawing cluster results
ggplot(df, aes(x=Height, y = Weight, color = Cluster))+
  stat_ellipse(aes(fill=Cluster), geom="polygon", alpha=0.4)+
  geom_point(size=3,alpha=0.8)+
  labs(title = "Height against weight distribution of Clusters",
       x = "Height",
       y = "Weight")+
  theme_minimal()

table(data$Country, data$Cluster)
