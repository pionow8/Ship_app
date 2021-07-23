#' name_of_module1 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 

utils::globalVariables(c("Ships_Final"))

mod_name_of_module1_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinydashboard::box(title = "Specification",
                        width = 3,
                        "Dummy text", htmltools::br(),
                        htmltools::br(),
                        shiny::selectInput(ns("Select_ship_type"),
                                           label = "Select ship type",
                                           choices = unique(Ships_Final$ship_type),
                                           selected = c("Tanker")),
                        shiny::selectInput(ns("Select_ship_name"),
                                           label = "Select ship name",
                                           choices = unique(Ships_Final$SHIPNAME),
                                           selected = c("PALLAS GLORY"))),
    shinydashboard::box(title = "Histogram",
                        width = 9,
                        plotOutput(ns("plot"))
    )
  )
}

#' name_of_module1 Server Functions
#'
#' @noRd 
mod_name_of_module1_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # observeEvent(input$Select_ship_type, 
    #              {updateSliderInput(session = session, inputId = "Select_ship_name", 
    #                                 value = Ships_Final[ship_type == input$Select_ship_type]$SHIPNAME)
    # })
    output$plot <- renderPlot({
      plot(iris)
    })
    
  })
}

## To be copied in the UI
# mod_name_of_module1_ui("name_of_module1_ui_1")

## To be copied in the server
# mod_name_of_module1_server("name_of_module1_ui_1")
