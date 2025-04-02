box::use(
  rhino[app],
  shiny[shinyApp],
  shinytest2[AppDriver],
  testthat[skip_on_cran, test_that],
)

test_that("App values works", {
  skip_on_cran()

  setwd("../..")
  shiny_app <- app()
  x <- AppDriver$new(
    shiny_app,
    name = "initial",
    width = 800,
    height = 700,
    seed = 4323
  )

  x$expect_values()
  x$expect_unique_names()
  x$stop()
})
