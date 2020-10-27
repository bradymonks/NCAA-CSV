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

topsalaries<- MO_Player_college_data[order(-MO_Player_college_data$salary),]
head(topsalaries, 25)

topsalaries


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
      legend.position = "none",
      panel.grid.major.y = element_blank()
    )+
    coord_flip()+
    scale_fill_manual(values = c("gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "gold",
                                 "black"))
    

MO_Player_college_data

ggplot(data = Single_player_college)+
    geom_bar(mapping = aes(x = name_full, fill = name_full), position = 'dodge')+
    labs( x = "College",
          y = "Count",
          title = "# of Players from each College",
          fill = "College")+
    coord_flip()+
    theme_bw()+
    theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
    )+
  scale_fill_manual(values = c("gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "gold",
                               "black"))
    
    

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
    



    
    view(MO_Player_college_data)
    
    
    MO_Player_college_data_all <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      filter(state == "MO") %>%
      group_by( name_full, birthYear) %>%
      summarise(
        yob = mean(birthYear)) 
    
    
    college_count <- MO_Player_college_data_all %>%
          count(name_full, sort = TRUE)
    
   
   
    ggplot(data = college_count) +
      geom_col(mapping = aes(x = reorder(name_full,n), y = n, fill = name_full))+
      theme_bw() +
      labs(x = "College",
           y = "# of Players",
           title = "Total Professional Players from each College Since 1900")+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )+
      coord_flip()+
      scale_fill_manual(values = c("black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "black",
                                   "gold",
                                   "black",
                                   "black",
                                   "red"))
    
    
    
    
    
    
#### Texas
    
    TX_Player_college_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      filter(state == "TX") %>%
      left_join(salary_data, by = "playerID") %>%
      select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary, yearID.y)%>%
      na.omit()

    
    
    TX_Single_player_college <- TX_Player_college_data %>%
      group_by(nameFirst, nameLast, playerID, name_full, schoolID, city, state) %>%
      summarise(
        salary =  mean(salary)
      )

    TX_salary_by_college <- TX_Single_player_college %>%
      group_by(name_full, schoolID) %>%
      summarise(
        salary = mean(salary)/1000000
      )
    
    TX_salary_by_college <- TX_salary_by_college[order(TX_salary_by_college$salary),]
    
    
    ggplot(data = TX_salary_by_college) +
      geom_col(mapping = aes(x = reorder(name_full,salary), y = salary, fill = "black"))+
      theme_bw() +
      labs(x = "College",
           y = "Average Yearly Salary * 1 Mil",
           title = "Average Yearly Salary by College")+
      scale_y_continuous(label = function(x){return(paste("$",x))})+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )+
      coord_flip()
    
    top_TX_salary <- TX_Player_college_data %>%
                filter(name_full == "Vernon College"|name_full=="Texarkana College"|name_full=="Texas A&M University-Kingsville")
    
    TX_count_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      filter(state == "TX", yearID >1984) %>%
      group_by( name_full, birthYear) %>%
      summarise(
        yob = mean(birthYear)) 
    
    TX_college_count_1985 <- TX_count_data %>%
      count(name_full, sort = TRUE)
    view(TX_college_count_1985)
    
    ggplot(data = TX_Single_player_college)+
      geom_bar(mapping = aes(x = name_full, fill = name_full), position = 'dodge')+
      labs( x = "College",
            y = "Count",
            title = "# of Players from each College",
            fill = "College")+
      coord_flip()+
      theme_bw()+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )
    
    All_Player_college_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      left_join(salary_data, by = "playerID") %>%
      select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary, yearID.y)%>%
      na.omit()
    
    TX_salary_by_year <- TX_Player_college_data %>%
      group_by(name_full, schoolID, yearID.y) %>%
      summarise(
        salary = mean(salary)/1000000
      )
    
  
    
    
    
    
    
    TX_Player_college_data_all <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      filter(state == "TX") %>%
      group_by( name_full, birthYear) %>%
      summarise(
        yob = mean(birthYear)) 
    
    
    TX_college_count <- TX_Player_college_data_all %>%
      count(name_full, sort = TRUE)
    
    
    
    ggplot(data = TX_college_count) +
      geom_col(mapping = aes(x = reorder(name_full,n), y = n, fill = name_full))+
      theme_bw() +
      labs(x = "College",
           y = "# of Players",
           title = "Total Professional Players from each College Since 1900")+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )+
      coord_flip()
    
