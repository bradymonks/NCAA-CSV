#Notes from 'R for Data Science'

#Chapter 3

#first always load up tidyverse

#Basic layout for a graph is
ggplot(data = <dataset> )+
    geom_function(mapping = aes( x = ..., y = ... (these are mappings)))

#Mappings include: x, y , size, shape, color, alpha,
#if stuck get help by running ?function_name for examples that match you
#facets are a valuable way of splitting up the data
#   facet_grid(var1 ~ var2) will create a facet for each axis
#go to https://exts.ggplot2.tidyverse.org/gallery/ for all the geoms
#3.8 - postion adjustments
#position = identity, dodge, or fill
#avoid overlapping on geom_point by setting position = jitter
#shorthand is geom_jitter()
#coord_flip() switches the axis
#coord_polar() gives you a coxcomb chart

##
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
##

library(tidyverse)
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()+
  coord_flip()

install.packages("maps")
map_data("usa")

us<- map_data("usa")
ggplot(us, aes(long, lat, group = group))+
    geom_polygon(fill = "white", color = "black")+
    coord_quickmap()+
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank())

?geom_rect()


bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

##Chapter 28
# Need to create plots that are as self-explanatory as possible
# Begin with your labels (x, y, title)
#     use labs( x = "xxxx", y = "yyyy", title = "title", 
#                 subtitle = "subtitle", caption = "caption")
# caption adds text at bottom right, usually for source of data
# title must summarise main finding
# can use math equations for text strings, switch " " with quote(sum[x])
# use geom_text(aes(label = var), data = <data>) to label on the plot
#     use geom_label_repel(aes(label = model), data = <data>)
#     this will displace the label and connect a line to from label to point
# Can make plot without legend by using theme(legend.position = "none")
# can put a label onto the graph using this code

label <- mpg %>%
  summarise(
    displ = max(displ),
    hwy = max(hwy),
    label = "Increasing engine size is \nrelated to decreasing fuel economy."
  )

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_text(aes(label = label), data = label, vjust = "top", hjust = "right")

# use geom_hline() for reference lines (size = 2),(color = white)
# use geom_rect() to draw rectangle around points of 
#     interest (xmin,xmax, ymin, ymax)
# Scales
# to break up the scales on axis use 
#   scale_y_continuous(breaks = seq(start#, end#, by = #)))
# to change location of legend use
#  plot + theme(legend.position = "left/top/bottom/right")
# to change look of legend
#  guides(colour = guide_legend(nrow = 1, override.aes = list(size = 4))
# ColorBrewer scales at http://colorbrewer2.org/
# to change color use 
#  scale_colour_brewer (palette = "Set#")
# Example of color use and segment

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

# to zoom in on a plot use coord_cartesian(xlim = c(#,#), ylim = c(#,#))
# you can share scales accross multiple graphs
#   x_scale <- scale_x_continuous (limits = range(data$var))
# this is useful for spreading plot over multiple pages in report
# Themes
# can find many at https://github.com/jrnold/ggthemes
# saving plots
# ggsave("plot1.png",plot = plot1)

## Chapter 6
# use the editor for coding

## Chapter 11
# use dataset <- read_csv("file.csv") to open csv file in R
# use read_csv2() whenever the delimiter is a ","
# use skip = # to skip the first # lines  
# use comment = "#" to drop all lines that start with "#"
# use col_names = FALSE to tell R not to treat first row as headings
#     read_csv("file.csv", col_names = FALSE)
# use col_names = c("x", "y", "z") to name columns
# use na = "." to declare . as a missing value and put na there instead
# use parse_logical/factor/etc. to return specific data
#   parse_integer(c("1", "231", ".", "456"), na = ".")
#   parse_date("01/02/15", "%m/%d/%y")
#   parse_logical
#   parse_integer
#   parse_date
#   parse_datetime
#   parse_time
#   parse_double
#   parse_character
#   parse_factor
# use guess_parser(" input ")
# work column by column until there aren't any problems anymore
#  in col_types = cols(
#       x = col_double(),
#       y = col_logical()
#       )
# then change the col_type to the correct one
#  to write a file use
#     write_csv(file, "file.csv")



nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv",
