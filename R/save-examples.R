library(dplyr)
library(funspotr)

### Parse R/Rmd files in github repos ###

Sys.sleep(45 * 60)
drob_tidy_tuesdays <- funspotr::github_spot_funs("dgrtwo/data-screencasts",
                                                 branch = "master",
                                                 show_each_use = TRUE)

Sys.sleep(61 * 60)
jsilge_blog <- funspotr::github_spot_funs("juliasilge/juliasilge.com",
                                          branch = "master",
                                          show_each_use = TRUE)

Sys.sleep(61 * 60)
brshallo_blog <- funspotr::github_spot_funs("brshallo/brshallo",
                                            branch = "master",
                                            show_each_use = TRUE)


# R4DS book, only keep files that are chapters in book
ch_files <- yaml::read_yaml("https://raw.githubusercontent.com/hadley/r4ds/main/_bookdown.yml") %>%
  purrr::pluck("rmd_files")

ch_urls <-
  funspotr::github_spot_funs(repo = "hadley/r4ds",
                             branch = "main",
                             preview = TRUE) %>%
  filter(contents %in% ch_files)

ch_urls <- ch_urls %>%
  # Arrange by order of chapters
  mutate(contents_fct = factor(contents, levels = ch_files, ordered = TRUE)) %>%
  arrange(contents_fct) %>%
  select(-contents_fct)

r4ds_book <- funspotr::github_spot_funs(custom_urls = ch_urls,
                                        show_each_use = TRUE)

### Create data folders ###

fs::dir_create("data")
fs::dir_create("data", "previews")
fs::dir_create("data", "funs")
fs::dir_create("data", "deps")

### Save RDS files ###

readr::write_rds(drob_tidy_tuesdays, here::here("data", "drob-tidy-tuesdays-20220114.rds"))
readr::write_rds(jsilge_blog, here::here("data", "jsilge-blog-20220114.rds"))
readr::write_rds(brshallo_blog, here::here("data", "brshallo-blog-20220114.rds"))
readr::write_rds(r4ds_book, here::here("data", "r4ds-chapter-files-20220117.rds"))

#### Save previews ###

drob_tidy_tuesdays %>%
  select(-spotted) %>%
  readr::write_csv(here::here("data", "previews", "drob-tidy-tuesdays-preview-20220114.csv"))

jsilge_blog %>%
  select(-spotted) %>%
  readr::write_csv(here::here("data", "previews", "jsilge-blog-preview-20220114.csv"))

brshallo_blog %>%
  select(-spotted) %>%
  readr::write_csv(here::here("data", "previews", "brshallo-blog-preview-20220114.csv"))

r4ds_book %>%
  select(-spotted) %>%
  readr::write_csv(here::here("data", "previews", "r4ds-chapter-files-preview-20220117.csv"))


### Save functions used ###
### For each repo, have several URL's that errored or didn't have any R code -- so not every file parsed ###

drob_tidy_tuesdays %>%
  funspotr::unnest_github_results() %>%
  readr::write_csv(here::here("data", "funs", "drob-tidy-tuesdays-funs-20220114.csv"))

jsilge_blog %>%
  funspotr::unnest_github_results() %>%
  readr::write_csv(here::here("data", "funs", "jsilge-blog-funs-20220114.csv"))

brshallo_blog %>%
  funspotr::unnest_github_results() %>%
  readr::write_csv(here::here("data", "funs", "brshallo-blog-funs-20220114.csv"))

r4ds_book %>%
  funspotr::unnest_github_results() %>%
  readr::write_csv(here::here("data", "funs", "r4ds-chapter-files-funs-20220117.csv"))

### Get package dependencies for each ###


# Sys.sleep(45 * 60)

drob_tidy_tuesdays_deps <-
  funspotr::github_spot_pkgs("dgrtwo/data-screencasts",
                             branch = "master")

# Sys.sleep(61 * 60)
jsilge_blog_deps <-
  funspotr::github_spot_pkgs("juliasilge/juliasilge.com",
                             branch = "master")

# Sys.sleep(61 * 60)
brshallo_blog_deps <- funspotr::github_spot_pkgs("brshallo/brshallo",
                                                 branch = "master")

r4ds_book_deps <- funspotr::github_spot_pkgs(custom_urls = ch_urls)

### Write package dependencies to .csv ###

drob_tidy_tuesdays_deps %>%
  unnest_github_results() %>%
  rename(pkgs = spotted) %>%
  readr::write_csv(here::here("data", "deps", "drob-tidy-tuesdays-deps-20220118.csv"))

jsilge_blog_deps %>%
  unnest_github_results() %>%
  rename(pkgs = spotted) %>%
  readr::write_csv(here::here("data", "deps", "jsilge-blog-deps-20220118.csv"))

brshallo_blog_deps %>%
  unnest_github_results() %>%
  rename(pkgs = spotted) %>%
  readr::write_csv(here::here("data", "deps", "brshallo-blog-deps-20220118.csv"))

r4ds_book_deps %>%
  unnest_github_results() %>%
  rename(pkgs = spotted) %>%
  readr::write_csv(here::here("data", "deps", "r4ds-chapter-files-deps-20220118.csv"))
