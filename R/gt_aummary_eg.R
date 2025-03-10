my_gt_fun <- function(){
  trial |> tbl_summary(include = c(trt, age, grade))
}


