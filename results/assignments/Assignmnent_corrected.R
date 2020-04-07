
#rewtite in a claen code format

library(data.table)

temperatures <- c(3,6,10,14)
weights <- c(1,0.8,1.2,1)

multiplier <- function(x, y) {
  x * y
}

temp_wgt <- multiplier(temperatures,weights) 

#Explorer’s Questions Answers

#1.How big is the Rhine catchment (km2)?
catchment_area <- 185000 #km2
catchment_area <- 18500 * 1000 ^ 2 #(m2)

#2.If it rained for one full day over the whole catchment area at 5mm/hour and all the precipitated water ended up in the river, how much would be the increase in the average river runoff?

rain_hour <- 5 #mm / m2 h (5 mm correspond to surface of 1 m2)
rain_day <- rain_hour * 24 /1000 # rain in m/ m2 day
water_over_catchment <- catchment_area * rain_day  #m3 / day

river_runoff <- 2900 #m3 / s
river_runoff_day <- river_runoff * 60 * 60 * 24 #m3/d

#The water that fell over the catchment in a single day is 

water_over_catchment / river_runoff_day

#3.How much time does a rain drop falling at Alpine Rhine need to reach the ocean? Write a script that performs the calculation.
river_length <- 1233000 #m
river_depth <- 30 #m - assumption 1
river_width <- 200 #m - assumption 2

water_velocity <- river_runoff / (river_depth * river_width) #m/s - Velocity = Flux / Area
time_to_sea <- river_length / water_velocity #s - Time = Length / Velocity

time_to_sea <- time_to_sea / (60 * 60 * 24) #days or about a month.

#4.
#a.Which other hydroclimatic changes reported in the article and not discussed above?
# Ans: There is a major shift of the climatic variables in the entire Rhine basin. These include mainly temperature and precipitation. Higher temperatures will reduce the amount of snow accumulation during winter and evapotranspiration in summer months. Winter precipitation is expected to increase, while it may decrease in summer months.

#b.Can you detect three assumptions made by Middelkoop et al. (2001)?
#Ans: Assumptions around modelling of temperature in climate models, human use of water resources will be similar, CO2 emissions scenario (2.5 degrees temperature increase), percentage of precipitation increase has been evenly distributed in all months, number of days with precipitation remains unchanged (it does not rain more or less often).


#c.Why Middelkoop and his colleagues made this study? Why is it important? For example, the reason for searching for a way to the Orient was that Ottoman Empire monopolized the trade routes across Asia.

#Ans:The study motivation is the consequences of hydroclimatic change to: -winter sports in Alps -flood defense -inland navigation -hydropower generation -water availability for industry, agriculture and domestic use -floodplain development

#d.Are there other studies that have a similar analysis over Rhine, or a similar hypothesis in other regions? (hint: use google scholar or web of science/scopus)

#Ans: Yes.
#https://www.mdpi.com/2073-4441/9/9/684
#https://bioone.org/journals/ambio-a-journal-of-the-human-environment/volume-33/issue-4/0044-7447-33.4.235/Climate-Change-Effects-on-River-Flow-to-the-Baltic-Sea/10.1579/0044-7447-33.4.235.short
#https://www.sciencedirect.com/science/article/pii/S0022169401003481?via%3Dihub


#e. Is there any evidence in the news about low or high flow events of Rhine since 2000?
#Ans :Yes
#https://dredgingandports.com/news/2019/billions-lost-due-to-rhine-traffic-decline-during-low-water/
#https://www.eia.gov/todayinenergy/detail.php?id=37414
#https://www.nytimes.com/2018/11/04/world/europe/rhine-drought-water-level.html
#https://www.cnbc.com/2019/07/31/low-water-levels-in-the-river-rhine-could-create-havoc-for-germanys-economy.html