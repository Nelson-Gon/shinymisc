#' Run another module based app 
#' @return Returns an example module based app. 
#' @examples 
#' \dontrun{
#' run_app("more_modules")
#' }
#' @export

more_modules <- function(){
  
  datasetChooserUI <- function(id){
    ns <- NS(id)
    tagList(
      
      sidebarLayout(
        sidebarPanel(
          width = 3,
          
          div(id = ns("sample_input"),
              wellPanel(
                selectizeInput(
                  inputId = ns("data_choice"),
                  label = "Choose Dataset",
                  choices = Filter(function(x) is.data.frame(get(x)), 
                                   ls("package:datasets"))
                ),
                fluidRow(
                  column(6,
                         selectizeInput(
                           inputId = ns("specific_x"),
                           label = "X",
                           choices = NULL
                         )
                  ),
                  column(6,
                         selectizeInput(
                           inputId = ns("specific_y"),
                           label = "Y",
                           choices = NULL
                         )
                  )
                )
                
                
              )
              
          )
        ),
        
        mainPanel(
          width = 9,
          
          
          div(id = ns("sample_output"),
              
              plotlyOutput(outputId = ns("simple_scatter"))
          )
          
          
        )
      )
      
    )
  }
  
  
  datasetChooserServer <- function(id){
    
    moduleServer(
      id,
      function(input, output, session){
        
        in_df <- reactive({
          
          get(req(input$data_choice), envir = as.environment("package:datasets")) 
        }
        
        )
        
        observe({
          
          updateSelectizeInput(
            session = session,
            inputId = "specific_x",
            choices = names(Filter(is.numeric,in_df()))
          )
          
          updateSelectizeInput(
            session = session,
            inputId = "specific_y",
            choices = names(Filter(is.numeric,in_df()))
          )
          
        }
        )
        
        x_y <- reactive({
          p<-ggplot(req(in_df()),
                    
                    aes(.data[[req(input$specific_x)]], 
                        .data[[req(input$specific_y)]]))+
            geom_point() +
            labs(x = req(input$specific_x), y = req(input$specific_y))+
            theme_minimal()
          plotly::ggplotly(p) %>% 
            plotly::layout(
              hoverlabel = list(bgcolor = "white"
                                
              ),
              font = list(size = 22,
                          family = "Times New Roman",
                          face = "bold",
                          color = "black"
              )
            )
        })
        
        output$simple_scatter <- renderPlotly(
          x_y()
        )
        
        
        
        
      }
    )
  }
  
  
  ui <- fluidPage(
    tabsetPanel(
      tabPanel(
        "Tab 1",
        
        datasetChooserUI("plot_1")
      ),
      
      tabPanel(
        "Tab 2",
        datasetChooserUI("plot_2")
      )
    )
  )
  
  server <- function(input, output, session){
    datasetChooserServer("plot_1")
    datasetChooserServer("plot_2")
  }
  
  shinyApp(ui, server) 
}

