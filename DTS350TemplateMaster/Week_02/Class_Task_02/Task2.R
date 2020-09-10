##DTS350 Task 2

##Chapter 4 Code

1 / 200 * 30

(59 + 73 + 2) / 3

sin(pi/2)

x <- 3 * 4
x

#object_name <- value
one_hundred <- 100
one_hundred

#what's in a name 
#examples
## i_use_snake_case
## otherPeopleUseCamelCase
## some.people.use.periods
## And_aFew.People_RENOUNCEconvention

this_is_a_really_long_name <- 2.5

this_is_a_really_long_name <- 3.5
this_is_a_really_long_name

r_rocks <- 2 ^ 3
r_rocks

seq(1,10)

x <- "hello world"
x

y <- seq(1,10, length.out = 5)
y


##
##library(tidyverse)
##
##ggplot(dota = mpg) + 
##  geom_point(mapping = aes(x = displ, y = hwy))
##
##fliter(mpg, cyl = 8)
##filter(diamond, carat > 3)
##

library(tidyverse)
library(ggplot2)
ggplot(data = mpg) +
  geom_point(mapping = aes (x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

## Chapter 1 Code

library(ggplot2)
library(dplyr)
install.packages("nycflights13")
library(nycflights13)
library(knitr)

flights
View(flights)
glimpse(flights)

airlines
kable(airlines)

airlines$name

glimpse(airports)

?flights

##Learned Concepts
##I learned about some new ways of getting an 
##overview of dataset I'm looking at


## IRIS data
install.packages("iris")
library(iris)

?iris
iris

ggplot(data=iris)+
  geom_point(mapping = aes(x= Sepal.Length, y=Sepal.Width, size = Petal.Width, alpha = Petal.Length))+
  facet_wrap(~ Species, nrow =2)


##Does the species  determine the size of the petals?
##The visual does a good job of answering this question, because for
##each species the petal size is pretty consistent throughout.