# https://mastering-shiny.org/scaling-functions.html

# Need to remove this call to ggplot2 
# TODO: Figure out how to get functions from non-loaded packages
# If the above is done, this call shouldn't exist 

# lapply(Filter(function(x) grepl("theme_", x), getNamespaceExports("ggplot2")),
#        utils::getFromNamespace, "ggplot2")

picker_input <- function(id, label, ...) {
  shinyWidgets::pickerInput(id, label, choices = NULL, selected = NULL, ...)
}

update_picker <- function(session, id, label, choices, ...) {
  updatePickerInput(session,
                    id,
                    label ,
                    choices = choices,
                    selected = NULL,
                    ...)
}

# Using Modules instead of functions for 
# UI and server
# https://mastering-shiny.org/scaling-modules.html

#' @title UI  for the theming app
#' @importFrom utils read.csv
#' @importFrom shinyWidgets pickerInput updatePickerInput 
#' @return a UI module 
#' @export

utils::globalVariables(c(".data", "getFunction"))
getFunction<-utils::getFromNamespace("getFunction", "methods")

themingUI <- function() {
  # Function always has an ID
  # Us an NS for ids
  
  tabsetPanel(tabPanel(
    "Input",
    sidebarLayout(
      sidebarPanel(
        picker_input("data_in",
                     label = "Dataset"),
        fluidRow(# Should probably loop this
          column(6, picker_input("x_val", "X")),
          column(6, picker_input("y_val", "Y"))),
        
        fluidRow(column(8, picker_input(
          "plot_theme", "Theme"
        )),
        column(
          4, textInput("theme_pkg",
                       "Package",
                       value = "ggplot2")
        ))
        
        
        
      ),
      mainPanel(plotOutput("data_plot"))
    )
    
    
  ))  
  
}
  
#' Server for the theming app
#' @param input input from UI
#' @param output output server
#' @param session session 
#' @return a server module 
#' @export

themingServer <- function(input, output, session) {
    
    datasets <- reactive(Filter(function(x)
      is.data.frame(get(x)),
      ls("package:datasets")))
    
    in_data <- reactive(get(req(input$data_in)))
    
    get_themes <- reactive({
      themes_from <- req(input$theme_pkg)
      themes_only <- grep("^theme_", getNamespaceExports(themes_from))
      return(getNamespaceExports(themes_from)[themes_only])
    })
    get_theme <- reactive({
      which_theme <- match(req(input$plot_theme), get_themes())
      return(getFunction(get_themes()[which_theme])())
      
    })
    observe({
      update_picker(session, "data_in", "Dataset", choices = datasets())
      
      mapply(
        function(x, y)
          update_picker(
            session,
            id = x,
            label = y,
            choices = names(in_data())
          ),
        c("x_val", "y_val"),
        c("X", "Y")
      )
      
      
      update_picker(session, "plot_theme", "theme",
                    choices = get_themes())
    })
    
    output$data_plot <- renderPlot(ggplot2::ggplot(in_data(),
                                          ggplot2::aes(.data[[req(input$x_val)]],
                                              .data[[req(input$y_val)]])) +
                                     ggplot2::geom_point() +
                                     ggplot2::labs(x = req(input$x_val), 
                                          y = req(input$y_val)) +
                                     get_theme())
    
}

# lapply(Filter(function(x) grepl("theme_", x), getNamespaceExports("ggplot2")),
#        utils::getFromNamespace, "ggplot2")
#' @title An app to demonstrate theming of a plot in shiny 
#' @import shiny
#' @examples 
#' if(interactive()) theming_app()
#' @return 
#' A shiny app to demonstrate concepts of modularization, functions, and testing.
#' @export
theming_app <- function() {
  
 
  ui <- fluidPage(themingUI())
  
  server <- function(session, input, output) {
  themingServer() 
  }
  
  shinyApp(ui, server)
  
}

