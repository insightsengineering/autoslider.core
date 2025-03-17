my_gt_fun <- function() {
  trial |>
    select(trt, age, grade) |>
    tbl_summary(by = trt) |>
    add_p()
}
