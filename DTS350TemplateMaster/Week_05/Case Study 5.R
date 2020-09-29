# Case Study 5

# We focus on mass shootings, police victims, and terrorism, but most gun deaths 
# are suicide. 85% of suicides are males. More than half are men older than 45. 
# Another third are homicides (12,000). More than half of homicides are young men.
# Two-thirds of these young men are black. about 1,700 women die due to domestic violence.
# The remaining deaths are accidents. 

library(tidyverse)

data <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/guns-data/master/full_data.csv")

view(data)

data

ggplot(data, aes(x = intent,  y = age))+
  geom_violin()+
  facet_grid(vars(sex), vars(race))

data1 <- group_by(data, year, month, intent, race, sex) %>%
  count(year, month, intent, race, sex, sort = TRUE)


homicide <- filter( data, intent == "Homicide", age > 30)

ggplot(homicide)+
  geom_bar(mapping = aes(x= race, fill = sex), position = 'dodge')+
  facet_wrap(~month)
# 7, 8, 12

old_suicide <- filter (data, age > 45, intent == "Suicide")

oldsuicide <- group_by(data, age, sex, race,month) %>%
  count(sex, age, race,month, sort = TRUE) %>%
  filter ( age > 45)

oldsuicide

ggplot(oldsuicide)+
  geom_bar(mapping = aes(x= race, fill = sex), position = 'dodge')+
  facet_wrap(~month)


 # 5, 7, 8

accident <- filter(data, intent == "Accidental")

ggplot(accident)+
  geom_bar(mapping = aes(x = month, fill = race))

# 1, 11, 12