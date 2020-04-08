#Q3_Explorer

library(data.table)
library(ggplot2)

runoff_stations <- readRDS('./data/runoff_stations_raw.rds')
runoff_day <- readRDS('./data/runoff_day_raw.rds')


aver_runoff_stations <- runoff_day[, .(mean_runoff = mean(value)), by = sname]
aver_runoff_stations <- aver_runoff_stations[, mean_runoff := round(mean_runoff, 3)]

ggplot(aver_runoff_stations, aes(x = sname, y = mean_runoff)) +
  geom_bar(stat = "identity", width = 0.4) + 
  theme(axis.text.x = element_text(size = 6))
