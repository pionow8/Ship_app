#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import data.table
#' @import leaflet
#' @import htmltools
#' @noRd
app_ui <- function(request) {
  tagList(
    
    # Your application UI logic 
    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(title = "Ship application"),
      shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(
          shinydashboard::menuItem(
            text = "Map", tabName = "ShipMap",
            icon = icon("globe-europe")
          )
        ),
        disable = TRUE),
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem(tabName = "ShipMap",
                                  shiny::fluidRow(
                                    shiny::column(
                                      width = 12,
                                      mod_map_ui("map_ui_1")
                                    )
                                  ))
        )
      )
    )
  )
}

