library(tidyverse)

Census <- read_csv("CensusAtSchool.csv")

view(Census)

df_inch <- mutate(Census,
                    Height = Height / 2.54, 
                    Foot_Length = Foot_Length / 2.54,
                    Arm_Span = Arm_Span / 2.54)

view(df_inch)

df_enviroment <- filter(Census, 
                          Importance_reducing_pollution > 750|
                          Importance_recycling_rubbish > 750|
                          Importance_conserving_water >750|
                          Importance_saving_enery > 750|
                          Importance_owning_computer > 750|
                          Importance_Internet_access >750)+
                        
view(df_enviroment)

df_enviroment <- arrange(df_enviroment, Ageyears)

df_extra <- select(Census, 
                   Country, 
                   Region, 
                   Gender, 
                   Ageyears,
                   Handed,
                   Height,
                   Foot_Length,
                   Arm_Span,
                   Languages_spoken,
                   Travel_to_School,
                   Travel_time_to_School,
                   Reaction_time,
                   Score_in_memory_game,
                   Favourite_physical_activity
                   )
view(df_extra) 

CountCensus <- group_by (Census, Country, Gender)

df_numbers <- summarise(CountCensus, 
                 count= n(),
                 Poll_avg = mean(Importance_reducing_pollution,na.rm = TRUE),
                 Recy_avg = mean(Importance_recycling_rubbish,na.rm = TRUE),
                 Watr_avg = mean(Importance_conserving_water,na.rm = TRUE),
                 Enrg_avg = mean(Importance_saving_enery,na.rm = TRUE),
                 Comp_avg = mean(Importance_owning_computer,na.rm = TRUE),
                 Intr_avg = mean(Importance_Internet_access,na.rm = TRUE))
view(df_numbers)

CountCensus <- group_by (Census, Country, Gender)

df_gender <- summarise(CountCensus, 
                       Poll_avg = mean(Importance_reducing_pollution,na.rm = TRUE),
                       Poll_STD = sd(Importance_reducing_pollution,na.rm = TRUE),
                       Recy_avg = mean(Importance_recycling_rubbish,na.rm = TRUE),
                       Recy_STD = sd(Importance_recycling_rubbish,na.rm = TRUE),
                       Watr_avg = mean(Importance_conserving_water,na.rm = TRUE),
                       Watr_STD = sd(Importance_conserving_water,na.rm = TRUE),
                       Enrg_avg = mean(Importance_saving_enery,na.rm = TRUE),
                       Enrg_STD = sd(Importance_saving_enery,na.rm = TRUE),
                       Comp_avg = mean(Importance_owning_computer,na.rm = TRUE),
                       Comp_STD = sd(Importance_owning_computer,na.rm = TRUE),
                       Intr_avg = mean(Importance_Internet_access,na.rm = TRUE),
                       Intr_STD = sd(Importance_Internet_access,na.rm = TRUE))
df_gender
                  
view(df_gender)

CountCensus1 <- group_by (Census, Languages_spoken, Travel_to_School)

df_hand <- summarise(CountCensus1, 
                        Score_Avg = mean(Score_in_memory_game, na.rm = TRUE),
                        Poll_avg = mean(Importance_reducing_pollution,na.rm = TRUE),
                        Recy_avg = mean(Importance_recycling_rubbish,na.rm = TRUE),
                        Watr_avg = mean(Importance_conserving_water,na.rm = TRUE),
                        Enrg_avg = mean(Importance_saving_enery,na.rm = TRUE),
                        Comp_avg = mean(Importance_owning_computer,na.rm = TRUE),
                        Intr_avg = mean(Importance_Internet_access,na.rm = TRUE))
view(df_hand)

