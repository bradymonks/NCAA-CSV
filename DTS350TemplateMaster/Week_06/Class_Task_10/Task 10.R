# Task 10

library(tidyverse)
library(nycflights13)
library(dplyr)

head(flights, 10)
tail(flights, 10)

flights

# There are 336,776 rows

summary(flights)

# There are NAs in dep_time, dep_delay,arr_time, arr_delay,tailnum,air_time

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay))
fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))

fl_bp + geom_boxplot()


fl_sc + geom_point()

# Added Labels


fl_bp + geom_boxplot() + labs( x = "Carrier Abbreviation",
                               y = "Departure Delay",
                               title = "Departure Delay Boxplots by Carrier")


fl_sc + geom_point() + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")

# Zoom in 

fl_bp + 
  geom_boxplot() + 
  labs( x = "Carrier Abbreviation",
        y = "Departure Delay (minutes)",
        title = "Departure Delay Boxplots by Carrier")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))


fl_sc + geom_point() + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")+
                       coord_cartesian(ylim = c(50, 100))+
                       scale_y_continuous(breaks = c(60, 75, 90))+
                       scale_x_continuous(breaks = c(800, 815, 830, 845, 860))

# Colored

fl_sc + geom_point(aes( color = origin)) + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  scale_x_continuous(breaks = c(800, 815, 830, 845, 860))+
  scale_color_brewer(palette = "Set1")

# Final

plot1 <- fl_sc + geom_point(aes( color = origin)) + labs( x= "Departure Time",
                                                 y= "Departure Delay (minutes)",
                                                 title = "Departure Delay For Each Departure Time")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  scale_x_continuous(breaks = c(800, 815, 830, 845, 860))+
  scale_color_brewer(palette = "Set1")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 35, hjust=1))
plot1

ggsave("plot1.png", plot1)

plot2 <- fl_bp + 
  geom_boxplot() + 
  labs( x = "Carrier Abbreviation",
        y = "Departure Delay (minutes)",
        title = "Departure Delay Boxplots by Carrier")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 35, hjust=1))

plot2

ggsave("plot2.png", plot2)


# Final

library(viridis)
library(ggrepel)

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

rest <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) != 1) 


plot3_1 <- ggplot(best_in_class, aes(displ, hwy)) +
  geom_point(aes(colour = class), data = rest, size = 4)+
  geom_point(aes(colour = class, fill = class), shape=21, stroke = 2.5, size = 3) + 
  scale_fill_manual(values=c("white", "white","white","white","white","white","white")) + 
  geom_label_repel(aes(label = model, color = class), label.size = NA, fill = NA,)  +
  theme_bw()+
  theme(
    #legend.position = "none",
    panel.grid.minor = element_blank())+
  labs( x = "Engine displacement",
        y = "Miles per gallon (highway)",
        color = "Vehicle Type"
        )+
  coord_cartesian(ylim = c(15, 45), xlim = c(1,7))+
  scale_y_continuous(breaks = c(20, 30, 40))+
  scale_x_continuous(breaks = c(2,3,4,5,6,7))+
  scale_colour_viridis_d() 

plot3_1

#OR

plot3 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class), size = 4) +
  geom_point(aes(colour = class),size = 3, shape = 21, fill = "white", stroke = 2.5, data = best_in_class) +
  geom_label_repel(aes(label = model, colour = class), label.size = NA, fill = NA,data = best_in_class)+
  theme_bw()+
  theme(panel.grid.minor.x = element_blank(), panel.grid.minor.y = element_blank())+
  scale_colour_viridis_d()+
  #coord_cartesian(ylim = c(15, 45), xlim = c(1,7))+
  scale_y_continuous(breaks = c(20, 30, 40))+
  scale_x_continuous(breaks = c(2,3,4,5,6,7))+
  labs( x = "Engine displacement",
        y = "Miles per gallon (highway)",
        color = "Vehicle Type"
  )
plot3

ggsave("plot3.png",plot3)
