# r4wrds

[r4wrds.com](r4wrds.com) stands for "R for Water Resources Data Science". This repository is used to build the website.  


# Developer guide

Clone this repo, and open `WRDS_index.RProj`, which will trigger [`{renv}`](https://rstudio.github.io/renv/articles/collaborating.html) to install package dependencies. 

Depending on your system build, you may need to configure `{rJava}`, `{sf}`, and `GDAL`. 

If you run into issues, these links may be helpful towards those ends:

* [rJava](https://github.com/rstudio/rstudio/issues/2254#issuecomment-418830716)
* [sf](https://r-spatial.github.io/sf/#installing)
* [GDAL](https://r-spatial.github.io/sf/#macos)


# Build

The most straightforward way to build the entire site at once is to open the `intro/WRDS_intro.RProj` and `intermediate/WRDS_intermediate.RProj` files, and then run `rmarkdown::render_site()`. This will build all `.Rmd` files in the project directory into `.html` files. 

# License

Software is open-source, provided under the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
