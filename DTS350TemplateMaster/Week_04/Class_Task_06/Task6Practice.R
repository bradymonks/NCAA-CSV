library(tidyverse)

mtcars

str(mtcars)

ggplot(mtcars, aes(x = cyl))+
    geom_bar()

ggplot(mtcars, aes(x = factor(cyl)))+
  geom_bar( width = 0.5, fill = "blue", alpha = 0.5)

ggplot(mtcars, aes(x =factor(cyl), fill = factor(cyl)))+
  geom_bar()

ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))+
    geom_bar()+
    theme_bw()

data <- mtcars %>%
  mutate(am = factor(am, labels = c("auto", "manual")),
         cyl = factor(cyl))

str(data)

ggplot(data, aes(x = cyl, fill = am))+
  geom_bar()+
  theme_bw()+
  labs(x = "Cylinder Type",
       y = "Count",
       legend = "Transmission Type")

ggplot(data, aes(x = cyl, fill = am))+
  geom_bar(position = position_dodge())+
  coord_flip()+
  theme_bw()

df <- mtcars %>%
  rownames_to_column() %>%
  as_data_frame() %>%
  mutate(cyl = as.factor(cyl)) %>%
  select(rowname, wt, mpg, cyl)

df

ggplot(df, aes(x = rowname, y = mpg))+
  geom_col()+
  theme(axis.text.x = element_text(size = rel(.5), angle = 90))

ggplot(df, aes(x = reorder(rowname,mpg), y = mpg))+
  geom_col()+
  theme(axis.text.x = element_text(size = rel(.5), angle = 90))

ggplot(df, aes(x = reorder(rowname, mpg),y = mpg))+
  geom_col(aes(fill = cyl))+
    geom_text(aes(label = mpg), nudge_y = 2, size = rel(2))+
    coord_flip()+
    scale_fill_viridis_d()

economics
?economics

ggplot(data = economics, aes(x = date, y = pop, size = unemploy/pop))+
  geom_line()

ggplot(data = economics, aes(x = date, y = psavert))+
  geom_line()

ggplot(data = economics, aes(x = date))+
  geom_line(aes(y = psavert), color = "red")+
  geom_line(aes(y = uempmed), color = "blue")


data_combined <- economics %>%
  select(date, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date)
data_combined

ggplot(data_combined, aes(x = date, y = value))+
  geom_line(aes(color = variable, linetype = variable))+
  scale_color_manual(values = c("red", "blue"))

ggplot(mtcars, aes(factor(cyl), mpg))+
  geom_boxplot()

ggplot(mtcars, aes(factor(cyl), mpg))+
  geom_boxplot(aes(color = factor(am)))

ggplot(mtcars, aes(factor(cyl), mpg, color = factor(am)))+
  geom_boxplot()+
  geom_jitter()