### All U.S.
    
    
    US_Player_college_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      left_join(salary_data, by = "playerID") %>%
      select(nameFirst, nameLast, playerID, name_full, schoolID, city, state, salary, yearID.y)%>%
      na.omit()
    
    
    
    US_Single_player_college <- US_Player_college_data %>%
      group_by(nameFirst, nameLast, playerID, name_full, schoolID, city, state) %>%
      summarise(
        salary =  mean(salary)
      )
    
    
    US_salary_by_college <- US_Single_player_college %>%
      group_by(name_full, schoolID,city,state) %>%
      summarise(
        salary = mean(salary)/1000000
      )
    
    US_salary_by_college <- US_salary_by_college[order(-US_salary_by_college$salary),]
    
    view(US_salary_by_college)
    
    Top_US_Salaries <- head(US_salary_by_college,20)
    
    
    ggplot(data = Top_US_Salaries) +
      geom_col(mapping = aes(x = reorder(name_full,salary), y = salary, fill = "black"))+
      theme_bw() +
      labs(x = "College",
           y = "Average Yearly Salary * 1 Mil",
           title = "Average Yearly Salary by College US")+
      scale_y_continuous(label = function(x){return(paste("$",x))})+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )+
      coord_flip()
    
    US_count_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      group_by( name_full, birthYear) %>%
      summarise(
        yob = mean(birthYear)) 
    
    
    US_college_count5 <- US_count_data %>%
      count(name_full, sort = TRUE)
    
    total_US_Data <- US_college_count5 %>%
            left_join(US_salary_by_college, by = "name_full")%>%
            na.omit()
    
    view(total_US_Data)
    
    total_US_30 <- total_US_Data %>%
                filter(n > 29)
    library(ggrepel)
    
    ggplot( data = total_US_30 ) +
        geom_point(mapping = aes(x = salary, y = n, color = name_full ))+
      geom_text_repel(mapping = aes(x=salary,y=n,label=name_full), force = 1)+
      theme(
            legend.position = "none"
        )
    
    
    total_US_4 <- total_US_Data %>%
      filter(salary > 4)
    
    
    ggplot( data = total_US_4 ) +
      geom_point(mapping = aes(x = salary, y = n, color = name_full ))+
      geom_text_repel(mapping = aes(x=salary,y=n,label=name_full), force = 1)+
      theme(
        legend.position = "none"
      )
    
    
    US_count_data <- colleges %>%
      left_join(schools, by = "schoolID") %>%
      left_join(playerinfo, by = "playerID") %>%
      group_by( name_full, birthYear) %>%
      summarise(
        yob = mean(birthYear)) 
    
    US_college_count5 <- US_count_data %>%
      count(name_full, sort = TRUE)
    
    count_US_15 <- head( US_college_count5, 15)
    
    
    ggplot(data = count_US_15)+
      geom_col(mapping = aes(x = reorder(name_full,n), y = n, fill = "lightblue"), position = 'dodge')+
      labs( x = "College",
            y = "Count",
            title = "# of Players from each College US",
            fill = "College")+
      coord_flip()+
      theme_bw()+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank()
      )
    
    ggplot(count_US_15,aes(x = n, y = 1, label = rownames(count_US_25$name_full)))+
      geom_point(color="red")+
      geom_text_repel(
        label = count_US_25$name_full,
        nudge_y = 0.05,
        direction = "x",
        angle = 90,
        vjust = 0,
        segment.size = 0.2
      )+
      xlim(30,70)+
      ylim(1,0.8)+
      theme(axis.line.y = element_blank(),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            axis.title.y = element_blank(),
            panel.grid = element_blank())+
      labs(x = "Count",
           title = "Total # of Players Professionally")
    
    
    ## By state
    
    US_salary_by_State <- US_Single_player_college %>%
      group_by(state) %>%
      summarise(
        salary = mean(salary)/1000000
      )
    
    US_salary_by_State <- US_salary_by_State[order(-US_salary_by_State$salary),]

    view(US_salary_by_State)
        
    ggplot(data = US_salary_by_State)+
      geom_col(mapping = aes(x = reorder(state,salary), y = salary, fill = "lightblue"))+
      coord_flip()+
      theme_bw()+
      labs(x = "Salary * 1 Mil",
           y = "State",
           title = "Salary by State College was Located In"
           )+
      theme(
        legend.position = "none",
        panel.grid.major.y = element_blank())
    
   
    