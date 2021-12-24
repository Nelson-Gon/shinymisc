library(shiny)
library(shinyWidgets)
library(ggplot2)
ui <- fluidPage(
  tabsetPanel(
    tabPanel(
      "Input",
      sidebarLayout(
        sidebarPanel(
          shinyWidgets::pickerInput(
            "data_in",
            label = "Dataset",
            choices = NULL,
            selected = NULL
          ),
          fluidRow(
            column(6,
                   pickerInput("x_val", "X", choices = NULL,
                        selected = NULL)),
            column(6, pickerInput("y_val", "Y", choices = NULL,
                                  selected = NULL))
          ),
          
         fluidRow(column(8,pickerInput("plot_theme", label = "Theme", 
                        choices=NULL,
                      selected = NULL)),
                  column(4, textInput("theme_pkg", "Package",
                                      value = "ggplot2")))
                  
          
          
        ),
        mainPanel(
          plotOutput("data_plot")
          
        )
      )
      
    
  )
))

server <- function(session, input, output){
  
  datasets <- reactive(Filter(function(x) is.data.frame(get(x)), 
                              ls("package:datasets")))
  
  in_data <- reactive(
    get(req(input$data_in))
  )
  
  get_themes <- reactive(
    {
      themes_from <- req(input$theme_pkg)
      themes_only<-grep("^theme_",getNamespaceExports(themes_from))
      return(getNamespaceExports("ggplot2")[themes_only])
    }
  )
  get_theme <- reactive({
    which_theme <- match(req(input$plot_theme), get_themes())
    return(getFunction(get_themes()[which_theme])())
                
      })
  observe({
    
    updatePickerInput(session,"data_in",
                      "Dataset",
                      choices = datasets(),
                      selected = NULL)
    
    updatePickerInput(session,"x_val",
                      "X",
                      choices = names(in_data()),
                      selected = NULL)
    
    updatePickerInput(session,"y_val",
                      "Y",
                      choices = names(in_data()),
                      selected = NULL)
    updatePickerInput(session, "plot_theme", "theme",
                      choices = get_themes())
  }
    
  )
  
  output$data_plot <- renderPlot(
    ggplot(in_data(), 
           aes(.data[[req(input$x_val)]], 
                .data[[req(input$y_val)]]))+
      geom_point() +
      labs(x = req(input$x_val), y = req(input$y_val)) +
      get_theme()
  )
}

shinyApp(ui, server)

