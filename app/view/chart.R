box::use(
  echarts4r,
  shiny[div, moduleServer, NS],
)

box::use(
  app/logic/chart_utils[label_formatter],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  div(
    class = "component-box",
    echarts4r$echarts4rOutput(ns("chart"))
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    output$chart <- echarts4r$renderEcharts4r(
      data |>
        echarts4r$group_by(Species) |>
        echarts4r$e_chart(x = Year) |>
        echarts4r$e_line(Population) |>
        echarts4r$e_x_axis(
          Year,
          axisLabel = list(
            formatter = label_formatter
          )
        ) |>
        echarts4r$e_tooltip()
    )
  })
}
