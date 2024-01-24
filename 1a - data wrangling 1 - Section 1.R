library(tidyverse)

# Because `starwars` is a "hidden" dataset in memory for demonstration, it won't show up in our environment at 
# first, and it'll also be hard to reset it if we make a mistake. So assign it to `df` to make sure you can work
# with it.
df <- starwars

df

# glimpse turns a data frame on its side. Super useful.
df %>%
  glimpse()
  


# iteratively add operations: 
# height > 100, sex == female, 
# choose name, height, mass, species, films, 
# mass > 50, 
# arrange by mass
# note: filtering on some logical excludes NAs
df %>% 
  filter(height > 100,
         sex == 'female') %>% 
  select(name, height, mass, species, films) %>% 
  filter(mass > 50) %>% 
  arrange(mass)

df %>%
  filter(height > 100, sex == 'female')
#same as above
df %>%
  filter(height > 100) %>% 
  filter(sex == 'female')

df %>%
  filter(height > 100, 
         species %in% c("Human", "Droid", "Twi'lek", "Mirialan", "Clawdite", "Togruta"),
         sex == 'female') %>% 
  select(name, height, mass, species, films) %>% 
  filter(mass > 50)

tall_females <- df %>%
  filter(height > 100, 
         sex == 'female') %>% 
  select(name, height, mass, species, films) %>% 
  filter(mass > 50) %>% 
  # Order by
  arrange(mass)

tall_females


# calculate a new column,weight_lbs = mass * 2.204623
# Make sure it gets saved to the tibble...
df <- df %>% 
  mutate(weight_lbs = mass * 2.204623)
<<<<<<< Updated upstream:1a - data wrangling 1 - Section 1.R
  
=======
>>>>>>> Stashed changes:data wrangling 1 - Section 2.R


# group and summarize. Pay attention to NAs
# get a count and mean mass by species
<<<<<<< Updated upstream:1a - data wrangling 1 - Section 1.R
df %>% glimpse


df %>% 
  group_by(species) %>% 
  summarize(species_count = n(),
            avg_mass = mean(mass, na.rm = TRUE)) 

df %>% 
  filter(species == 'Droid')
=======
df %>% 
  group_by(species) %>%
  # If you wanted to remove all records that are NA for mass
  # filter(!is.na(mass)) %>% 
  summarise(species_count = n(),
            na_count = sum(is.na(mass)),
            avg_mass = mean(mass, na.rm = TRUE))

df %>% 
  filter(species == 'Droid')

# Slicing
df %>% 
  slice(1:10)

#Take top "x"
df %>% 
  slice_head(n = 15)

#3 tallest
df %>% 
  arrange(desc(height)) %>% 
  slice_head(n=3)

#3 shortest
df %>% 
  slice_min(height, n=3)

df %>% 
  slice_min(mass, n = 5)

#random 10% of darta
df %>% 
  slice_sample(prop = 0.1)

#Tallest character from each species
df %>% 
  group_by(species) %>% 
  slice_max(height)

#Shortest character of each species, NO TIES
df %>% 
  group_by(species) %>% 
  slice_min(height, with_ties = F)


df %>% 
  count(height)

df %>% 
  count(height, sort = T)

df %>% 
  filter(height == 96)


#Grouping
df %>% 
  group_by(homeworld,gender) %>% 
  summarise(count = n(), avg_birth_year = mean(birth_year, na.rm = T))

#double group by
df %>% 
  group_by(species) %>% 
  slice_min(mass, n = 1, with_ties = F) %>% 
  group_by(sex) %>% 
  summarise(avg_height = mean(height, na.rm = T))
>>>>>>> Stashed changes:data wrangling 1 - Section 2.R


# Lots of NAs for average... why? Even for large groups it's NA...


# Humans definitely have SOME mass data...


# so let's exclude NAs from the mean aggregation:



# why does Chagrian have a weird NaN?


# top 5 tallest overall - using slice_head


# or just using slice_max


# what is the shortest character for each species? 




# ALso summarize isn't always the goal what if we want a relative 
# comparison of height for each species? I.e., are you tall for a human?
# calculate tallest for each species without summarizing, convert to percentile, show a few of the columns, sort





# Grouping by multiple
# Was is the average birth year for each gender from each homeworld







