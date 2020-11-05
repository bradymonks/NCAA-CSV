library(tidyquant)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)

stocks<-tq_get(c("NFLX","AAPL", "AMZN", "GOOG","TSLA","FB"), get = "stock.prices", from = "2019-10-1")

nike <- tq_get("NKE", get = "stock.prices")

nike

view(stocks)

library(directlabels)
library(ggrepel)

ggplot(stocks)+
  geom_line(mapping = aes(x = date, y = close, color = symbol), size = 2)+
  scale_color_manual(values = c("#FFCC00","#FF3300","yellow","#0066CC","purple","green"))+
  labs(x = "Date",
       y = "Adjusted Stock Price",
       color = "Company",
       title = "Adjusted Stock Price over Time")
