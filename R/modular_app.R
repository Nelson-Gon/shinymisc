#' File Upload UI 
#' @param id A unique label for the module
#' @param label A label to show on the file input panel. 
#' @return A sharable file upload module 
#' @examples 
#' \dontrun{
#' fileUploadUI(id = "my_file_upload" , label = "Input File")
#' }
#' @export

fileUploadUI <- function(id, label = "File") {
  ns <- NS(id)
  tagList(
  shiny::fileInput(
    ns("file"),
    label = label
  )
  )
}

#' File Reader Uploader 
#' @param id A unique id for the file reader server 
#' @return A server module to read CSV files from fileUploadUI
#' @examples 
#' \dontrun{
#' ReadFileServer("my_reader_module")
#' }
#' @export
ReadFileServer <- function(id) {
  shiny::moduleServer(
    id,
    
    function(input, output, session){
      in_data <- reactive({
        read.csv(
          req(input$file$datapath)
        )
      })
      in_data
    }
  )
  
}


#' Run an example module based app 
#' @return Returns an example module based app. 
#' @examples 
#' \dontrun{
#' run_app("modular_app")
#' }
#' @export

modular_app <- function(){
  ui <- fluidPage(
    tabsetPanel(
      tabPanel("Example 1",
               
               verticalLayout(
                 fileUploadUI("input_file", "File"),
                 dataTableOutput("output_df")
               )
      ),
      tabPanel("Example 2",
               
               shiny::splitLayout(
                 fileUploadUI("input_file_1", "File"),
                 dataTableOutput("output_df_1"),
                 cellWidths = c("25%", "75%")
               )
      )
      
    )
  )
  server <- function(input, output, session){
    in_data <- ReadFileServer("input_file")
    output$output_df <- renderDataTable({
      in_data()
    })
    in_data_1 <- ReadFileServer("input_file_1")
    output$output_df_1 <- renderDataTable(
      in_data_1()
    )
  }
  shinyApp(ui, server)
}
