#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList

utils::globalVariables(c("Ships_Final", "SHIPNAME", "ship_type"))

mod_map_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinydashboard::box(title = "Specification",
                        width = 2,
                        paste0("The app is showing longest distance between two",
                               " consecutive observations for selected ship by type and name."),
                        htmltools::br(),
                        paste0("The line between the points is indicative and auxiliary.",
                               " It is not presenting the actual route traveled."),
                        htmltools::br(),
                        htmltools::br(),
                        shiny::selectInput(ns("Select_ship_type"),
                                           label = "Select ship type",
                                           choices = sort(unique(Ships_Final$ship_type)),
                                           selected = c("Passenger")),
                        shiny::selectizeInput(ns("Select_ship_name"),
                                              label = "Select ship name",
                                              choices = NULL)),
    shinydashboard::box(title = "Map",
                        width = 10,
                        leafletOutput(ns("mymap"), height = 800)
    )
  )
}


#' map Server Functions
#'
#' @noRd
mod_map_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    observe({
      names <- Ships_Final[ship_type == input$Select_ship_type]$SHIPNAME
      updateSelectizeInput(session = session, inputId = "Select_ship_name",
                           choices = sort(names),
                           selected = c("AGAT", "ENSKAR", "MINERVA",
                                        "KAPER-2 SG-312", "RIVO", "BY GD",
                                        "ZAWISZA CZARNY", "INDIAN POINT",
                                        "AKADEMIK KARPINSKIY", "BARSWEEP ONE"))
    })
    
    data_to_map <- reactive({
      Ships_Final <- Ships_Final[SHIPNAME == input$Select_ship_name]
    })
    
    output$mymap <- renderLeaflet({
      leaflet(data_to_map()) %>%
        addTiles() %>%
        addMarkers(lng = ~LON, lat = ~LAT,
                   popup = paste0("<b>Ship name: </b>", input$Select_ship_name,  "<br>",
                                  "<b>Longitude: </b>", round(data_to_map()$LON, 2), "<br>",
                                  "<b>Latitude: </b>", round(data_to_map()$LAT, 2), "<br>",
                                  "<b>Distance: </b>", round(data_to_map()$DISTANCE, 2), " m")) %>%
        addMarkers(lng = ~LON0, lat = ~LAT0,
                   popup = paste0("<b>Ship name: </b>", input$Select_ship_name,  "<br>",
                                  "<b>Longitude: </b>", round(data_to_map()$LON0, 2), "<br>",
                                  "<b>Latitude: </b>", round(data_to_map()$LAT0, 2), "<br>",
                                  "<b>Distance: </b>", round(data_to_map()$DISTANCE, 2), " m")) %>%
        addPolylines(lng = c(data_to_map()$LON, data_to_map()$LON0),
                     lat = c(data_to_map()$LAT, data_to_map()$LAT0))
    })
  })
}

## To be copied in the UI
# mod_map_ui("map_ui_1")

## To be copied in the server
# mod_map_server("map_ui_1")
