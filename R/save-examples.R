library(tidyverse)
library(funspotr)

Sys.sleep(45 * 60)
drob_tidy_tuesdays <- funspotr::github_spot_funs("dgrtwo/data-screencasts",
                                                 branch = "master",
                                                 show_each_use = TRUE)

Sys.sleep(61 * 60)
jsilge_blog <- funspotr::github_spot_funs("juliasilge/juliasilge.com",
                                          branch = "master",
                                          show_each_use = TRUE)

Sys.sleep(61 * 60)
brshallo_blog <- github_spot_funs("brshallo/brshallo",
                                  branch = "master",
                                  show_each_use = TRUE)

fs::dir_create("data")
readr::write_rds(drob_tidy_tuesdays, here::here("data", "drob-tidy-tuesdays-20220114.rds"))
readr::write_rds(jsilge_blog, here::here("data", "jsilge-blog-20220114.rds"))
readr::write_rds(brshallo_blog, here::here("data", "brshallo-blog-20220114.rds"))

# R4DS book, only keep files that are chapters in book
ch_files <- yaml::read_yaml("https://raw.githubusercontent.com/hadley/r4ds/main/_bookdown.yml") %>%
  purrr::pluck("rmd_files")

ch_urls <- github_spot_funs(repo = "hadley/r4ds", branch = "main", preview = TRUE) %>%
  filter(contents %in% ch_files)

ch_urls <- ch_urls %>% # Arrange by order of chapters
  mutate(contents_fct = factor(contents, levels = ch_files, ordered = TRUE)) %>%
  arrange(contents_fct) %>%
  select(-contents_fct)

r4ds_book <- github_spot_funs(custom_urls = ch_urls,
                              show_each_use = TRUE)

readr::write_rds(r4ds_book, here::here("data", "r4ds-chapter-files-20220117.rds"))
