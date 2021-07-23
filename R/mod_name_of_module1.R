#' name_of_module1 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_name_of_module1_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinydashboard::box(title = "Specification",
                        width = 3,
                        "Dummy text", htmltools::br(),
                        htmltools::br(),
                        shiny::radioButtons(ns("Select_sex"),
                                            label = "Select sex",
                                            choiceNames = c("Female", "Male"),
                                            choiceValues = c("F", "M"),
                                            selected = c("F")),
                        shiny::sliderInput(ns("Bins_size"),
                                           label = "Select size of bins",
                                           min = 1,
                                           max = 10,
                                           value = 1)),
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
    output$plot <- renderPlot({
      plot(iris)
    })
    
  })
}

## To be copied in the UI
# mod_name_of_module1_ui("name_of_module1_ui_1")

## To be copied in the server
# mod_name_of_module1_server("name_of_module1_ui_1")
