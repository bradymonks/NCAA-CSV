 Task 8
 Chapter 20
 Vectors
 Two types of vectors
     Atomic - logical, integer, double, character, complex, raw
     Lists
 Difference is that atomic vectors are homogeneous, list can be hetergeneuos
 Every vector has two key properties
     Type - can determine by using typeof()
     Length - can determine by using length()
 Augmented Vectors are created using attributes
     Types
       Factors are built on top of integer vectors
       dates and date-times are built on top of numeric vectors
       Data frames and tibbles are built on top of lists

 Top 4 types of Vectors
     Logical
   Simplest type due to only having three possible values
     - FALSE, TRUE, NA
     
     Numeric
   Integer and double vectors are knownw collectively as numeric
     - In order to make an input an integer place an L after the number
           typeof(1L)

 Use near() instead of '==' when comparing floating numbers
 Use helper functions 'is.finite()','is.infinite()','is.na()','is.nan()'

 Character vectors take up a lottttt of data
 
 Coercion (convert)
    -Two ways to convert vectors
	Explicit Coercion 
		- as.double(), as.character(), as.logical(), as.integer()
	Implicit Coercion
   - When using vector in a function that expects a different vector
  
	Naming vectors
	  purrr::set_names(1:3, c("a","b","c"))
Subsetting
	x <- c("one", "two", "three", "four", "five")  
	x[c(1, 1, 5, 5, 5, 2)]

	
	
Chapter 18 Pipes

Pipes are '%>%'
- help unclutter certian functions
Little bunny foo foo example

foo_foo %>%
  hop(through = forest) %>%
  scoop(up = field_mice) %>%
  bop(on = head)

When not to use pipe
  - pipes are longer than about 10 steps
  - there are multiple outputs
  

