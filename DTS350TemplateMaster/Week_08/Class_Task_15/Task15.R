library(tidyverse)
library(Lahman)
library(blscrapeR)
library(directlabels)

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
salaries1986 <- filter(salaries, yearID == "1986") %>%
  mutate(salary = salary * 2.37)
salaries1987 <- filter(salaries, yearID == "1987") %>%
  mutate(salary = salary * 2.29)
salaries1988 <- filter(salaries, yearID == "1988") %>%
  mutate(salary = salary * 2.2)
salaries1989 <- filter(salaries, yearID == "1989") %>%
  mutate(salary = salary * 2.1)
salaries1990 <- filter(salaries, yearID == "1990") %>%
  mutate(salary = salary * 1.99)
salaries1991 <- filter(salaries, yearID == "1991") %>%
  mutate(salary = salary * 1.91)
salaries1992 <- filter(salaries, yearID == "1992") %>%
  mutate(salary = salary * 1.86)
salaries1993 <- filter(salaries, yearID == "1993") %>%
  mutate(salary = salary * 1.8)
salaries1994 <- filter(salaries, yearID == "1994") %>%
  mutate(salary = salary * 1.76)
salaries1995 <- filter(salaries, yearID == "1995") %>%
  mutate(salary = salary * 1.71)
salaries1996 <- filter(salaries, yearID == "1996") %>%
  mutate(salary = salary * 1.66)
salaries1997 <- filter(salaries, yearID == "1997") %>%
  mutate(salary = salary * 1.62)
salaries1998 <- filter(salaries, yearID == "1998") %>%
  mutate(salary = salary * 1.6)
salaries1999 <- filter(salaries, yearID == "1999") %>%
  mutate(salary = salary * 1.56)
salaries2000 <- filter(salaries, yearID == "2000") %>%
  mutate(salary = salary * 1.51)
salaries2001 <- filter(salaries, yearID == "2001") %>%
  mutate(salary = salary * 1.47)
salaries2002 <- filter(salaries, yearID == "2002") %>%
  mutate(salary = salary * 1.45)
salaries2003 <- filter(salaries, yearID == "2003") %>%
  mutate(salary = salary * 1.41)
salaries2004 <- filter(salaries, yearID == "2004") %>%
  mutate(salary = salary * 1.38)
salaries2005 <- filter(salaries, yearID == "2005") %>%
  mutate(salary = salary * 1.33)
salaries2006 <- filter(salaries, yearID == "2006") %>%
  mutate(salary = salary * 1.29)
salaries2007 <- filter(salaries, yearID == "2007") %>%
  mutate(salary = salary * 1.26)
salaries2008 <- filter(salaries, yearID == "2008") %>%
  mutate(salary = salary * 1.21)
salaries2009 <- filter(salaries, yearID == "2009") %>%
  mutate(salary = salary * 1.21)
salaries2010 <- filter(salaries, yearID == "2010") %>%
  mutate(salary = salary * 1.19)
salaries2011 <- filter(salaries, yearID == "2011") %>%
  mutate(salary = salary * 1.16)
salaries2012 <- filter(salaries, yearID == "2012") %>%
  mutate(salary = salary * 1.13)
salaries2013 <- filter(salaries, yearID == "2013") %>%
  mutate(salary = salary * 1.12)
salaries2014 <- filter(salaries, yearID == "2014") %>%
  mutate(salary = salary * 1.1)
salaries2015 <- filter(salaries, yearID == "2015") %>%
  mutate(salary = salary * 1.1)
salaries2016 <- filter(salaries, yearID == "2016") %>%
  mutate(salary = salary * 1.08)

