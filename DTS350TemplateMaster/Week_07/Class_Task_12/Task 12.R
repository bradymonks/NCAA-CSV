# Task 12

library(tidyverse)
library(readxl)
library(downloader)

messy_data <- read_xlsx("messy_data.xlsx")
messy_data1 <- read_xlsx("messy_data.xlsx", skip = 2, col_names = FALSE)



messy_data
messy_data1

messy_data_del <- subset(messy_data1, select = -c(3,4,6,7,9,10,12,13,15,16) ) 

messy_df <- messy_data_del %>%
  pivot_longer(c('...5','...8','...11','...14','...17'), names_to = "Class",values_to = "Grades") %>%
  na.omit()

messy_df

ggplot(data = messy_df)+
  geom_bar(mapping = aes(x = Grades, fill = Grades))


view(messy_data)
view(messy_data1)


#names(messy_data1)

#names(messy_data1)[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)] <- c("Student ID","Current Major", "CS 241", "CS 241 Semester","CS 241 Final Grade","CS 450","CS 450 Semester","CS 450 Final Grade","Math 325","Math 325 Semester","Math 325 Final Grade", "Math 335", "Math 335 Semester", "Math 335 Final Grade","Math 425","Math 425 Semester","Math 425 Final Grade")

#names(messy_data1)[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)] <- c("Student ID","Current Major", "CS 241", "Semester","Final Grade","CS 450","Semester","Final Grade","Math 325","Semester","Final Grade", "Math 335", "Semester", "Final Grade","Math 425","Semester","Final Grade")


#messy_data1 <- messy_data1 %>%
#  pivot_longer(c('CS 241','CS 450','Math 325','Math 335','Math 425'), names_to = "Course", values_to = "Major at Beginning of Course")

#messy_data1 <- messy_data1 %>%
#  select("Student ID","Current Major","Course","Major at Beginning of Course", everything())

