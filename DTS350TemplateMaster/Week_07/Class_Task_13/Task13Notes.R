# Task 13 Class Notes

library(tidyverse)
library(haven)
library(readr)
library(readxl)
library(downloader)

df1 <- read_rds(url(" url "))
df2 <- read_dta(" url ")


all_equal(df1, df2)

df1problem <- df1 %>%
  filter(row_number() == 170)

df2problem <- df2 %>%
  filter(row_number() == 170)

bind_rows( df1problem,df2problem)

#separating

new_df2 <- df2 %>%
  separate(Release.Date, into = c("Month/Day","Year"), sep = -4)

#fixing values

fix_df2 <- df2 %>%
    mutate(new_col_name = replace(col_name, col_name == value/character, new value/character))