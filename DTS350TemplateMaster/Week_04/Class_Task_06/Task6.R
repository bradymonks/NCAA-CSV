#Task 6

library(tidyverse)


data1 <- read_csv("life-expectancy-vs-gdp-per-capita.csv")

view(data1)

data2015 <- filter(data1, Year == 2015)
view(data2015)

data2015 <- data2015 %>%
  rename(
    GDP_Per_Capita_USD = "Real GDP per capita in 2011US$, multiple benchmarks (Maddison Project Database (2018))",
    Life_expectancy = "Life expectancy",
    Total_Population = "Total population (Gapminder, HYDE & UN)",
    Country = "Entity"
  )
data2015v2 <- na.omit(data2015)

view(data2015v2)

ggplot(data = data2015v2)+
  geom_point(mapping = aes(x = GDP_Per_Capita_USD, y = Life_expectancy, size = Total_Population/10000, color = Continent,))+
  #geom_text(aes(label = Country), data = data2015v2)
  labs(x = "GDP per capita",
       y = "Life expectancy at birth",
       title = "Life expectancy vs. GDP per capita, 2015",
       subtitle = "GDP per capita is measured in 2011 international dollars, which corrects for inflation and cross-country price differences.")+  
  guides(size = FALSE)+
  scale_x_continuous(breaks = seq(0,120000, by = 20000),labels=scales::dollar_format())+
  scale_y_continuous(breaks = seq(50 , 80 , by = 5 ))+
  #scale_colour_manual(values = c(Africa = "purple", Asia = "blue", Europe = "navy", North America = "orange", Oceania = "brown", South America = "black")+
  theme(plot.title = element_text(hjust = 0),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_line(colour = "grey",linetype = 2),
        panel.grid.major.y = element_line(colour = "grey",linetype = 2))

ggsave("Mimic_Plot.png")  


install.packages("devtools")
library(devtools)
devtools::install_github("drsimonj/ourworldindata")
df <- ourworldindata::child_mortality



