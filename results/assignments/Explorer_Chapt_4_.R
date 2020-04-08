library(data.table)
library(ggplot2)

#Q1
#There is no difference between median and 0.5 quantile.

#Q2
#Because the runoff is right skewed.

#Q3
#Both LOBI and REES located in very low and similar altutude areas compared to the remaning station.

#Q4.##not complete...

readRDS('./data/runoff_summary.rds')
runoff_months <- readRDS('./data/runoff_month.rds')
runoff_stats <- readRDS('./data/runoff_stats.rds')
runoff_day <- readRDS('./data/runoff_day.rds')
runoff_years <- readRDS('./data/runoff_year.rds')


max_runoff_years <- setDT(runoff_years)[, .SD[which.max(value)], by=sname]
max_runoff_months <- setDT(runoff_months)[, .SD[which.max(value)], by = sname]

