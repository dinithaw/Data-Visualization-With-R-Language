library(ggplot2)
data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//Data-Visualization-With-R-Language//customer_data_pca.csv")
head(data)
str(data)

#kmeans model
set.seed(150)
results <- kmeans(data, centers = 4)

#addinge labels to clusters
data$Cluster <- as.factor(results$cluster)

#drawing cluster results
ggplot(data, aes(x= Age, y= Annual_Income, color=Cluster))+
  stat_ellipse(aes(fill = Cluster), geom = "polygon", alpha=0.4)+
  geom_point(size=3, alpha=0.8)+
  labs(title = "Age against annual income distribution of clusters",
       x = "Age",
       y = "Annual_income") +
  theme_minimal()

#anual income vs spending score
ggplot(data,aes(x=Age, y=Spending_Score, colour = Cluster))+
  stat_ellipse(aes(fill = Cluster), geom = "polygon", alpha=0.4)+
  geom_point(size=3, alpha=0.8)+
  labs(title = "age against spending score distribution of clusters",
       x= "Age",
       y= "Spending_Score") +
  theme_minimal()