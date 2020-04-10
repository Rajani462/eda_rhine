##Navigator

library(data.table)
library(ggplot2)
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

runoff_summary <- readRDS('./data/runoff_summary.rds')
runoff_stats <- readRDS('./data/runoff_stats.rds')
runoff_day <- readRDS('./data/runoff_day.rds')
runoff_month <- readRDS('./data/runoff_month.rds')

#Q1. runoff_stat vs stations plot

runoff_stats <- runoff_day[, .(mean_day = round(mean(value), 0),
                               mid_day = round(median(value), 0),
                               sd_day = round(sd(value), 0),
                               min_day = round(min(value), 0),
                               max_day = round(max(value), 0)), by = sname]

runoff_stats_tidy <- melt(runoff_stats, id.vars = 'sname', variable.name = 'stats', value.name = 'runoff')


ggplot(runoff_stats_tidy, aes(sname, runoff, shape = stats, col = stats)) + 
  geom_point(size = 3) + 
  theme(axis.text.x = element_text(size = 5))



#Q2. Skewness and coeffcient of variation

runoff_stats_cov <- runoff_stats[, cov_day := round(runoff_stats$sd_day / runoff_stats$mean_day, 2)]

runoff_stats_skw <- runoff_stats[, skw_day := (round(3 * (runoff_stats$mean_day - runoff_stats$mid_day) / runoff_stats$sd_day, 2))]

#Q3

runoff_stats_class <- runoff_month[, .(sname, 
                                       value)]
runoff_stats_class[, runoff_class := factor('low')]
runoff_stats_class[value >= 1000 & value < 2000, runoff_class := factor('medium')]
runoff_stats_class[value >= 2000, runoff_class := factor('high')]

to_plot <- runoff_month[runoff_stats_class[, .(value, runoff_class)], on = 'value']

ggplot(to_plot, aes(x = factor(month), y = value, fill = runoff_class, group = month)) +
  geom_boxplot(fill = colset_4[4]) +
  facet_wrap(~sname, scales = 'free') + 
  #scale_fill_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Month") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()



#Q4



#Q5
class_arae_alt <- runoff_summary[, area_class := factor('small')]
class_arae_alt[area >= 9000 & area <= 100000, area_class := factor('medium')]
class_arae_alt[area >= 100000, area_class := factor('large')]

class_arae_alt[, alt_class := factor('low')]
class_arae_alt[altitude >= 40 & altitude <= 300, alt_class := factor('medium')]
class_arae_alt[altitude >= 300, alt_class := factor('high')]

dt <- class_arae_alt[, .(sname, area, area_class, alt_class)]
to_plot <- runoff_stats[dt, on = 'sname']

ggplot(to_plot, aes(mean_day, area, col = area_class, size = alt_class)) + 
  geom_point() + 
  theme_bw()
