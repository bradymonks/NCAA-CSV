---
title: "Task 10"
author: "Brady Monks"
date: "9/30/2020"
output: 
  html_document:
      keep_md: TRUE
      code_folding: hide
---


```r
# Task 10

library(tidyverse)
library(nycflights13)
library(dplyr)

head(flights, 10)
```

```
## # A tibble: 10 x 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      544            545        -1     1004           1022
##  5  2013     1     1      554            600        -6      812            837
##  6  2013     1     1      554            558        -4      740            728
##  7  2013     1     1      555            600        -5      913            854
##  8  2013     1     1      557            600        -3      709            723
##  9  2013     1     1      557            600        -3      838            846
## 10  2013     1     1      558            600        -2      753            745
## # ... with 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
tail(flights, 10)
```

```
## # A tibble: 10 x 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     9    30     2240           2250       -10     2347              7
##  2  2013     9    30     2241           2246        -5     2345              1
##  3  2013     9    30     2307           2255        12     2359           2358
##  4  2013     9    30     2349           2359       -10      325            350
##  5  2013     9    30       NA           1842        NA       NA           2019
##  6  2013     9    30       NA           1455        NA       NA           1634
##  7  2013     9    30       NA           2200        NA       NA           2312
##  8  2013     9    30       NA           1210        NA       NA           1330
##  9  2013     9    30       NA           1159        NA       NA           1344
## 10  2013     9    30       NA            840        NA       NA           1020
## # ... with 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
flights
```

```
## # A tibble: 336,776 x 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      544            545        -1     1004           1022
##  5  2013     1     1      554            600        -6      812            837
##  6  2013     1     1      554            558        -4      740            728
##  7  2013     1     1      555            600        -5      913            854
##  8  2013     1     1      557            600        -3      709            723
##  9  2013     1     1      557            600        -3      838            846
## 10  2013     1     1      558            600        -2      753            745
## # ... with 336,766 more rows, and 11 more variables: arr_delay <dbl>,
## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# There are 336,776 rows

summary(flights)
```

```
##       year          month             day           dep_time    sched_dep_time
##  Min.   :2013   Min.   : 1.000   Min.   : 1.00   Min.   :   1   Min.   : 106  
##  1st Qu.:2013   1st Qu.: 4.000   1st Qu.: 8.00   1st Qu.: 907   1st Qu.: 906  
##  Median :2013   Median : 7.000   Median :16.00   Median :1401   Median :1359  
##  Mean   :2013   Mean   : 6.549   Mean   :15.71   Mean   :1349   Mean   :1344  
##  3rd Qu.:2013   3rd Qu.:10.000   3rd Qu.:23.00   3rd Qu.:1744   3rd Qu.:1729  
##  Max.   :2013   Max.   :12.000   Max.   :31.00   Max.   :2400   Max.   :2359  
##                                                  NA's   :8255                 
##    dep_delay          arr_time    sched_arr_time   arr_delay       
##  Min.   : -43.00   Min.   :   1   Min.   :   1   Min.   : -86.000  
##  1st Qu.:  -5.00   1st Qu.:1104   1st Qu.:1124   1st Qu.: -17.000  
##  Median :  -2.00   Median :1535   Median :1556   Median :  -5.000  
##  Mean   :  12.64   Mean   :1502   Mean   :1536   Mean   :   6.895  
##  3rd Qu.:  11.00   3rd Qu.:1940   3rd Qu.:1945   3rd Qu.:  14.000  
##  Max.   :1301.00   Max.   :2400   Max.   :2359   Max.   :1272.000  
##  NA's   :8255      NA's   :8713                  NA's   :9430      
##    carrier              flight       tailnum             origin         
##  Length:336776      Min.   :   1   Length:336776      Length:336776     
##  Class :character   1st Qu.: 553   Class :character   Class :character  
##  Mode  :character   Median :1496   Mode  :character   Mode  :character  
##                     Mean   :1972                                        
##                     3rd Qu.:3465                                        
##                     Max.   :8500                                        
##                                                                         
##      dest              air_time        distance         hour      
##  Length:336776      Min.   : 20.0   Min.   :  17   Min.   : 1.00  
##  Class :character   1st Qu.: 82.0   1st Qu.: 502   1st Qu.: 9.00  
##  Mode  :character   Median :129.0   Median : 872   Median :13.00  
##                     Mean   :150.7   Mean   :1040   Mean   :13.18  
##                     3rd Qu.:192.0   3rd Qu.:1389   3rd Qu.:17.00  
##                     Max.   :695.0   Max.   :4983   Max.   :23.00  
##                     NA's   :9430                                  
##      minute        time_hour                  
##  Min.   : 0.00   Min.   :2013-01-01 05:00:00  
##  1st Qu.: 8.00   1st Qu.:2013-04-04 13:00:00  
##  Median :29.00   Median :2013-07-03 10:00:00  
##  Mean   :26.23   Mean   :2013-07-03 05:22:54  
##  3rd Qu.:44.00   3rd Qu.:2013-10-01 07:00:00  
##  Max.   :59.00   Max.   :2013-12-31 23:00:00  
## 
```

