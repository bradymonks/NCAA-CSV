#Task 6

library(tidyverse)


Task6Data <- read_csv("task6data.csv")

Task6Data

colnames(Task6Data)


Task6Data <- Task6Data %>%
              rename(
                GDP_Per_Capita_USD = "GDP per capita (current US$)",
                Food_Expenditure_USDA_2017 = "Food expenditure (USDA (2017))",
                Total_Population = "Total population (Gapminder"
              )

colnames(Task6Data)


ggplot(data = Task6Data)+
    geom_point(mapping = aes(x = GDP_Per_Capita_USD, y = Food_Expenditure_USDA_2017/Total_Population, color = Continent, size = Total_Population))
Task6Data$Food_Expenditure_USDA_2017

Task6Data1 <- read_csv("GDP_per.csv")

Task6_2015 <- filter(Task6Data1,
                      Year == 2015)
view(Task6_2015)


view(Task6_2015)
colnames(Task6Data1)
ggplot(data = Task6_2015)+
  geom_point(mapping = aes(x = GDP_Per_Capita_USD, y = Food_Expenditure_USDA_2017/Total_Population, color = Continent, size = Total_Population/100000))
