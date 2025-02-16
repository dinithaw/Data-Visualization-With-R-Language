data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//Data-Visualization-With-R-Language//customer_data_pca.csv")
data

install.packages("dplyr")
install.packages("factoextra")
library(ggplot2)
library(dplyr)
library(factoextra)

#standardization
scaled_data <- scale(data)
head(scaled_data)

#calculating PCA with eingvalues & eingvectors

pca_model <- prcomp(scaled_data, center=TRUE, scale=TRUE)
pca_model
summary(pca_model)

#scree plot
fviz_eig(pca_model, addlabels = TRUE, ylim = c(0,100))

#transforming dataset into principal components
pca_transformed_data <- as.data.frame(pca_model$x)
head(pca_transformed_data)

#visualizing 1 PC1 & PC2 for possible customer segmentation
ggplot(pca_transformed_data, aes(x=PC1, y=PC2))+
  geom_point(color='red', alpha= 0.6)+
  ggtitle("Customer segmentation based on PC1 and PC2")+
  theme_minimal()


