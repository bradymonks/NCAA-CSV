library(tidyverse)
library(lubridate)
library(riem)

wash <- read_csv("https://github.com/WJC-Data-Science/DTS350/raw/master/carwash.csv")


view(wash)


wash$time <- force_tz(wash$time, tzone = "UTC", roll = FALSE)

wash$time

wash$time <- with_tz(wash$time, "America/Denver")

wash$time

wash$time <- ceiling_date(wash$time, unit = "hours", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

wash$time

view(wash)

wash <- wash%>%
    group_by(time)%>%
    summarise(
        value = sum(amount)
    )%>%
    add_column(type = "sales")

wash

washriem <- riem_measures(station = "RXE",  date_start  = "2016-5-13" ,  date_end  = "2016-7-18" )

view(washriem)

washriem$valid <- with_tz(washriem$valid, "America/Denver")

washriem$valid <- ceiling_date(washriem$valid, unit = "hours", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7 ))

washriem <- washriem %>%
            select(valid, tmpf) %>%
            rename( time = "valid") %>%
            rename( value = "tmpf")%>%
            na.omit() %>%
            add_column(type = "tmpf")

washriem

head(wash)
head(washriem)

newdf<- merge(wash,washriem)

newdf <-washriem %>%
            full_join(wash)

view(newdf)


