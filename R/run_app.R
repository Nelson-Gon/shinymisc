#' Run apps in shinymisc
#' @param app_name Name of the app to run
#' @return A shiny app
#' @examples 
#' if (interactive()) run_app("theming")
#' @export
run_app <- function(app_name = "theming"){
  switch(app_name,
         theming = theming_app())
}