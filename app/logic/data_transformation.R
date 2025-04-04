box::use(
  dplyr[arrange],
  rlang[.data],
  tidyr[pivot_wider],
)

#' @export
transform_data <- function(data) {
  pivot_wider(
    data = data,
    names_from = .data[["Species"]],
    values_from = .data[["Population"]]
  ) |>
    arrange("Year")
}
