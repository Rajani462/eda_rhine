##Explorer questions--------------

library(data.table)
library(ggplot2)
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
#-------------------------------------------------
#Q1
#Ans: No. It seems that the complex topography and high altitude are the main factors makes it behaviour different from the other stations.

#Q2-------------------------------

precip_raw <- readRDS('./data/raw/precip_day.rds')
str(precip_raw)

#Monthly precipitation

precip_raw[, year := year(date)]
precip_raw[, month := month(date)]

precip_month <- precip_raw[, .(value = sum(value)), by = .(month, year)]
precip_month[, date := as.Date(paste0(year, '-', month, '-1'))]

ggplot(precip_month, aes(factor(month), value)) + 
  geom_boxplot(fill = colset_4[4]) + 
  theme_bw()

#Annual precipitation

precip_year <- precip_raw[, .(value = sum(value)), by = .(year)]

ggplot(precip_year[year > 1980 & year < 2019], aes(year, value)) + 
  geom_line(col = colset_4[1]) + 
  geom_point(col = colset_4[1]) + 
  theme_minimal()

#Seasonal precipitation

precip_raw[month == 12 | month == 1 | month == 2, season := 'winter']
precip_raw[month == 3 | month == 4 | month == 5, season := 'spring']
precip_raw[month == 6 | month == 7 | month == 8, season := 'summer']
precip_raw[month == 9 | month == 10 | month == 11, season := 'autumn']
precip_raw[, season := factor(season, levels = c('winter', 'spring', 'summer', 'autumn'))]

precip_winter <- precip_raw[season == 'winter', .(value = sum(value)), by = .(year)]
precip_summer <- precip_raw[season == 'summer', .(value = sum(value)), by = .(year)]

#Regression
ggplot(precip_winter[year < 2019], aes(year, value)) + 
  geom_line(col = colset_4[3]) + 
  geom_point(col = colset_4[3]) + 
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) + 
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) + 
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") + 
  ylab(label = "precipitation") + 
  ggtitle("Winter")
  theme_bw()
  
  
ggplot(precip_summer[year < 2019], aes(year, value)) + 
  geom_line(col = colset_4[3]) + 
  geom_point(col = colset_4[3]) + 
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) + 
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) + 
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") + 
  ylab(label = "precipitation") + 
  ggtitle("Summer")
  theme_bw()
  
to_plot <- rbind(cbind(precip_winter, season = factor('winter')), 
                   cbind(precip_summer, season = factor('summer')))
year_thres <- 1980

to_plot[year < year_thres, period := factor('1950-1980')]
to_plot[year >= year_thres, period := factor('1981-2016')]
to_plot[year < year_thres, period := factor('1950-1980')]
to_plot[year >= year_thres, period := factor('1981-2016')]

ggplot(to_plot, aes(season, value, fill = period)) +
  geom_boxplot() +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Season") +
  ylab(label = "Precipitation") +
  theme_bw()


#Q3-------------------------------------




#Q4