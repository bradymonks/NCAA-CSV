#Case Study 4

library(tidyverse)

library(nycflights13)

view(flights)


Delta <- filter(flights, carrier == "DL")
Delta

ggplot(data = Delta)+
  geom_boxplot(mapping = aes(x = origin, y = arr_delay))
