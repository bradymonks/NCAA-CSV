library(dygraphs)
library(tidyverse)
library(tidyquant)
library(lubridate)
library(timetk)

x1 <- "KR"

end <- today()-days(3)
start <- end - years(5)

x1_prices <- tq_get(x1, get = "stock.prices", from = start, to = end)

x1_prices

KR_monthlyreturns <- x1_prices %>%
            group_by(symbol) %>%
            tq_transmute( adjusted, mutate_fun = monthlyReturn) %>%
            pivot_wider(names_from = symbol, values_from = monthly.returns) %>%
            tk_xts(date_var = date)

KR_monthlyreturns

dygraph(KR_monthlyreturns, main = "Stock Prices - Kroger") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set2"))

kr_stockprices <- x1_prices %>%
        select(symbol, date, adjusted) %>%
        pivot_wider(names_from = symbol, values_from = adjusted) %>%
        tk_xts(date_var = date)

dygraph(kr_stockprices, main = "Stock Prices - Kroger") %>%
        dySeries(x1, strokeWidth = 2, fillGraph = TRUE) %>%
        dyHighlight(highlightCircleSize = 2,
                    highlightSeriesBackgroundAlpha = 0.2,
                    hideOnMouseOut = FALSE) %>%
        dyRangeSelector(dateWindow = c("2015-11-02", "2020-11-02"))

dygraph(kr_stockprices, main = "Kroger from $10,000") %>%
        dySeries(x1, fillGraph = TRUE) %>%
        dyRebase(value = 10000) %>%
        dyRangeSelector(dateWindow = c("2018-4-05", "2020-11-02"))%>%
        dyShading( from = "2020-3-12", to = "2020-3-19", color = "#CCEBD6") %>%
        dyShading( from = "2020-3-19", to = "2020-3-25", color = "#FFE6E6")%>%
        dyAnnotation( "2019-7-23", text = "A", tooltip = "Low", attachAtBottom = TRUE) %>%
        dyAnnotation( "2019-11-05", text = "B", tooltip = "Largest Single Day")
