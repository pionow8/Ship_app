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
                        width = 2,
                        "Dummy text", htmltools::br(), htmltools::br(),
                        shiny::selectInput(ns("Select_ship_type"),
                                           label = "Select ship type",
                                           choices = sort(unique(Ships_Final$ship_type)),
                                           selected = c("Passenger")),
                        shiny::selectizeInput(ns("Select_ship_name"),
                                              label = "Select ship name",
                                              choices = NULL)),
    shinydashboard::box(title = "Map",
                        width = 10,
                        leafletOutput(ns("mymap"), height= 800)
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
                           choices = sort(names), selected = "AGAT")
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
        addMarkers(lng = ~LON, lat = ~LAT, 
                   popup = paste0("<b>Ship name: </b>", input$Select_ship_name,  "<br>",
                                  "<b>Longitude: </b>", round(datatoPlot()$LON, 2), "<br>",
                                  "<b>Latitude: </b>", round(datatoPlot()$LAT, 2), "<br>",
                                  "<b>Distance: </b>", round(datatoPlot()$DISTANCE, 2)," m")) %>%
        addMarkers(lng = ~LON0, lat = ~LAT0, 
                   popup = paste0("<b>Ship name: </b>", input$Select_ship_name,  "<br>",
                                  "<b>Longitude: </b>", round(datatoPlot()$LON0, 2), "<br>",
                                  "<b>Latitude: </b>", round(datatoPlot()$LAT0, 2), "<br>",
                                  "<b>Distance: </b>", round(datatoPlot()$DISTANCE, 2)," m"))
    })
  })
}

## To be copied in the UI
# mod_name_of_module1_ui("name_of_module1_ui_1")

## To be copied in the server
# mod_name_of_module1_server("name_of_module1_ui_1")
