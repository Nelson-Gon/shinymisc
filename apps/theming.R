library(shiny)
library(shinyWidgets)
library(ggplot2)

# https://mastering-shiny.org/scaling-functions.html

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

ui <- fluidPage(tabsetPanel(tabPanel(
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
        4, textInput("theme_pkg", "Package",
                     value = "ggplot2")
      ))
      
      
      
    ),
    mainPanel(plotOutput("data_plot"))
  )
  
  
)))

server <- function(session, input, output) {
  datasets <- reactive(Filter(function(x)
    is.data.frame(get(x)),
    ls("package:datasets")))
  
  in_data <- reactive(get(req(input$data_in)))
  
  get_themes <- reactive({
    themes_from <- req(input$theme_pkg)
    themes_only <- grep("^theme_", getNamespaceExports(themes_from))
    return(getNamespaceExports("ggplot2")[themes_only])
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
          lab = y,
          choices = names(in_data())
        ),
      c("x_val", "y_val"),
      c("X", "Y")
    )
    
    
    update_picker(session, "plot_theme", "theme",
                  choices = get_themes())
  })
  
  output$data_plot <- renderPlot(ggplot(in_data(),
                                        aes(.data[[req(input$x_val)]],
                                            .data[[req(input$y_val)]])) +
                                   geom_point() +
                                   labs(x = req(input$x_val), 
                                        y = req(input$y_val)) +
                                   get_theme())
}

shinyApp(ui, server)
