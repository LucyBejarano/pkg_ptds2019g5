##### For live demo 
library(dplyr)
library(tidyr)
library(ptds2019g5)
path <- "./data/formatted/"
pollutant <- c("CO", "NO2", "O3", "PM10", "SO2", "PM2.5")
file_ext <- "_mars18_oct19.csv"

loaded_file <- load_data(path, pollutant, file_ext)
loaded_file <- clean_list(loaded_file, pollutant)
loc <- get_location_name(loaded_file)

for (i in 1:length(loaded_file)) {
  assign(pollutant[i], loaded_file[[i]])
}

##### Let's do a little bit of data science
CO <- CO %>%
  mutate(pollutant = "CO")
NO2 <- NO2 %>%
  mutate(pollutant = "NO2")
O3 <- O3 %>%
  mutate(pollutant = "O3")
PM10 <- PM10 %>%
  mutate(pollutant = "PM10")
SO2 <- SO2 %>%
  mutate(pollutant = "SO2")
PM2.5 <- PM2.5 %>%
  mutate(pollutant = "PM2.5")


CO <- pivot_longer(CO, cols = c(2:10))
NO2 <- pivot_longer(NO2, cols = c(2:17))
O3 <- pivot_longer(O3, cols = c(2:17))
PM10 <- pivot_longer(PM10, cols = c(2:17))
SO2 <- pivot_longer(SO2, cols = c(2:10))
PM2.5 <- pivot_longer(PM2.5, cols = c(2:15))


pollutant_data <- CO %>%
  full_join(NO2) %>%
  full_join(O3) %>%
  full_join(PM10) %>%
  full_join(SO2) %>%
  full_join(PM2.5)


#### For weather measurements
path2 <- "./data/formatted/"
weather <- c("TEMP", "PREC")
file_ext2 <- "_juil18_oct19.csv"

loaded_weather <- load_data2(path, weather, file_ext2)
loaded_weather <- clean_list(loaded_weather, weather)

for (i in 1:length(loaded_weather)) {
  assign(weather[i], loaded_weather[[i]])
}

### Data science again! 
TEMP <- TEMP %>%
  mutate(weather = "temperature")
PREC <- PREC %>%
  mutate(weather = "precipitation")

TEMP <- pivot_longer(TEMP, cols = c(2:17))
PREC <- pivot_longer(PREC, cols = c(2:17))

weather_data <- TEMP %>%
  full_join(PREC)

run_demo()

