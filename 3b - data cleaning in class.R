library(tidyverse)

raw <- read_csv('https://www.dropbox.com/scl/fi/ug8tbxsdd2qtsfqwnnox1/dollar_store.csv?rlkey=fu36g6uhfpx8u644d1rpsq11i&dl=1')

ds <- janitor::clean_names(raw)

ds %>% 
  select(unit_size) %>% 
  mutate(unit_size_c = parse_number(unit_size))

ds %>% 
  select(unit_size) %>% 
  mutate(unit_size_c = parse_number(unit_size)) %>% 
  slice(c(142,192,194, 1:10))

#Make note of:
str_detect()
str_remove()
str_replace()
str_extract()

#Annoying way to use string detect
ds %>% 
  select(unit_size) %>% 
  mutate(unit_size_c = parse_number(unit_size)) %>% 
  mutate(unit_type_each = if_else(str_detect(unit_size, 'each'), 1, 0))

ds %>% 
  select(unit_size) %>% 
  mutate(unit_size_c = parse_number(unit_size)) %>% 
  mutate(unit_type = if_else(str_detect(unit_size, 'each'), 'each',
                                  if_else(str_detect(unit_size, 'ounce'), 'ounce', 'changeme'))) %>% 
  filter(unit_type == 'changeme')

#Easier way than above
ds %>% 
  select(unit_size) %>% 
  mutate(unit_size_c = parse_number(unit_size)) %>% 
  mutate(unit_type = str_extract(unit_size, 'each|ounce|pound'))

#string remove
ds %>% 
  select(product_info) %>% 
  mutate(product_info_c = str_remove(product_info, 'Brand:'))

#string remove all
ds %>% 
  select(product_info) %>% 
  mutate(product_info = str_remove_all(product_info, 'Brand:|Product:'))

#This doesn't work because it's looking for Regex
ds %>% 
  select(description) %>% 
  mutate(description = str_remove_all(description, '['))

#Might have to use escape:
#This doesn't work because it's looking for Regex
ds %>% 
  select(description) %>% 
  mutate(description = str_remove_all(description, '\\['))

ds %>% 
  select(description) %>% 
  mutate(description = str_remove_all(description, '\\[|\\]')) %>% 
  #Get columns that have '' and set them equal to NA
  mutate(description = na_if(description, ''))




# Convert to number formats: price, star_rating, review_count, stock_status, unit_size
#   Goals:   (1) Don't lose information
#            (2) Missing where appropriate, but only where appropriate



# Create usable brand and product_name columns from the product_info column
#   Hints:  (1) Ensure missingness is appropriate. 
#           (2) If possible, exploit any repeated structure in the column

ds %>% 
  select(product_info) %>% 
  #split into 2 or more columns, split using delimiter
  separate_wider_delim(product_info, 
                       delim= ' - ',
                       names = c('brand', 'product'),
                       #drop: drop anything more than expected
                       #merge: merge any extras into last one
                       too_many = 'merge')
  


# Create usable brand and product_name columns from the product_info column
#   Hints:  (1) Ensure missingness is appropriate. 
#           (2) If possible, exploit any repeated structure in the column


# Convert date columns to date and/or date-time columns, then calculate how many
# days each product sat on the shelf before its first sale.

#tidyverse packages that handles dates and times
library(lubridate)

ds %>% 
  select(date_added, first_sold_day, first_sold_time) %>% 
  #Change from string to date
  mutate(date_added_c = dmy(date_added))

ds %>% 
  select(date_added, first_sold_day, first_sold_time) %>% 
  mutate(first_together = str_c(first_sold_day, first_sold_time, sep = ' ')) %>% 
  mutate(first_sold_dt = mdy_hms(first_together))

########################
#       1/24/24
########################

#DATA CLEANING ASSIGNMENT

#question 5 help:
# the last paragraph will give you the 10 districts in question
# hardest part is extracting a usable district column:
# ***separate_wider_delim
# ^have to remove/clean surrounding pipes for the above function to be useful
# column separating doesn't always have a district and that's fine (ignore it)
# save top 3 wherever (can copy and paste) -> whatever this means

#This will detect 'one' and 'ones' etc.
str_detect(col_name, 'one')

#^If you only want 'one' than use: 
col_name %in% names #or use == so it's exact

#question 7:
# 3 lines down talks about why it's abnormal
# challenge for the question is figuring out how to fix it
# range means min and max



