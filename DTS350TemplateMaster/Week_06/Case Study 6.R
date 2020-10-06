library(tidyverse)

# Case Study 6

view(diamonds)

?diamonds

ggplot(data = diamonds)+
  geom_point(mapping = aes( x = x, y = y, color = color))+
  labs( x = "Length",
        y = "Width",
        title = "Length v. Width")

ggplot(data = diamonds)+
  geom_point(mapping = aes( x = z, y = y, color = color))+
  labs( x = "Depth",
        y = "Width",
        title = "Depth v. Width")

ggplot(data = diamonds)+
  geom_point(mapping = aes( x = x, y = z, color = color))+
  labs( x = "Length",
        y = "Depth",
        title = "Length v. Depth")


dia1 <- group_by(diamonds, clarity) %>%
          summarise(mean = mean(price))

dia1

clarity <- ggplot(data = dia1)+
  geom_col(mapping = aes(x = clarity, y = mean, fill = clarity))+
  theme_bw()+
  labs(x = "Clarity",
       y = "Average Price",
       fill = "Clarity",
       title = "Average Price for each Clarity Category")


dia2 <- group_by(diamonds, carat) %>%
  summarise(mean = mean(price))

dia2

carat <- ggplot(data = dia2)+
  geom_col(mapping = aes(x = carat, y = mean, fill = carat))+
  theme_bw()+
  labs(x = "Carat",
       y = "Average Price",
       fill = "Carat",
       title = "Average Price for each Carat Category")


dia3 <- group_by(diamonds, y) %>%
  summarise(mean = mean(price))

dia3

width <- ggplot(data = dia3)+
  geom_col(mapping = aes(x = y, y = mean, fill = y))+
  theme_bw()+
  labs(x = "Width",
       y = "Average Price",
       fill = "Width",
       title = "Average Price by Width")+
  coord_cartesian(xlim = c(2.5, 12))+
  scale_x_continuous(breaks = c(2.5, 5.0, 7.5, 10.0))




dia4 <- group_by(diamonds, x) %>%
  summarise(mean = mean(price))

dia4

length <- ggplot(data = dia4)+
  geom_col(mapping = aes(x = x, y = mean, fill = x))+
  theme_bw()+
  labs(x = "Length",
       y = "Average Price",
       fill = "Length",
       title = "Average Price by Length")+
  coord_cartesian(xlim = c(2.5, 12))+
  scale_x_continuous(breaks = c(2.5, 5.0, 7.5, 10.0))



dia3


dia5 <- group_by(diamonds, z) %>%
  summarise(mean = mean(price))

dia5

depth <- ggplot(data = dia5)+
  geom_col(mapping = aes(x = z, y = mean, fill = z))+
  theme_bw()+
  labs(x = "Depth",
       y = "Average Price",
       fill = "Depth",
       title = "Average Price by Depth")+
  coord_cartesian(xlim = c(1.5,8))+
  scale_x_continuous(breaks = c(2.5, 5.0, 7.5))



dia6 <- group_by(diamonds, table) %>%
  summarise(mean = mean(price))

dia6

table <- ggplot(data = dia6)+
  geom_col(mapping = aes(x = table, y = mean, fill = table))+
  theme_bw()+
  labs(x = "Table",
       y = "Average Price",
       fill = "Table",
       title = "Average Price by Table")


length
width
depth
table

dia_type <- diamonds %>%
  select(carat, price) %>%
    mutate(
      type = case_when(
        price < 4000 ~ "<$4000",
        price < 8000 ~ "<$8000",
        price < 12000 ~ "<$12000",
        price > 12000 ~ ">$12000"
      )
    )

dia_type_sum <- group_by()

ggplot(data = dia_type)+
  geom_point(mapping = aes(x = price, y = carat, color = type))+
  facet_wrap(~type)

