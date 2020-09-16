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
str(data2015)

data2015v2 <- na.omit(data2015)

view(data2015v2)

ggplot(data = data2015v2)+
  geom_point(mapping = aes(x = GDP_Per_Capita_USD, y = Life_expectancy, size = Total_Population/10000, color = Continent,))+
  labs(x = "GDP per capita",
       y = "Life expectancy at birth",
       title = "Life expectancy vs. GDP per capita, 2015",
       subtitle = "GDP per capita is measured in 2011 international dollars, which corrects for inflation and cross-country price differences.")+  
  guides(size = FALSE)+
  scale_x_continuous(breaks = seq(0,120000, by = 20000),labels=scales::dollar_format())+
  theme(plot.title = element_text(hjust = 0))
  










