log_success_infomation <- function(success, failure) {
  total_number <- success + failure
  cat_bullet(
    "Total number of success ",
    success,
    "/",
    total_number,
    bullet = "tick",
    bullet_col = "green"
  )
  if (failure > 0) {
    cat_bullet(
      "Total number of failures ",
      failure,
      "/",
      total_number,
      bullet = "cross",
      bullet_col = "red"
    )
  }
}

log_number_of_matched_records <- function(original_spec,
                                          filtered_spec,
                                          condition) {
  if (length(filtered_spec)) {
    msg <- sprintf(
      "%d/%d outputs matched the filter condition `%s`.",
      length(filtered_spec),
      length(original_spec),
      deparse(condition)
    )
    cat_bullet(msg, bullet = "tick", bullet_col = "green")
  } else {
    msg <- sprintf(
      "No output matched the filter condition `%s`",
      deparse(condition)
    )
    cat_bullet(msg, bullet = "cross", bullet_col = "red")
  }
}
