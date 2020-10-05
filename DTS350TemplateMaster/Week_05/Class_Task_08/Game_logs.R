library(tidyverse)

bball <- read_csv("game_logs.csv")

bball

# all games where winning team had more than 5 errors

ew <- filter(bball, h_errors > 16 & h_score > v_score | v_errors > 16 & v_score > h_score) %>%
  select(date, h_name, v_name, h_score, v_score, h_errors, v_errors)

view(ew)

error <- filter(bball, h_errors > 25 | v_errors > 25) %>%
  select(date, h_name, v_name, h_score, v_score, h_errors, v_errors)

view(error)

gwrbi <- group_by(bball, winning_rbi_batter_id_name) %>%
  count(winning_rbi_batter_id_name, sort = TRUE) %>%
  filter ( n < 400 & n > 135)

pw <- group_by(bball, winning_pitcher_name) %>%
  count(winning_pitcher_name, sort = TRUE) %>%
  filter ( n < 400 & n > 225)

pw

gwrbi1 <- head(gwrbi)


ggplot( data = gwrbi )+
  geom_col(mapping = aes(x = winning_rbi_batter_id_name, y = n, fill = winning_rbi_batter_id_name))+
  geom_text(aes(x = winning_rbi_batter_id_name, y = n, label=n), position=position_dodge(width=0.9), vjust=-0.25)+
  labs(title = "Most Game Winning RBIs",
       x = "Name",
       y = "Number of RBIs",
       fill = "Name")


ggplot( data = gwrbi )+
  geom_col(mapping = aes(x = reorder(winning_rbi_batter_id_name,n), y = n, fill = winning_rbi_batter_id_name))+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        legend.position = "none")+
  labs(title = "Most Game Winning RBIs",
       x = "Name",
       y = "Number of RBIs",
       fill = "Name")+
  coord_flip()

ggplot( data = pw )+
  geom_col(mapping = aes(x = reorder(winning_pitcher_name,n), y = n, fill = winning_pitcher_name))+
  geom_text(aes(x = winning_pitcher_name, y = n, label=n), position=position_dodge(width=0.9), vjust=-0.25)+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        legend.position = "none")+
  labs(title = "Most Wins",
       x = "Name",
       y = "Number of Wins",
       fill = "Name")+
  coord_flip()

ipoy <- group_by(bball, winning_rbi_batter_id_name) %>%
  count(winning_rbi_batter_id_name, sort = TRUE) %>%
  filter ( n < 400 & n > 135)
