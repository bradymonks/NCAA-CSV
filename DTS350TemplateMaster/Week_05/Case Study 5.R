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

data$month <- setNames(1:12, c("JAN", "FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"))
data$month <- c(Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6, Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12)


data$intent <- fct_explicit_na(data$intent)
data$month <- as.character(data$month)


data2012 <- filter(data, year == '2012')
view(data2012)

ggplot(data = data1)+
  geom_point(mapping = aes(x = intent, y = race, size = n, color = race))+
  facet_grid(vars(sex), vars(month))+
  labs(
    x = "Month",
    y = "Race",
    size = "Count",
    color = "Race"
  )


data1 <- group_by(data, year, month, intent, race, sex) %>%
  count(year, month, intent, race, sex, sort = TRUE)

data1

ggplot(data = data1)+
    geom_point(mapping = aes(x = month, y = n, color = race))+
    facet_wrap(~intent)





datas <- filter( data, intent == "Suicide", sex == "M")

ggplot(data = datas)+
  geom_line(mapping = aes(x = month,y = race ))


ggplot(datas, aes(x = race, y = month))+
    geom_violin()+
    facet_wrap(~month)





