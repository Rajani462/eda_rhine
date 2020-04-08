#Navigator Tasks

library(data.table)
library(ggplot2)

runoff_stations <- readRDS('./data/runoff_stations_raw.rds')
runoff_day <- readRDS('./data/runoff_day_raw.rds')

#Q1

new_data_table <- runoff_stations[, .(sname, area, altitude)]
#new_data_table <- melt(new_data_table, id.vars = 'sname')  #tidy format

#Q2

ggplot(new_data_table) +
  geom_point(aes(x = area, y = altitude)) + 
  theme_bw()

#Q3

ggplot(new_data_table, aes(x = area, y = altitude, col = area)) + 
  geom_point() + 
  geom_text(aes(label = sname, colour = area)) + 
  theme_bw()

ggplot(runoff_stations, aes(lon, lat, col = altitude)) + 
  geom_point() + 
  geom_text(aes(label = sname, colour = altitude)) + 
  theme_bw()

#4

#####Explorere Task

#Q1
area (km2)
runoff (m3/s)

#Q2

average_area <- mean(new_data_table$area)
average_area #67069 km2

average_runoff <- mean(runoff_day$value)
average_runoff #1275.114 m3/s

#Q3
aver_runoff_stations <- runoff_day[, .(mean_runoff = mean(value)), by = sname]
aver_runoff_stations <- aver_runoff_stations[, mean_runoff := round(mean_runoff, 3)]

ggplot(aver_runoff_stations, aes(x = sname, y = mean_runoff)) +
  geom_bar(stat = "identity", width = 0.4) + 
  theme(axis.text.x = element_text(size = 6))

#Q4
cor(runoff_stations$altitude, runoff_stations$area)
#Shows a negative relation with correlation of coeffcient = -0.863.
#Reason:Large portion of the basin lies in low altitude areas. 