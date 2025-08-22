
library(tidyverse)
library(stringr)

file.rename("input/")

list.files("input/")

participants <- read_csv("input/Grades-DATA201-DATA422-25S2-Written Advice on Māori Data Governance and Sovereignty-4325065.csv") %>%
  janitor::clean_names() %>%
  filter(status == "Submitted for grading -  -") %>%
  mutate(identifier = str_split_i(identifier, " ", 2)) %>%
  select(id_number, identifier)
  
paste0(
  str_split_i(list.files("input/submissions/"), "_", 2),
  ".",
  str_split_i(list.files("input/submissions/"), "\\.", -1)
)