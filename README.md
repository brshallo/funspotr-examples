
<!-- README.md is generated from README.Rmd. Please edit that file -->

# funspotr-examples

This repository contains examples of using the package
[funspotr](https://github.com/brshallo/funspotr) on a few github
repositories (also see associated blog post [Identifying R Functions &
Packages Used in GitHub
Repos](https://www.bryanshalloway.com/2022/01/18/identifying-r-functions-packages-used-in-github-repos/).
“R/save-examples.R” is used to create and write files to the “data”
folders.

Currently the data files are static files. However in the future I’d
like to use github actions to (potentially) make some of the data files
located online update on a regular basis.

## Current files

.rds files of direct `funspotr::github_spot_funs()` can be found in
“data”. .csv formmatted files can be found in “data/previews” and
“data/funss” – the former contains files for each repo where parsing was
attempted, the latter contains each instance a function was used and the
file it came from.

``` r
fs::dir_ls("data/funs")
#> data/funs/brshallo-blog-funs-20220114.csv
#> data/funs/drob-tidy-tuesdays-funs-20220114.csv
#> data/funs/jsilge-blog-funs-20220114.csv
#> data/funs/r4ds-chapter-files-funs-20220117.csv
```
