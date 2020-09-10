#Task 5 Practice
library(tidyverse)
money <- c("4,554,25", "$45", "8025.33cents", "288f45")

#as.numeric(money) = wrong
 parse_number(money)

 
my_string <- c("123", ".", "3a", "5.4")
parse_integer(my_string, na = ".")
problems(my_string)

challenge <-  read_csv(readr_example("challenge.csv"))

head(challenge)
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

download.file("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv",
              "colleges_ipeds_completers.csv")
ipeds <- read_csv("colleges_ipeds_completers.csv")
ipeds

ipeds_2011 <- ipeds %>%
    filter (year == 2011)

write_csv(ipeds_2011, "colleges_ipeds_completers_2011.csv")


ipeds_CA_14_15 <- ipeds %>%
    filter (year == c(2014,2015), fips == 6)
tail(ipeds_CA_14_15)

write_csv(ipeds_CA_14_15, "ipeds_completers_ca.csv")


install.packages("readxl")

library(readxl)

download.file("https://www.hud.gov/sites/dfiles/Housing/documents/FHA_SFSnapshot_Apr2019.xlsx",
              "sfsnap.xlsx", mode = "wb")

excel_sheets("sfsnap.xlsx")

purchases <- read_excel("sfsnap.xlsx", sheet = "Purchase Data April 2019")

purchases

p <- ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1") 

