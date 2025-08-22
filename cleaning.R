
library(tidyverse)
library(stringr)

# Needed to link identifier in filename with student id
participants <- read_csv("input/Grades-DATA201-DATA422-25S2-Written Advice on Māori Data Governance and Sovereignty-4325065.csv") %>%
  janitor::clean_names() %>%
  filter(status == "Submitted for grading -  -") %>%
  mutate(identifier = str_split_i(identifier, " ", 2)) %>%
  select(id_number, identifier)

# Warning - destructively renames files
file.rename(
  list.files("input/submissions/", full.names = TRUE),
  paste0(
    "input/submissions/",
    str_split_i(list.files("input/submissions/"), "_", 2),
    ".",
    str_split_i(list.files("input/submissions/"), "\\.", -1)
    )
)

# Create folder for each ID number
sapply(participants$id_number, function(id) {
  dir.create(file.path("allocation", id), showWarnings = FALSE)
})
