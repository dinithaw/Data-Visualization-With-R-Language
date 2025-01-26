# Installing required libraries (Run only once)
install.packages("forecast")
install.packages("ggplot2")
install.packages("tseries")

# Loading libraries
library(ggplot2)
library(forecast)
library(tseries)

# Loading the dataset
data <- read.csv("//Users//dinithalakminwickramasinghe//Desktop//R//Population_Dataset.csv")

# Checking the structure of the dataset
str(data)

# Processing date variable to date format
data$Date <- as.Date(data$Date, format="%Y-%m-%d")

# Summary of the dataset
summary(data)

# Plotting the histogram of population
ggplot(data, aes(x = Population)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Population Distribution", x = "Population", y = "Frequency") +
  theme_minimal()

# Creating the time series object
pop_t_s <- ts(data$Population, start = c(2005, 1), frequency = 12)

# Plotting the time series using base R
plot(pop_t_s, main = "Population Time Series (2005-2025)",
     ylab = "Population", xlab = "Year", col = "green", lwd = 2)
grid()

# Time series decomposition (trend, seasonal, and residual components)
decomposed <- decompose(pop_t_s)

# Plot the decomposed time series components
plot(decomposed, col="green")

# Plotting the time series using ggplot2 for better visualization
ggplot(data, aes(x = Date, y = Population)) +
  geom_line(color = "green", size = 1) +
  labs(title = "Population Trend (2005-2025)",
       x = "Year", y = "Population") +
  theme_minimal()

# Checking for stationarity using Augmented Dickey-Fuller Test
adf_test <- adf.test(pop_t_s)
print(adf_test)

# Forecasting using ARIMA model
model <- auto.arima(pop_t_s)

# Forecast the next 12 months
forecast_values <- forecast(model, h = 12)

# Plot the forecasted values
plot(forecast_values, main="Population Forecast",
     ylab="Population", xlab="Year")

# Summary of the ARIMA model
summary(model)