salary_data <- bind_rows(salaries1985,
                         salaries1986,
                         salaries1987,
                         salaries1988,
                         salaries1989,
                         salaries1990,
                         salaries1991,
                         salaries1992,
                         salaries1993,
                         salaries1994,
                         salaries1995,
                         salaries1996,
                         salaries1997,
                         salaries1998,
                         salaries1999,
                         salaries2000,
                         salaries2001,
                         salaries2002,
                         salaries2003,
                         salaries2004,
                         salaries2005,
                         salaries2006,
                         salaries2007,
                         salaries2008,
                         salaries2009,
                         salaries2010,
                         salaries2011,
                         salaries2012,
                         salaries2013,
                         salaries2014,
                         salaries2015,
                         salaries2016)

salary_data


MO_Player_college_data <- colleges %>%
                left_join(schools, by = "schoolID") %>%
                left_join(playerinfo, by = "playerID") %>%
                filter(state == "MO") %>%
                left_join(salary_data, by = "playerID") %>%
                select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary, yearID.y)%>%
                na.omit()


colnames(MO_Player_college_data)

head(MO_Player_college_data)

view(MO_Player_college_data)
Single_player_college <- MO_Player_college_data %>%
                  group_by(nameFirst, nameLast, playerID, name_full, schoolID, city, state) %>%
                  summarise(
                              salary =  mean(salary)
                  )
view(Single_player_college)

Salary_by_college <- Single_player_college %>%
                        group_by(name_full, schoolID) %>%
                        summarise(
                              salary = mean(salary)/1000000
                        )

Salary_by_college <- Salary_by_college[order(Salary_by_college$salary),]


Salary_by_college

ggplot(data = Salary_by_college) +
    geom_col(mapping = aes(x = reorder(name_full,salary), y = salary, fill = name_full))+
    theme_bw() +
    labs(x = "College",
         y = "Average Yearly Salary * 1 Mil",
         title = "Average Yearly Salary by College")+
    scale_y_continuous(label = function(x){return(paste("$",x))})+
    theme(
      legend.position = "none"
    )+
    coord_flip()


ggplot(data = Single_player_college)+
    geom_bar(mapping = aes(x = name_full, fill = name_full), position = 'dodge')+
    labs( x = "College",
          y = "Count",
          title = "# of Players from each College",
          fill = "College")+
    coord_flip()+
    theme(
        legend.position = "none"
    )
    

MO_Player_college_data
 
All_Player_college_data <- colleges %>%
  left_join(schools, by = "schoolID") %>%
  left_join(playerinfo, by = "playerID") %>%
  left_join(salary_data, by = "playerID") %>%
  select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary, yearID.y)%>%
  na.omit()

salary_by_year <- MO_Player_college_data %>%
  group_by(name_full, schoolID, yearID.y) %>%
  summarise(
    salary = mean(salary)/1000000
  )

salary_by_year

ggplot(data = salary_by_year)+
    geom_point(mapping = aes(x = yearID.y, y = salary, color = name_full)) +
    geom_line(mapping = aes(x = yearID.y, y = salary, color = name_full))+
    labs(x = "College",
         y = "Salary / 1 mil",
         title = "Average Salary for Each Year by College")+
    theme_bw()+
  scale_colour_manual(values = c("University of Missouri Columbia" = "black",
                                 "Crowder College" = "gold",
                                 "Culver-Stockton College" = "gold",
                                 "East Central College" = "gold",
                                 "Jefferson College" = "gold",
                                 "Longview Community College" = "gold",
                                 "Maple Woods Community College" = "gold",
                                 "Missouri State University" = "gold",
                                 "Missouri Valley College" = "gold",
                                 "Northwest Missouri State University" = "gold",
                                 "Southeast Missouri State Universtiy" = "gold",
                                 "St. Louis Community College, Forest Park Campus" = "gold",
                                 "St. Louis Community College, Meramec Campus" = "gold",
                                 "Three Rivers Community College" = "gold",
                                 "Truman State University" = "gold",
                                 "University of Central Missouri" = "gold"
                                 ))+
  
  theme(
    axis.text.x = element_blank(),
    legend.position = "none")
    
    
    