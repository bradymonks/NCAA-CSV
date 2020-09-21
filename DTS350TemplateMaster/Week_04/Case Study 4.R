#Case Study 4

library(tidyverse)
library(nycflights13)
install.packages('ggbeeswarm')
library(ggbeeswarm)
view(flights)


Delta <- filter(flights, carrier == "DL")
view(Delta)

DeltaGB <- group_by(Delta, origin)
DeltaGB

DeltaGB <- summarise(DeltaGB,
                      mean = mean(arr_delay, na.rm = TRUE),
                      sd = sd(arr_delay, na.rm = TRUE))

DeltaGB

ggplot(data = DeltaGB)+
  geom_point(mapping = aes(x = origin, y = mean))



flightsworst <- group_by(flights, dest)

flightsworst <- summarise(flightsworst,
                            mean = mean(arr_delay, na.rm = TRUE),
                            sd = sd(arr_delay, na.rm = TRUE),
                            count = n())

flights2 <- filter(flightsworst, 
                    count >40)

library(ggrepel)

ggplot(data = flights2)+
    geom_point(mapping = aes(x = reorder(dest, mean), y = mean))+
    geom_text_repel(aes(x = dest, y = mean, label = dest))

