# Case Study 7

height <- tempfile()

tempdir()

download("https://github.com/WJC-Data-Science/DTS350/raw/master/Height.xlsx",
         height, mode = "wb")

heights <- read_xlsx(height)

heights