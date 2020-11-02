library(tidyverse)
library(lubridate)
library(riem)

wash <- read_csv("https://github.com/WJC-Data-Science/DTS350/raw/master/carwash.csv")

wash$time <- force_tz(wash$time, tzone = "UTC", roll = FALSE)

wash$time

wash$time <- with_tz(wash$time, "America/Denver")

wash$time

wash$time <- ceiling_date(wash$time, unit = "hours", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

wash$time

wash <- wash%>%
    group_by(time)%>%
    summarise(
        value = sum(amount)
    )%>%
    add_column(type = "Sales")

wash

washriem <- riem_measures(station = "RXE",  date_start  = "2016-5-13" ,  date_end  = "2016-7-18" )


washriem$valid <- with_tz(washriem$valid, "America/Denver")

washriem$valid <- ceiling_date(washriem$valid, unit = "hours", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

washriem <- washriem %>%
            select(valid, tmpf) %>%
            rename( time = "valid") %>%
            rename( value = "tmpf")%>%
            na.omit() %>%
            add_column(type = "Temp")

washriem

newdf <-washriem %>%
            full_join(wash)

newdf<-separate(newdf, time, c("date", "time"), sep = " ")
newdf<-separate(newdf, time, c("hour","minute","second"),sep = ":")%>%
            select(hour,value,type)

newdf$hour <- as.integer(newdf$hour) 
newdf$value <- as.integer(newdf$value)

sumdf <- newdf %>%
    group_by(hour, type) %>%
    summarise(
        avg = mean(value)
    ) %>%
    filter( hour > 8 & hour <19)

sumdf

ggplot(data = sumdf)+
    geom_point(mapping = aes(x = hour, y = avg, color = type))+
    geom_line(mapping = aes(x = hour, y = avg, color = type))+
    labs( x = "Hour",
          y = "Average",
          color = "Type",
          title = "Comparison of Sales and Temp throughout Day")

