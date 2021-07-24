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
                        "Dummy text", htmltools::br(), htmltools::br(),
                        shiny::selectInput(ns("Select_ship_type"),
                                           label = "Select ship type",
                                           choices = sort(unique(Ships_Final$ship_type)),
                                           selected = c("Cargo")),
                        shiny::selectizeInput(ns("Select_ship_name"),
                                              label = "Select ship name",
                                              choices = sort(unique(Ships_Final$SHIPNAME)),
                                              selected = c("AALDERDIJK"))),
    shinydashboard::box(title = "Histogram",
                        width = 1,
                        textOutput(ns("selected_var"))),
    shinydashboard::box(title = "Histogram2",
                        width = 7,
                        leafletOutput(ns("mymap"))
    )
  )
}

#' name_of_module1 Server Functions
#'
#' @noRd 
mod_name_of_module1_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    observe({
      ## should be changed to data.table
      names <- subset(Ships_Final, ship_type == input$Select_ship_type)
      names <- unique(names$SHIPNAME)
      updateSelectizeInput(session = session, inputId = "Select_ship_name",
                           choices = sort(names))
    })
    
    datatoPlot <- reactive({
      Ships_Final <- Ships_Final[SHIPNAME == input$Select_ship_name]
    })
    
    output$selected_var <- renderText({ 
      paste("You have selected", datatoPlot()$SHIPNAME)
    })
    
    output$mymap <- renderLeaflet({
      leaflet(datatoPlot()) %>%
        addTiles() %>%
        addMarkers(lng = ~LON, lat = ~LAT)
    })
    
    output$plot <- renderPlot({
      plot(iris)
    })
    
  })
}

## To be copied in the UI
# mod_name_of_module1_ui("name_of_module1_ui_1")

## To be copied in the server
# mod_name_of_module1_server("name_of_module1_ui_1")
