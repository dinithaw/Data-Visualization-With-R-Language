
# Installing required libraries (Run only once)
install.packages("forecast")
install.packages("ggplot2")

# Loading libraries
library(ggplot2)
library(forecast)

# Loading the dataset
data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//R//coconut.csv")

# Checking the structure of the dataset
str(data)

# Processing month variable to date format
data$Month <- as.Date(data$Month, format="%Y-%m-%d")

# Summary of the dataset
summary(data)

# Plotting the histogram of coconut prices
ggplot(data, aes(x = Coconut_Price)) +
  geom_histogram(binwidth = 5, fill = "pink", color = "black") +
  labs(title = "Coconut Price Distribution", x = "Price (RS)", y = "Frequency") +
  theme_minimal()

# Creating the time series object
coco_t_s <- ts(data$Coconut_Price, start = c(2005, 1), frequency = 12)

# Plotting the time series using base R
plot(coco_t_s, main = "Coconut Price Time Series (2005-2025)",
     ylab = "Price (RS)", xlab = "Year", col = "blue", lwd = 2)
grid()

# Time series decomposition (trend, seasonal, and residual components)
decomposed <- decompose(coco_t_s)

# Plot the decomposed time series components
plot(decomposed, col="blue")

# Plotting the time series using ggplot2 for better visualization
ggplot(data, aes(x = Month, y = Coconut_Price)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Coconut Price Trend (2005-2025)",
       x = "Year", y = "Price (RS)") +
  theme_minimal()

# Checking for stationarity using Augmented Dickey-Fuller Test
adf_test <- adf.test(coco_t_s)
print(adf_test)

# Forecasting using ARIMA model
model <- auto.arima(coco_t_s)

# Forecast the next 12 months
forecast_values <- forecast(model, h = 12)

# Plot the forecasted values
plot(forecast_values, main="Coconut Price Forecast",
     ylab="Price (RS)", xlab="Year")

# Summary of the ARIMA model
summary(model)