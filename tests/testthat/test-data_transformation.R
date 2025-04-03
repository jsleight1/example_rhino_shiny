box::use(
  testthat[expect_no_error, expect_s3_class, expect_snapshot_output, local_edition, test_that],
)

box::use(
  ../../app/logic/data_transformation[transform_data],
)

data("rhinos", package = "rhino", envir = environment())

test_that("transform data works", {
  # TODO we should be able to set this globally somehow?
  local_edition(3)
  res <- rhinos |>
    transform_data() |>
    expect_no_error()
  expect_s3_class(res, "tbl_df")
  expect_snapshot_output(as.data.frame(res))
})
