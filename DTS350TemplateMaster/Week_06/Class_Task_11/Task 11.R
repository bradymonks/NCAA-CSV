library(tidyverse)

#class exercises

ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.145, color = "white")+
  theme_bw()+
  labs( x = "Duration of Eruption (minutes)",
        y = "Number of Observations")

new_faithful <- faithful %>%
  select(eruptions, waiting) %>%
  mutate(
    wait = case_when(
      waiting >= 67 ~ "> 67",
      waiting < 67  ~ "<= 67" 
    )
  )


ggplot(data = new_faithful, mapping = aes(x = eruptions, fill = wait)) + 
  geom_histogram(binwidth = 0.145, color = "white")+
  theme_bw()+
  labs( x = "Duration of Eruption (minutes)",
        y = "Number of Observations")

install.packages("hexbin")
library(hexbin)

x <- new_faithful$eruptions
y <- new_faithful$waiting


?hexbin

ggplot(data = new_faithful, mapping = aes(x = eruptions, y = waiting))+
  geom_hex()+
  labs( x = "Duration of Eruption (minute)",
        y = "Time between eruptions (minutes)",
        fill = "Number of observations")

# Task
library(tidyverse)

dffh <- ourworldindata::financing_healthcare

?financing_healthcare

view(dffh)

dffh_1 <- group_by(dffh, continent,country, year) %>%
            select(year, continent,country, health_exp_total, child_mort) %>%
            summarise( 
                  exp_mean = mean( health_exp_total, na.rm = TRUE),
                  mort_mean = mean( child_mort, na.rm = TRUE))

dffh_1 <- na.omit(dffh_1)

view(dffh_1)


ggplot(data = dffh_1)+
  geom_line(mapping = aes(group = country,x = year, y = exp_mean, color = continent))+
  facet_wrap(~continent)+
  labs(x = "Year",
       y = "Expenditure",
       color = "Continent",
       title = "Average Expenditure over the Years for each Country/Continent"
       )

ggplot(data = dffh_1)+
  geom_line(mapping = aes(group = country,x = year, y = mort_mean, color = continent))+
  facet_wrap(~continent)+
  labs(x = "Year",
       y = "Child Mortality Rate",
       color = "Continent",
       title = "Average Child Mortality over the Years for each Country/Continent"
  )
