# Load necessary library
library(ggplot2)

# Read the dataset
data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//Data-Visualization-With-R-Language//Customer_Data.csv")

# Examine the first few rows of the dataset
head(data)

# Check the structure of the dataset
str(data)

# Summary statistics of the dataset
summary(data)

# Plot to see the spread of data points (AnnualIncome vs SpendingScore)
ggplot(data, aes(x = AnnualIncome, y = SpendingScore)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Annual Income vs Spending Score",
       x = "Annual Income",
       y = "Spending Score") +
  theme_minimal()

# Prepare data for clustering (select AnnualIncome and SpendingScore)
model_data <- data[, c("AnnualIncome", "SpendingScore")]
head(model_data)

# Perform k-means clustering
set.seed(150)  # Set seed for reproducibility
results <- kmeans(model_data, centers = 5)  # Use 5 centers (you can adjust this)

# Add the cluster assignments to the original data for visualization
data$cluster <- as.factor(results$cluster)

# Draw the cluster results with ellipses
ggplot(data, aes(x = AnnualIncome, y = SpendingScore, color = cluster)) +
  geom_point(size = 3, alpha = 0.7) +  # Add points to the plot
  stat_ellipse(aes(fill = cluster), geom = "polygon", alpha = 0.2) +  # Add ellipses
  labs(title = "Annual Income vs Spending Score with Clusters",
       x = "Annual Income",
       y = "Spending Score") +
  theme_minimal()

# Print the results of the k-means clustering
print(results)

# lets run for 10 clusters

optimal_number <- sapply(1:10, function(k) kmeans(model_data, centers = k)$tot.withinss)

#draw 
plot(1:10, optimal_number, type = "b", pch= 19, col="red")