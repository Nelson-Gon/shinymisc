
# shinymisc: Miscellaneous shiny apps built as part of debugging/exploration

This repository holds code for apps I built mainly as part of my
debugging and exploration process. They are shared here for educational
purposes only. If you find them useful, please cite as necessary. If you
would like to build these apps further, please fork the repository and
suggest changes so I can review.

# List of [apps](https://github.com/Nelson-Gon/shinymisc/blob/main/apps)

-   [Sample App](https://nelson-gon.shinyapps.io/sampleapp)

This app aims to do something fairly simple. It takes input data, allows
user confirmation and finally prints the data entered. It was built as
part of a blog I wrote to highlight `shiny` features like reactivity,
observers, and performance improvements. This blog post is available at
<https://nelson-gon.github.io/12/12/2021/shiny-reactivity/>. You can
view the source code
[here](https://github.com/Nelson-Gon/shinymisc/blob/main/apps/sample_app.R).

-   [List Package
    Functions](https://github.com/Nelson-Gon/shinymisc/blob/main/apps/list_functions.R)

This app was written as I tried to play around with namespaces and
accessing functions in a package. In particular, I wanted to be able to
load a function from a package without necessarily loading said package
first. This is important because sometimes loading a package may result
in function conflicts causing further debugging work.

-   [Plot
    theming](https://github.com/Nelson-Gon/shinymisc/blob/main/apps/theming.R)

This app takes a fairly more advanced approach at demonstrating how one
can combine different `shiny` principles to achieve plot customization.
This was built to help me figure out how to best choose themes from
different packages. In particular, I wanted to do this even if the
package was not on the `search` list.

Keep building,

Nelson

2021-12-24

------------------------------------------------------------------------

Please note that the `shinymisc` project is released with a [Contributor
Code of
Conduct](https://github.com/Nelson-Gon/shinymisc/blob/main/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

To raise an issue, please do so
[here](https://github.com/Nelson-Gon/shinymisc/issues)

Thank you, feedback is always welcome :)
