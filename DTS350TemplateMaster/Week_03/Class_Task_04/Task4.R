#Task 4


#Exercise 1
ggplot(data = iris, mapping = aes(x=Sepal.Width, y = Sepal.Length)) +
  geom_point()

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length))
#nothing changed within the graph



#Exercise 2
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 18)

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 11)


#Exericse 3
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 18)+
  
  ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species))

#Exercise 4

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species))+
  scale_shape_manual(values = c(1,5,7))

#Exercise 5

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_x_log10() + scale_y_log10()

#Exercise 6
ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_manual(values = c("purple","darkorange","blue"))+
  scale_x_log10() + scale_y_log10()

#Exercise 7

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_brewer(palette = "Set1")+
  scale_x_log10() + scale_y_log10()

#Exercise 8

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_brewer(palette = "Set1")+
  scale_x_log10() + scale_y_log10()+
  labs( x = "Sepal Width (cm)",
        y = "Sepal Length (cm)",
        shape = "Species of Iris",
        color = "Species of Iris")
#the legends collapse into one

#Exercise 9

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_brewer(palette = "Set1")+
  scale_x_log10() + scale_y_log10()+
  labs( x = "Sepal Width (cm)",
        y = "Sepal Length (cm)",
        shape = "Species of Iris",
        color = "Species of Iris",
        title = "Title")+
  theme(plot.title = element_text(hjust = .5))+
  theme_bw()

#Exercise 10

ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_brewer(palette = "Set1")+
  scale_x_log10() + scale_y_log10()+
  labs( x = "Sepal Width (cm)",
        y = "Sepal Length (cm)",
        shape = "Species of Iris",
        color = "Species of Iris",
        title = "Title")+
  theme_classic()

#Exercise 11
p <- ggplot(data = iris)+
  geom_point(mapping = aes(x = Sepal.Width, 
                           y = Sepal.Length,
                           shape = Species,
                           color = Species))+
  scale_shape_manual(values = c(1,5,7))+
  scale_color_brewer(palette = "Set1")+
  scale_x_log10() + scale_y_log10()+
  labs( x = "Sepal Width (cm)",
        y = "Sepal Length (cm)",
        shape = "Species of Iris",
        color = "Species of Iris",
        title = "Title")+
  theme_classic()+
  facet_wrap(~ Species)


library(ggplot2)
library(tidyverse)
library(dplyr)
averages <- iris %>% group_by(Species) %>% mutate(avglength = mean(Sepal.Length))

p + geom_hline(data = averages, mapping = aes( yintercept = avglength))
