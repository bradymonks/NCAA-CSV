library(tidyverse)

Letters <- read_lines("https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters.txt")
Letters_numbers <- read_lines("https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters_wnumbers.txt")

sentence <- c()
for (i in seq(1, str_length(Letters)/1700)) {sentence <- str_c(sentence, str_sub(Letters, start = i*1700, end = i*1700))}

sentence

# The plural of anecdote is not data. 


Numbers <- c()
Numbers <- str_extract_all(Letters_numbers,("\\d\\d|\\d"))  
Numbers

ConvertNumbers <- str_replace_all(c("1" = "a","2" = "b","3" = "c","4" = "d","5" = "e","6" = "f","7" = "g","8" = "h","9" = "i", 
                                    "10" = "j","11" = "k","12" = "l","13" = "m","14" = "n","15" = "o","16" = "p","17" = "q",
                                    "18" = "r","19" = "s","20" = "t","21" = "u","22" = "v","23" = "w","24" = "x","25" = "y",
                                    "26" = "z"))
ConvertNumbers

# experts often possess more data than judgement.



Letters_NoSpacePeriod <- Letters %>%
              str_remove_all("[ ]") %>%
              str_remove_all("[.]")
str_detect(Letters_NoSpacePeriod, ("[aeiou]{5}"))
str_detect(Letters_NoSpacePeriod, ("[aeiou]{6}"))
str_detect(Letters_NoSpacePeriod, ("[aeiou]{7}"))
str_locate(Letters_NoSpacePeriod, ("[aeiou]{7}"))
Longest <- str_extract(Letters_NoSpacePeriod, ("[aeiou]{7}"))

Longest
