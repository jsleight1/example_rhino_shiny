box::use(
  rhino[rhinos],
  testthat[...],
)
box::use(
    app/logic/data_transformation[transform_data]
)

test_that("transform data works", {
    # TODO we should be able to set this globally somehow?
    local_edition(3)
    res <- rhinos |>
        transform_data() |>
        expect_no_error()
    expect_s3_class(res, "tbl_df")
    expect_snapshot_output(res)
})