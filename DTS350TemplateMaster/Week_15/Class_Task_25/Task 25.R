library(tidyverse)
library(lubridate)
library(openxlsx)
library(gganimate)
library(readxl)

getwd()
setwd("C:/Users/brady/OneDrive/Documents/FA2020/DTS350")
getwd()
nba <- read_xlsx("NBA_Players_by_State.xlsx")

##Split Dates
nba_fix <- nba %>%
  filter(
    Date < 36000
  )

nba_fix$Date <- convertToDate(nba_fix$Date)

nba_fix <- nba_fix%>%
  select(Player, Date, City, State)

nba_fix

nba$Date <- mdy(nba$Date)

nba_correct <- nba %>%
  select(Player, Date, City, State)%>%
  na.omit()
  
nba_correct

## Put back together

nba_fix
nba_correct

nba <- rbind(nba_fix, nba_correct)

view(nba)

nba_animate <- nba %>%
      separate(Date, c("year","month","day"), sep = "-")

nba_animate$year <- as.integer(nba_animate$year)

nba_count <- count(nba_animate, year, State, City)

nba_count
    
p <- ggplot(data = nba_count, aes(State,n, fill = State))+
  geom_col()+
  theme(
    axis.text.x = element_blank()
  ) +
  transition_time(year)+
  labs(x = "State",
       y = "Count",
       title = "Year: {frame_time}")

p
