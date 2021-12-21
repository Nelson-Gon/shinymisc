library(shiny)
ui <- fluidPage(
  navbarPage("Hello World",
             tabPanel("list_functions",
                      "All functions",
                      
                      textInput("pkg_name", "Package"),
                      textOutput("all_funs")
             ))
)
server <- function(session, input, output){
  my_funs <- reactive({
    if(!req(input$pkg_name) %in% loadedNamespaces()){
      do.call("library", list(req(input$pkg_name)))
    }
    lsf.str(paste0("package:",req(input$pkg_name)))
  })
  output$all_funs <- renderText(my_funs())
}


shinyApp(ui, server)
