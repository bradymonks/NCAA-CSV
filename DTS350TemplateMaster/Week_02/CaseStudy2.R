##Case Study 2
library(ggplot2)
library(tidyverse)
library(dplyr)
install.packages("gapminder")
library(gapminder)

view(gapminder)

gapminder1 <- filter(gapminder, country != "Kuwait")
view(gapminder1)

ggplot(data = gapminder1) +
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/10000))+
  facet_wrap(~ year)+
  scale_y_continuous(trans ="sqrt")+
  scale_x_continuous(breaks = seq(0,12500, by = 10000))+
  labs(
    x = "Life Expectancy",
    y = "GDP Per Capita",
    size = "Population 100k"
  )

graphs1 <- group_by(gapminder1, country)
graphs1


graphs2_data <- group_by(gapminder1,continent,year)
graphs2_data

sumgraphs <- summarise(graphs2_data,
                       count = n(),
                       wmgdp = weighted.mean(gdpPercap),
                       sumpop = sum(pop))
sumgraphs

view(sumgraphs)

sumry <- gapminder1 %>%
  group_by(continent, year) %>%
  summarise(
    count = n(),
    wghtgdp = weighted.mean(gdpPercap, na.rm = TRUE),
    sumpop = pop(population, na.rm = TRUE) %>%)

sumry <- gapminder1 %>%
  group_by(continent, year_ %>%
    summarise(
      wghtgdp = weighted.mean(gdpPercap, na.rm = TRUE),
      sumpop = sum(population, na.rm = TRUE) %>%))
    


ggplot(data = sumgraphs)+
    geom_line(mapping = aes(x = year, y = gdpPercap, size = pop, color = continent))+
    facet_wrap(~ continent)+
    labs(
        x = "Year",
        y = "GDP Per Capita",
        size = "Population(100k)",
        color = "Continent"
    )
    
