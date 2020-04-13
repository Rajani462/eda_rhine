##Navigator question-----------------

library(data.table)
library(ggplot2)
precip_raw <- readRDS('./data/raw/precip_day.rds')
runoff_summary <- readRDS('data/runoff_summary.rds')
runoff_summary_key <- readRDS('data/runoff_summary_key.rds')
runoff_stats <- readRDS('data/runoff_stats.rds')
runoff_month_key <- readRDS('data/runoff_month_key.rds')
runoff_summer_key <- readRDS('data/runoff_summer_key.rds')
runoff_winter_key <- readRDS('data/runoff_winter_key.rds')
runoff_year_key <- readRDS('data/runoff_year_key.rds')
runoff_summer <- readRDS('data/runoff_summer.rds')
runoff_winter <- readRDS('data/runoff_winter.rds')

colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
theme_set(theme_bw())
#---------------------------------------
#Q1-

year_thres <- 2000

runoff_month_key[year < year_thres, period := factor('pre_2000')]
runoff_month_key[year >= year_thres, period := factor('aft_2000')]

runoff_year_key[year < year_thres, period := factor('pre_2000')]
runoff_year_key[year >= year_thres, period := factor('aft_2000')]

ggplot(runoff_month_key, aes(factor(month), value, fill = period)) + 
  geom_boxplot() + 
  facet_wrap(~sname, scales = 'free') + 
  scale_fill_manual(values = colset_4[c(4, 1)]) + 
  xlab(label = "Month") + 
  ylab(label = "Runoff (m3/s)") + 
  theme_bw()
  
  
ggplot(runoff_month_key[year > 1983], aes(factor(month), value, fill = period)) + 
  geom_boxplot() + 
  facet_wrap(~sname, scales = 'free_y') + 
  scale_fill_manual(values = colset_4[c(4, 1)]) + 
  xlab(label = "Month") + 
  ylab(label = "Runoff (m3/s)") + 
  theme_bw()
  
ggplot(runoff_year_key, aes(year, value, fill = period)) + 
  geom_boxplot() + 
  facet_wrap(~sname, scales = 'free') + 
  scale_fill_manual(values = colset_4[c(4, 1)]) + 
  xlab(label = " Year") + 
  ylab(label = "Runoff (m3/sec)") + 
  theme_bw()  
  
ggplot(runoff_year_key[year > 1983], aes(year, value, fill = period)) + 
  geom_boxplot() + 
  facet_wrap(~sname, scales = 'free') + 
  scale_fill_manual(values = colset_4[c(4, 1)]) + 
  xlab(label = " Year") + 
  ylab(label = "Runoff (m3/sec)") + 
  theme_bw()


#Q2--------
