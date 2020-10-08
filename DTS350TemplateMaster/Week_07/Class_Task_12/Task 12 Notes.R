# Task 12 Notes

Chapter 12 Tidy Data

-variables are in columns
-observations are in rows
-values are in cells.

Two ways to pivot are longer and wider

- pivot_longer : moves column names into individual values

dataframe %>%
  pivot_longer(c('col_name','col_name'), names_to = "new column name", values_to = "new column name")

use left_join() to put two tables together with common columns

- pivot_wider(): moves values into columns

dataframe %>%
  pivot_wider(names_from = column_name, values_from = column_name


Separating

- separate() pulls apart one column into multiple columns, by splitting wherever a separator character appears

table3 %>% 
  separate(rate, into = c("cases", "population"))

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")


Uniting

unite() is the inverse of separate(): it combines multiple columns into a single column. You’ll need it much 
less frequently than separate(), but it’s still a useful tool to have in your back pocket.

table5 %>% 
  unite(new, century, year)

table5 %>% 
  unite(new, century, year, sep = "")

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(
    cols = c(`2015`, `2016`), 
    names_to = "year", 
    values_to = "return", 
    values_drop_na = TRUE
  )


Temporary file - to create temporary file

tempfile()



