# app/main.R
box::use(
  htmltools[tags],
  rhino[rhinos],
  shiny[bootstrapPage, div, h1, icon, moduleServer, NS],
)

box::use(
  app/view/chart,
  app/view/table,
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  bootstrapPage(
    h1("RhinoApplication"),
    div(
      class = "components-container",
      table$ui(ns("table")),
      chart$ui(ns("chart"))
    ),
    div (
      class = "help",
      tags$button(
        id = "help-button",
        icon("question"),
        onclick = "App.showHelp()"
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- rhinos

    table$server("table", data = data)
    chart$server("chart", data = data)
  })
}
