# Installing required libraries (Run only once)
install.packages("forecast")
install.packages("ggplot2")

# Loading libraries
library(ggplot2)
library(forecast)

# Loading the dataset
data <- read.csv("C:/Users/moham/Downloads/Airplanes_Dataset.csv")

# Checking the structure of the dataset
str(data)

# Processing Date variable to date format
data$Date <- as.Date(data$Date, format="%Y-%m-%d")

# Summary of the dataset
summary(data)

# Plotting the histogram of airplane production
ggplot(data, aes(x = Airplanes)) +
  geom_histogram(binwidth = 5, fill = "pink", color = "black") +
  labs(title = "Airplane Production Distribution", x = "Airplanes (Number)", y = "Frequency") +
  theme_minimal()

# Creating the time series object
airplane_t_s <- ts(data$Airplanes, start = c(2005, 1), frequency = 12)

# Plotting the time series using base R
plot(airplane_t_s, main = "Airplane Production Time series (2005-2025)",
     ylab = "Number of Airplanes", xlab = "Year", col = "blue", lwd = 2)
grid()

# Time series decomposition (trend, seasonal, and residual components)
decomposed <- decompose(airplane_t_s)

# Plot the decomposed time series components
plot(decomposed, col="blue")

# Plotting the time series using ggplot2 for better visualization
ggplot(data, aes(x = Date, y = Airplanes)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Airplane time series(2005-2025)",
       x = "Year", y = "Number of Airplanes") +
  theme_minimal()

# Checking for stationarity using Augmented Dickey-Fuller Test
adf_test <- adf.test(airplane_t_s)
print(adf_test)

# Forecasting using ARIMA model
model <- auto.arima(airplane_t_s)

# Forecast the next 12 months
forecast_values <- forecast(model, h = 12)

# Plot the forecasted values
plot(forecast_values, main="Airplane Forecast",
     ylab="Number of Airplanes", xlab="Year")

# Summary of the ARIMA model
summary(model)