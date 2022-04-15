
# shinymisc: Miscellaneous educational shiny apps

The `shinymisc` package provides a set of apps that are useful for
beginner, intermediate, and advanced `shiny` developers to explore
different features of the `shiny` framework and philosophy.

## Installation

``` r
devtools::install_github("Nelson-Gon/shinymisc")
```

## Loading the package

``` r
library(shinymisc)
```

    ## Loading required package: shiny

## Exploring included apps

`shinymisc` contains a number of apps that demonstrate different
concepts.

To view an app, run the following:

``` r
run_app(app_name = "theming")
```

-   [Plot
    theming](https://github.com/Nelson-Gon/shinymisc/blob/main/R/theming.R)

This app takes a fairly advanced approach at demonstrating how one can
combine different `shiny` principles to achieve plot customization. This
was built to help me figure out how to best choose themes from different
packages. In particular, I wanted to do this even if the package was not
on the `search` list.

This app explores concepts of reactivity, modularization, testing, and
scaling in general.

``` r
run_app("theming")
```

-   [Sample App](https://nelson-gon.shinyapps.io/sampleapp)

This app aims to do something fairly simple. It takes input data, allows
user confirmation and finally prints the data entered. It was built as
part of a blog I wrote to highlight `shiny` features like reactivity,
observers, and performance improvements. This blog post is available at
<https://nelson-gon.github.io/12/12/2021/shiny-reactivity/>. You can
view the source code
[here](https://github.com/Nelson-Gon/shinymisc/blob/main/R/sample_app.R).

-   [List Package
    Functions](https://github.com/Nelson-Gon/shinymisc/blob/main/R/list_functions.R)

This app was written as I tried to play around with namespaces and
accessing functions in a package. In particular, I wanted to be able to
load a function from a package without necessarily loading said package
first. This is important because sometimes loading a package may result
in function conflicts causing further debugging work.

-   [Shiny
    Modules](https://github.com/Nelson-Gon/shinymisc/blob/main/R/modular_app.R)

This simple app explores the use of shiny
[modules](https://shiny.rstudio.com/articles/modules.html). This is
aimed at demonstrating how one can reuse code across different places
within the app without copying and pasting the same code over and over
again. The app also shows how to use some different layouts.

-   [More
    Modules](https://github.com/Nelson-Gon/shinymisc/blob/main/R/more_modules.R)

Another module based app that also includes some basic plotly plots.
This app was created as a way for me to debug some issue with `shiny`’s
module system and the use of `update*` functions. Specifically,
sometimes, it is possible that `update*` functions may not work as
expected/intended. Unfortunately this is not readily visible in this
app. Hopefully with more exploration, one could meet this pitfall and
play with ways around it.

Keep building,

Nelson

2022-04-15

------------------------------------------------------------------------

Please note that the `shinymisc` project is released with a [Contributor
Code of
Conduct](https://github.com/Nelson-Gon/shinymisc/blob/main/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

To raise an issue, please do so
[here](https://github.com/Nelson-Gon/shinymisc/issues)

Thank you, feedback is always welcome :)
