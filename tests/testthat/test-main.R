
box::use(
    rhino[app],
    shinytest2[...],
    testthat[...],
)

shiny_app <- app()

test_that("LGBF app initial values works", {
    skip_on_cran()

    x <- AppDriver$new(shiny_app, name = "initial", width = 800, height = 700,
        seed = 4323)

    x$expect_values()
    x$expect_unique_names()
    x$stop()
})