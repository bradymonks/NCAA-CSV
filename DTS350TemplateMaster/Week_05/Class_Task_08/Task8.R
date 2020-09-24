## Task 8


library(tidyverse)

#https://github.com/fivethirtyeight/data/tree/master/nfl-suspensions

susdata <- read_csv("nfl-suspensions-data.csv")

susdata

susdata1 <- group_by(susdata, year, category) %>%
                count(category, year, sort = TRUE)
                     
susdata1

ggplot(data = susdata1)+
  geom_line(mapping = aes(x = year, y = n, color = category))


#https://data.world/dataquest/mlb-game-logs

gldata <- read_csv("game_logs.csv")

glimpse(gldata)

gldata1 <- group_by(gldata, winning_pitcher_name) %>%
  count(winning_pitcher_name, sort = TRUE) %>%
  filter(n < 30000, n > 230)

gldata1

ggplot(data = gldata1) +
    geom_col(mapping = aes(x = winning_pitcher_name, y = n, fill = winning_pitcher_name))

library(readxl)

hometown <- read_excel("NBA Players by State.xlsx")
hometown


