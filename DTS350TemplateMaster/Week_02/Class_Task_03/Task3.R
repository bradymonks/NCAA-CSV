# Task 3

##Notes
##Computational Thinking
##"students demonstrate algorithmic thinking whenever they create or use a well-defined series 
##of steps to achieve a desired outcome". Decomposition is breaking down a complex problem and 
##working one component at a time. Decomposotion makes unapproachable problems approachable. 
##Abstraction is stripping away complex unneeded components to find a solution (not worrying 
##unimportant components). Pattern recognition is analyzing trends and using those trends to find
##solutions. Need to have a good attitude towards finding solutions (confidence, positive, tenacity, 
##curiosity, etc.). 

##Beginner's Mistakes
##Top mistakes: Writing code without planning (Think, research, plan, write, validate, modify), 
##planning too much (the perfect plan doesn't exist, have a fluid plan), underestimating code quality,
##picking the first solution, not quitting (fail early and fail often), not googling, planning for
##the unknown, making existing code worse, writing comments about obvious things, not writing tests,
##if it's working it's right, not targeting end-user experience, reinventing the wheel,having wrong 
##attitude towards code reviews, not taking breaks

##



##DPLYR
library(tidyverse)
library(ggplot2)
library(dplyr)

?iris

head(arrange(iris, Sepal.Length))

testdat <- select(iris, Species, Petal.Width)
testdat

new1 <- group_by(iris, Species)
view(new1)
new2 <- summarise(new1, 
          mean(Sepal.Length),
          mean(Sepal.Width),
          mean(Petal.Length),
          mean(Petal.Width))
view(new2)

new3 <- new1 %>%
  summarise_all(list(sd,mean))
view(new3)  


## Questions
## What are the average ages for athletes retiring among three
## major sports (NFL, NBA, MLB)?
# Feedback
#  This would include a lot of data and could be used to create some intersting visuals,
#  One thing you could go off of is, say a company like Dick's, which sport and players would they
#  want to focus on if they wanted to keep their inventory the same for the longest amount of time.
## Do tree heights differ among different regions in the United
## states (6 tree species, 6 regions)?
# Feedback
#  This is an interesting inquiry. One thing you could do with this is create a map and shade in the regions
#  fron shortest to tallest and even perform an ANOVA to see if there is even any statistical difference.
## Does restaurant popularity(sales) differ among different regions in
## the U.S. (6 regions(facet), up to 30 restaurants)
# Feedback
#  Same thing as the last question, except you can dive deeper since you now can break it down further into restaurants.
## What is the average home run distance at every major league stadium
## over the last 5-10 years?
# Feedback
# This is more of a simple question that might be hard to find data on. But would be fairly simple on creating visuals. It
# would be cool if you were able to map out every stadium. 