```r
# There are NAs in dep_time, dep_delay,arr_time, arr_delay,tailnum,air_time

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay))
fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))

fl_bp + geom_boxplot()
```

![](Task-10_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
fl_sc + geom_point()
```

![](Task-10_files/figure-html/unnamed-chunk-1-2.png)<!-- -->

```r
# Added Labels


fl_bp + geom_boxplot() + labs( x = "Carrier Abbreviation",
                               y = "Departure Delay",
                               title = "Departure Delay Boxplots by Carrier")
```

![](Task-10_files/figure-html/unnamed-chunk-1-3.png)<!-- -->

```r
fl_sc + geom_point() + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")
```

![](Task-10_files/figure-html/unnamed-chunk-1-4.png)<!-- -->

```r
# Zoom in 

fl_bp + 
  geom_boxplot() + 
  labs( x = "Carrier Abbreviation",
        y = "Departure Delay (minutes)",
        title = "Departure Delay Boxplots by Carrier")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))
```

![](Task-10_files/figure-html/unnamed-chunk-1-5.png)<!-- -->

```r
fl_sc + geom_point() + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")+
                       coord_cartesian(ylim = c(50, 100))+
                       scale_y_continuous(breaks = c(60, 75, 90))+
                       scale_x_continuous(breaks = c(800, 815, 830, 845, 860))
```

![](Task-10_files/figure-html/unnamed-chunk-1-6.png)<!-- -->

```r
# Colored

fl_sc + geom_point(aes( color = origin)) + labs( x= "Departure Time",
                             y= "Departure Delay (minutes)",
                             title = "Departure Delay For Each Departure Time")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  scale_x_continuous(breaks = c(800, 815, 830, 845, 860))+
  scale_color_brewer(palette = "Set1")
```

![](Task-10_files/figure-html/unnamed-chunk-1-7.png)<!-- -->

```r
# Final

plot1 <- fl_sc + geom_point(aes( color = origin)) + labs( x= "Departure Time",
                                                 y= "Departure Delay (minutes)",
                                                 title = "Departure Delay For Each Departure Time")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  scale_x_continuous(breaks = c(800, 815, 830, 845, 860))+
  scale_color_brewer(palette = "Set1")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 35, hjust=1))
plot1
```

![](Task-10_files/figure-html/unnamed-chunk-1-8.png)<!-- -->

```r
ggsave("plot1.png", plot1)

plot2 <- fl_bp + 
  geom_boxplot() + 
  labs( x = "Carrier Abbreviation",
        y = "Departure Delay (minutes)",
        title = "Departure Delay Boxplots by Carrier")+
  coord_cartesian(ylim = c(50, 100))+
  scale_y_continuous(breaks = c(60, 75, 90))+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 35, hjust=1))

plot2
```

![](Task-10_files/figure-html/unnamed-chunk-1-9.png)<!-- -->

```r
ggsave("plot2.png", plot2)


# Final

library(viridis)
library(ggrepel)

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

rest <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) != 1) 


plot3_1 <- ggplot(best_in_class, aes(displ, hwy)) +
  geom_point(aes(colour = class), data = rest, size = 4)+
  geom_point(aes(colour = class, fill = class), shape=21, stroke = 2.5, size = 3) + 
  scale_fill_manual(values=c("white", "white","white","white","white","white","white")) + 
  geom_label_repel(aes(label = model, color = class), label.size = NA, fill = NA,)  +
  theme_bw()+
  theme(
    #legend.position = "none",
    panel.grid.minor = element_blank())+
  labs( x = "Engine displacement",
        y = "Miles per gallon (highway)",
        color = "Vehicle Type"
        )+
  coord_cartesian(ylim = c(15, 45), xlim = c(1,7))+
  scale_y_continuous(breaks = c(20, 30, 40))+
  scale_x_continuous(breaks = c(2,3,4,5,6,7))+
  scale_colour_viridis_d() 

plot3_1
```

![](Task-10_files/figure-html/unnamed-chunk-1-10.png)<!-- -->

```r
#OR

plot3 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class), size = 4) +
  geom_point(aes(colour = class),size = 3, shape = 21, fill = "white", stroke = 2.5, data = best_in_class) +
  geom_label_repel(aes(label = model, colour = class), label.size = NA, fill = NA,data = best_in_class)+
  theme_bw()+
  theme(panel.grid.minor.x = element_blank(), panel.grid.minor.y = element_blank())+
  scale_colour_viridis_d()+
  #coord_cartesian(ylim = c(15, 45), xlim = c(1,7))+
  scale_y_continuous(breaks = c(20, 30, 40))+
  scale_x_continuous(breaks = c(2,3,4,5,6,7))+
  labs( x = "Engine displacement",
        y = "Miles per gallon (highway)",
        color = "Vehicle Type"
  )
plot3
```

![](Task-10_files/figure-html/unnamed-chunk-1-11.png)<!-- -->

```r
ggsave("plot3.png",plot3)
```

