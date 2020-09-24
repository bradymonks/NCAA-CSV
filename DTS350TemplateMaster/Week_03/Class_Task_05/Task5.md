---
title: 'Task5: Data Import and ggplot2'
author: "Brady Monks"
date: "9/10/2020"
output: 
  html_document:
    keep_md: TRUE
    code_folding: hide
---


## What I learned

I learned a lot about how to customize graphs to your own liking that will create the most self-explanatory graphs. One thing I think will be difficult is knowing which features to use at the right time. 



## Importing data




```r
library(tidyverse)
nba<-read_csv("historical_RAPTOR_by_player.csv")
nba
```

```
## # A tibble: 17,483 x 15
##    player_name player_id season  poss    mp raptor_offense raptor_defense
##    <chr>       <chr>      <dbl> <dbl> <dbl>          <dbl>          <dbl>
##  1 Alaa Abdel~ abdelal01   1991   640   303          -3.94         -0.510
##  2 Alaa Abdel~ abdelal01   1992  1998   959          -2.55         -0.198
##  3 Alaa Abdel~ abdelal01   1993  2754  1379          -2.37         -2.07 
##  4 Alaa Abdel~ abdelal01   1994   320   159          -6.14         -2.75 
##  5 Alaa Abdel~ abdelal01   1995   984   506          -3.85         -1.27 
##  6 Kareem Abd~ abdulka01   1977  7674  3483           4.54          3.10 
##  7 Kareem Abd~ abdulka01   1978  5343  2399           3.45          3.42 
##  8 Kareem Abd~ abdulka01   1979  7826  3524           2.95          2.53 
##  9 Kareem Abd~ abdulka01   1980  8226  3761           3.12          2.43 
## 10 Kareem Abd~ abdulka01   1981  6716  3110           2.37          1.80 
## # ... with 17,473 more rows, and 8 more variables: raptor_total <dbl>,
## #   war_total <dbl>, war_reg_season <dbl>, war_playoffs <dbl>,
## #   predator_offense <dbl>, predator_defense <dbl>, predator_total <dbl>,
## #   pace_impact <dbl>
```

## Manipulations


```r
nbatop <- filter(nba, raptor_total > 20)
nbatop
```

```
## # A tibble: 15 x 15
##    player_name player_id season  poss    mp raptor_offense raptor_defense
##    <chr>       <chr>      <dbl> <dbl> <dbl>          <dbl>          <dbl>
##  1 Darrell Ar~ armstda01   1995    16     8          21.4           3.28 
##  2 Anthony Br~ brownan02   2018    11     4          18.7           2.43 
##  3 Jackie But~ butleja01   2005    10     5          19.1           4.31 
##  4 Tyler Davis davisty01   2019     2     1         -40.8          61.1  
##  5 Chad Galla~ gallach01   1994     6     3          32.2          -3.28 
##  6 Steven Hill hillst01    2009     4     2          33.1          -0.398
##  7 Cedric Lew~ lewisce01   1996     8     4          22.3          15.5  
##  8 DeAndre Li~ liggide01   2014     3     1          53.2         -28.5  
##  9 Ian Lockha~ lockhia01   1991     4     2          38.2          -3.41 
## 10 Tahjere Mc~ mccalta01   2019    20     8          -2.36         25.3  
## 11 Cozell McQ~ mcqueco01   1987    15     7          21.5           6.03 
## 12 Naz Mitrou~ mitrona01   2018     3     1          53.0          19.6  
## 13 Tyler Ulis  ulisty01    2019     2     1         -16.8          62.5  
## 14 Tyson Whee~ wheelty01   1999     6     3          35.6          -5.39 
## 15 Alan Willi~ willial03   2019    60    26           8.39         12.1  
## # ... with 8 more variables: raptor_total <dbl>, war_total <dbl>,
## #   war_reg_season <dbl>, war_playoffs <dbl>, predator_offense <dbl>,
## #   predator_defense <dbl>, predator_total <dbl>, pace_impact <dbl>
```

## Plot


```r
ggplot(nbatop)+
    geom_point(mapping = aes(x = raptor_offense, y = raptor_defense, color = player_name))
```

![](Task5_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

## Export


```r
write_csv(nbatop, "nbatop.csv")
```
