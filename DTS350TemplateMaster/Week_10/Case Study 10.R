library(tidyverse)
library(lubridate)

sales <- read_csv("https://github.com/WJC-Data-Science/DTS350/raw/master/sales.csv")

sales$Time <- force_tz(sales$Time, tzone = "America/Denver", roll = FALSE)

sales$Time <- ceiling_date(sales$Time, unit = "hours", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))


sales <- sales %>%
  filter(Name != "Missing") %>%
  filter(Time > "2016-05-12 00:00:00")

salesdatetime <- separate(sales, Time, c("date","time"), sep = " ") 

salesdatetime

## weekly
salesweekly <- sales

salesweekly$Time <- ceiling_date(salesweekly$Time,unit = "weeks", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

salesweekly

salesweekly <- salesweekly %>%
  group_by(Name, Type, Time) %>%
  summarise(
      avg = mean(Amount)
  )

salesweekly <- salesweekly %>%
    separate(Time, c("Date", "Time"), sep = " ") %>%
    select(Name, Type, Date, avg)

salesweekly

salesweekly$Date <- as.Date(salesweekly$Date)

ggplot(data = salesweekly) +
  geom_point(mapping = aes(x = Date, y = avg, color = Name))+
  geom_line(mapping = aes(x = Date, y = avg, color = Name))+
  labs(y = "Average",
       title = "Weekly")

## Daily

salesdaily <- sales

salesdaily$Time <- ceiling_date(salesdaily$Time,unit = "days", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

salesdaily

salesdaily <- salesdaily%>%
  group_by(Name, Type, Time) %>%
  summarise(
    avg = mean(Amount)
  )

salesdaily <- salesdaily %>%
  separate(Time, c("Date", "Time"), sep = " ") %>%
  select(Name, Type, Date, avg)

salesdaily

salesdaily$Date <- as.Date(salesdaily$Date)

ggplot(data = salesdaily) +
  geom_point(mapping = aes(x = Date, y = avg, color = Name))+
  geom_line(mapping = aes(x = Date, y = avg, color = Name))+
  labs(y = "Average",
       title = "Daily")

## Monthly

salesmonthly <- sales

salesmonthly$Time <- ceiling_date(salesmonthly$Time,unit = "months", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

salesmonthly

salesmonthly <- salesmonthly %>%
  group_by(Name, Type, Time) %>%
  summarise(
    avg = mean(Amount)
  )

salesmonthly <- salesmonthly %>%
  separate(Time, c("Date", "Time"), sep = " ") %>%
  select(Name, Type, Date, avg)

salesmonthly

salesmonthly$Date <- as.Date(salesmonthly$Date)

ggplot(data = salesmonthly) +
  geom_point(mapping = aes(x = Date, y = avg, color = Name))+
  geom_line(mapping = aes(x = Date, y = avg, color = Name))+
  labs(y = "Average",
       title = "Monthly")


