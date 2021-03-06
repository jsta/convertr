

#' @title Explore conversion table
#'
#' @description A shiny application that lets you take a look at the
#' \code{\link{conversion_table}} dataframe.
#'
#'
#' @return
#' Launches a Shiny app
#' @export
#'
#' @examples
#' \dontrun{
#' explot_units()}
#'

explore_units <- function(){
  app <- shiny::shinyApp(
    ui = shiny::shinyUI(
      shiny::pageWithSidebar(
        shiny::headerPanel('Convertr Unit Explorer'),
        shiny::sidebarPanel(
          shiny::selectInput("base_unit",
                    "Base Unit",
                    c( "All",
                       unique(conversion_table$base_unit)),
                    selected = "1/a")
      ),

      shiny::mainPanel(
        DT::dataTableOutput("conversion")
      )
    )),
    server = shiny::shinyServer(function(input, output) {

      output$conversion <- DT::renderDataTable({
        df <- conversion_table
        if( input$base_unit != "All" ){
          df <- df[ df$base_unit == input$base_unit, ]
        }
        df
      })
    })
  )
  shiny::runApp(app)
}
