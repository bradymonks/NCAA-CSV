library(tidyverse)
library(Lahman)
library(blscrapeR)

colleges <- Lahman::CollegePlaying

colleges

schools <- Lahman::Schools

playerinfo <- Lahman::People

playerinfo

salaries <- Lahman::Salaries

schools
colleges
view(salaries)



colnames(colleges)
colnames(schools)
colnames(playerinfo)

view(new_data1) 

salaries1985 <- filter(salaries, yearID == "1985") %>%
                mutate(salary = salary * 2.42)
salaries1986 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1987 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1988 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1989 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1990 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1985 <- filter(salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)

inflation_adjust(1985, salaries1985)

bls_api(salaries, "salaries", startyear = 1985, endyear = 2016)


MO_Player_college_data <- colleges %>%
                left_join(schools, by = "schoolID") %>%
                left_join(playerinfo, by = "playerID") %>%
                filter(state == "MO") %>%
                left_join(salaries, by = "playerID") %>%
                select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary) 

colnames(MO_Player_college_data)

head(MO_Player_college_data)

view(MO_Player_college_data)

Single_player_college <- MO_Player_college_data %>%
                  group_by(nameFirst, nameLast, playerID, name_full, schoolID, city, state) %>%
                  summarise(
                              salary =  mean(salary)
                  )
view(Single_player_college)

