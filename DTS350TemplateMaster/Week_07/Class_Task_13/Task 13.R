# Task 13

library(tidyverse)
library(haven)
library(readr)
library(readxl)
library(downloader)

dfrds  <- read_rds(url("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS"))

dfdta  <- read_dta("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta")

dfcvs  <- read_csv("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv")

sav <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav", sav, mode = "wb")
dfsav <- read_sav(sav)

xlsx <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx",xlsx, mode = "wb")
dfxlsx <- read_xlsx(xlsx)

all_equal(dfdta, dfsav, convert = TRUE)
all_equal(dfdta, dfxlsx, convert = TRUE)
all_equal(dfdta, dfrds, convert = TRUE)
all_equal(dfrds, dfsav, convert = TRUE)
all_equal(dfrds, dfxlsx, convert = TRUE)
all_equal(dfxlsx, dfsav, convert = TRUE)

view(dfrds)
view(dfdta)
view(dfxlsx)
view(dfsav)



dfdta1 <- dfdta %>%
  separate(contest_period, into = c("Month/Month","Year_end"), sep = -4)

view(dfdta1)

dfdta2 <- dfdta %>%
  separate(contest_period, into = c("Month/Month","Year_end"), sep = -4) %>%
  group_by(Year_end, variable) %>%
  summarise( mean = mean(value))

## Graphics

ggplot(data = dfdta1) + 
  geom_boxplot(mapping = aes(x = Year_end, y = value))+
  labs(x = "Year_end",
       y = "Value",
       color = "Variable",
       title = "Boxplot")

ggplot(data = dfdta2) +
  geom_line( mapping = aes(group = variable, x = Year_end , y = mean, color  = variable))+
  labs(x = "Year_end",
       y = "Value",
       color = "Variable",
       title = "Average Line")

ggplot(data = dfdta1) + 
  geom_jitter(mapping = aes(x = Year_end, y = value, color = variable))+
  labs(x = "Year_end",
       y = "Value",
       color = "Variable",
       title = "Jitter")

ggplot(data = dfdta2) +
  geom_line( mapping = aes(group = variable, x = Year_end , y = mean, color  = variable))+
  geom_jitter( data = dfdta1, mapping = aes(x = Year_end, y = value, color = variable))+
  labs(x = "Year_end",
       y = "Value",
       color = "Variable",
       title = "Jitter and Line")



ggplot(data = dfdta1) + 
  geom_boxplot(mapping = aes(x = Year_end, y = value))+
  geom_line( data = dfdta2, mapping = aes(group = variable, x = Year_end , y = mean, color  = variable))+
  geom_jitter(mapping = aes(x = Year_end, y = value, color = variable))+
  facet_wrap(~variable)+
  labs(x = "Year",
       y = "Value",
       color = "Variable",
       title = "All Three Faceted")

## Tidy the data

dfdta3 <- dfdta1 %>%
  separate(`Month/Month`, into = c("month_begin","month_end"), sep = "-")

view(dfdta3)

##Saving RDS

saveRDS(dfdta3,"dftdta3.rds")

## 6-month Returns

ggplot(data = dfdta3)+
  geom_point(mapping = aes(x = Year_end, y = value, color = variable))

## Final Table

dfdta4 <- dfdta3 %>%
            mutate(month_end = replace(month_end, month_end == "Dec.", "December")) %>%
            mutate(month_end = replace(month_end, month_end == "Febuary", "February")) %>%
            select(-c(month_begin)) %>%
            filter(variable == "DJIA") %>%
            pivot_wider(names_from = Year_end, values_from = value) %>%
            select(-c(variable)) %>%
            mutate(month_end = replace(month_end, month_end == "January", 1)) %>%
            mutate(month_end = replace(month_end, month_end == "February", 2)) %>%
            mutate(month_end = replace(month_end, month_end == "March", 3)) %>%
            mutate(month_end = replace(month_end, month_end == "April", 4)) %>%
            mutate(month_end = replace(month_end, month_end == "May", 5)) %>%
            mutate(month_end = replace(month_end, month_end == "June", 6)) %>%
            mutate(month_end = replace(month_end, month_end == "July", 7)) %>%
            mutate(month_end = replace(month_end, month_end == "August", 8)) %>%
            mutate(month_end = replace(month_end, month_end == "September", 9)) %>%
            mutate(month_end = replace(month_end, month_end == "October", 10)) %>%
            mutate(month_end = replace(month_end, month_end == "November", 11)) %>%
            mutate(month_end = replace(month_end, month_end == "December", 12)) 
  
dfdta4$month_end <- as.integer(dfdta4$month_end)

dfdta4 <- dfdta4[order(dfdta4$month_end),]

dfdta4 <- dfdta4 %>%
  mutate(month_end = replace(month_end, month_end == 1,"January")) %>%
  mutate(month_end = replace(month_end, month_end == 2,"February")) %>%
  mutate(month_end = replace(month_end, month_end == 3,"March")) %>%
  mutate(month_end = replace(month_end, month_end == 4,"April")) %>%
  mutate(month_end = replace(month_end, month_end == 5,"May")) %>%
  mutate(month_end = replace(month_end, month_end == 6,"June")) %>%
  mutate(month_end = replace(month_end, month_end == 7,"July")) %>%
  mutate(month_end = replace(month_end, month_end == 8,"August")) %>%
  mutate(month_end = replace(month_end, month_end == 9,"September")) %>%
  mutate(month_end = replace(month_end, month_end == 10,"October")) %>%
  mutate(month_end = replace(month_end, month_end == 11,"November")) %>%
  mutate(month_end = replace(month_end, month_end == 12,"December"))


head(dfdta4, 12)
