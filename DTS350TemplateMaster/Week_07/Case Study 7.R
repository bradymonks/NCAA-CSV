# Case Study 7

library(tidyverse)
library(haven)
library(readr)
library(downloader)
library(readxl)
library(foreign)

Tubheight <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Height.xlsx",
         Tubheight, mode = "wb")
Tubheight <- read_xlsx(Tubheight, skip = 2, col_names = TRUE)
Tubheight

germanheight <- read_dta("https://github.com/WJC-Data-Science/DTS350/raw/master/germanconscr.dta")
germanheight

germanprison <- read_dta("https://github.com/WJC-Data-Science/DTS350/raw/master/germanprison.dta")
germanprison


heightSE <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Heights_south-east/B6090.DBF", heightSE, mode = "wb")
heightSE <- read.dbf(heightSE)


heightscsv <- read_csv("https://raw.githubusercontent.com/hadley/r4ds/master/data/heights.csv")
heightscsv

heightsav <- tempfile()
download("http://www.ssc.wisc.edu/nsfh/wave3/NSFH3%20Apr%202005%20release/main05022005.sav", heightsav, mode = "wb")
heightsav <- read_sav(heightsav)
heightsav

householdsav <- tempfile()
download("http://www.ssc.wisc.edu/nsfh/wave3/NSFH3%20Apr%202005%20release/nsfh3mainroster1-04042005.sav", householdsav, mode = "wb")
householdsav <- read_sav(householdsav)
householdsav


view(Tubheight)


Tubheighty <- Tubheight %>%
  pivot_longer(c(`1800`:`2011`), names_to = "year_decade", values_to = "height.cm") %>%
  na.omit() %>%
  separate(year_decade, into = c("century","decade"), sep = -2, remove = FALSE)%>%
  separate(decade, into = c("decade", "year"), sep = -1, remove = FALSE) %>%
  mutate(height.in = height.cm/2.54) %>%
  rename(country = "Continent, Region, Country") %>%
  select(Code, country, century, decade, year, height.cm, year_decade, height.in)

  
Tubheighty <- Tubheighty[order(Tubheighty$year_decade),]

view(Tubheighty)


clean_wisc_height <- heightsav %>%
          select(DOBY, RT216F, RT216I)%>%
          mutate(height.in = (RT216F*12)+ RT216I) %>%
          mutate(birth_year = DOBY + 1900) %>%
          select( -DOBY, -RT216F, -RT216I) %>%
          mutate(height.cm = height.in*2.54) %>%
          add_column(study = "Wisconsin") %>%
          select(birth_year,height.cm,height.in,study)
  
  
clean_wisc_height


clean_BLS_height <- heightscsv %>%
              select(height) %>%
              add_column(birth_year = 1950) %>%
              add_column(study = "BLS") %>%
              mutate(height.in = height) %>%
              select(-height) %>%
              mutate(height.cm = height.in*2.54)%>%
  select(birth_year,height.cm,height.in,study)

clean_BLS_height              

clean_SE_height <- heightSE %>%
          select(SJ, CMETER) %>%
          rename(birth_year = "SJ") %>%
          rename(height.cm = "CMETER") %>%
          mutate(height.in = height.cm/2.54)%>%
          add_column(study = "Southeast")%>%
  select(birth_year,height.cm,height.in,study)
  
clean_SE_height


clean_German_height <- germanheight %>%
        select(bdec, height) %>%
        rename(birth_year = "bdec") %>%
        rename(height.cm = "height") %>%
        mutate(height.in = height.cm/2.54) %>%
        add_column(study = "German Males in Bavaria")%>%
  select(birth_year,height.cm,height.in,study)

clean_German_height


clean_Prison_height <- germanprison %>%
  select(bdec, height) %>%
  rename(birth_year = "bdec") %>%
  rename(height.cm = "height") %>%
  mutate(height.in = height.cm/2.54) %>%
  add_column(study = "German Prison")%>%
  select(birth_year,height.cm,height.in,study)

clean_Prison_height

#clean_Wisc_household <- householdsav %>%
#  select(doby, RT216F, RT216I)%>%
#  mutate(height.in = (RT216F*12)+ RT216I) %>%
#  mutate(birth_year = doby + 1900) %>%
#  select( -doby, -RT216F, -RT216I) %>%
#  mutate(height.cm = height.in*2.54) %>%
#  add_column(study = "Wisconsin")
 

new_data <- bind_rows(clean_BLS_height,clean_German_height,clean_Prison_height,clean_SE_height,clean_wisc_height)   
new_data    


ggplot( data = new_data) +
  geom_point(mapping = aes(x = birth_year, y = height.cm, color = study))
