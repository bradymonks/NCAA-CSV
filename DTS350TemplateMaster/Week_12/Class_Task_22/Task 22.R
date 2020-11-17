library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(ggrepel)
library(sf)
library(maps)
library(ggsflabel)

usa <- us_states()

usa <- usa %>%
  filter ( name != "Hawaii",
           name != "Alaska",
           name != "District of Columbia",
           name != "Puerto Rico")

id_counties <- us_counties(states = "ID")

cities <- us_cities()

top_3 <- cities %>%
  filter(state_name != "Hawaii",
         state_name != "Alaska",
         state_name != "District of Columbia")%>%
  group_by(state_name)%>%
    slice_max(order_by = population, n = 3) %>%
    mutate(rank = rank(-population))

top_city <- top_3 %>%
  filter(rank == 1)

top_city


ggplot()+
  geom_sf(data = usa, fill = NA)+
  geom_sf(data = id_counties, fill = NA)+
  geom_sf(data = top_3, mapping = aes(size = population/1000, color = rank)) +
  geom_sf_label_repel(data = top_city, mapping = aes(label = city), color = "navy blue")+
  theme_bw()+
  labs(x = NULL,
       y = NULL,
       size = "Population \n (1000)")+
  guides(color = FALSE)
  
