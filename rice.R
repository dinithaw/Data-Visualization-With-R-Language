# Installing required libraries (Run only once)
install.packages("forecast")
install.packages("ggplot2")
install.packages("tseries")

# Loading libraries
library(ggplot2)
library(forecast)
library(tseries)

# Loading the dataset
data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//R//Rice_Prices_Dataset.csv")

# Checking the structure of the dataset
str(data)

# Processing date variable to date format
data$Date <- as.Date(data$Date, format="%Y-%m-%d")

# Summary of the dataset
summary(data)

# Plotting the histogram of rice prices
ggplot(data, aes(x = Rice_Prices)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Rice Prices Distribution", x = "Rice Prices", y = "Frequency") +
  theme_minimal()

# Creating the time series object
rice_t_s <- ts(data$Rice_Prices, start = c(2005, 1), frequency = 12)

# Plotting the time series using base R
plot(rice_t_s, main = "Rice Prices Time Series (2005-2025)",
     ylab = "Rice Prices", xlab = "Year", col = "blue", lwd = 2)
grid()

# Time series decomposition (trend, seasonal, and residual components)
decomposed <- decompose(rice_t_s)

# Plot the decomposed time series components
plot(decomposed, col="blue")

# Plotting the time series using ggplot2 for better visualization
ggplot(data, aes(x = Date, y = Rice_Prices)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Rice Prices Trend (2005-2025)",
       x = "Year", y = "Rice Prices") +
  theme_minimal()

# Checking for stationarity using Augmented Dickey-Fuller Test
adf_test <- adf.test(rice_t_s)
print(adf_test)

# Forecasting using ARIMA model
model <- auto.arima(rice_t_s)

# Forecast the next 12 months
forecast_values <- forecast(model, h = 12)

# Plot the forecasted values
plot(forecast_values, main="Rice Prices Forecast",
     ylab="Rice Prices", xlab="Year")

# Summary of the ARIMA model
summary(model)