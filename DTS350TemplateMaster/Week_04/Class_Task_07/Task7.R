library(tidyverse)
library(nycflights13)

df <- nycflights13::flights
view(df)
df

MCIdf <- filter(df, dest == "MCI")  
MCI <- group_by(MCIdf, carrier)%>%
        summarise(avg_delay = mean(arr_delay, na.rm = TRUE))

MCI_plot <- ggplot(data = MCI) +
                geom_col(mapping = aes(reorder(carrier, avg_delay),
                         y = avg_delay, fill = carrier))

MCI_plot
ggsave("mciplot.png", MCI_plot )

LAXdf <- filter(df, dest == "LAX")  
LAX <- group_by(LAXdf, carrier)%>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))

LAX_plot <- ggplot(data = LAX) +
  geom_col(mapping = aes(reorder(carrier, avg_delay),
                         y = avg_delay, fill = carrier))

LAX_plot
ggsave("laxplot.png", LAX_plot)


DENdf <- filter(df, dest == "DEN")  
DEN <- group_by(DENdf, carrier)%>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))


DEN_plot <- ggplot(data = DEN) +
  geom_col(mapping = aes(reorder(carrier, avg_delay),
                         y = avg_delay, fill = carrier))

DEN_plot
ggsave("denplot.png", DEN_plot )

## "my goal is to get the maximum amount of information 
## about the data set in the minimal amount of time'

## Looking at the graphs above I can see that for two of the 
## airports, Delta had the lowest average arrival delay, so I can
## conclude that if I'm headed to KC or LA I would want to take
## Delta in order to minimize my flight arrival delay.


