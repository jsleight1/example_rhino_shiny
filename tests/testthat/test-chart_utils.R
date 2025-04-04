box::use(
  testthat[expect_no_error, expect_s3_class, expect_snapshot_output, local_edition, test_that],
)

box::use(
  ../../app/logic/chart_utils[label_formatter],
)

test_that("label_formatter works", {
  local_edition(3)
  out <- label_formatter |>
    expect_no_error()
  expect_s3_class(out, "JS_EVAL")
  expect_snapshot_output(out)
})
