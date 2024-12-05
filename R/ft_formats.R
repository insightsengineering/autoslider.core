#' Table color and font
#'
#' @description Zebra themed color
#'
#' @name autoslider_format
NULL

#' @describeIn autoslider_format
#'
#' User defined color code and font size
#'
#' @param ft flextable object
#' @param odd_header Hex color code, default to deep sky blue
#' @param odd_body Hex color code, default to alice blue
#' @param even_header Hex color code, default to slate gray
#' @param even_body Hex color code, default to slate gray
#' @param font_name Font name, default to arial
#' @param body_font_size Font size of the table content, default to 12
#' @param header_font_size Font size of the table header, default to 14
#' @return A flextable with applied theme.
#' @export
autoslider_format <- function(ft,
                              odd_header = "#0EAED5", # "deepskyblue2",
                              odd_body = "#EBF5FA", # "aliceblue",
                              even_header = "#0EAED5", # "slategray1",
                              even_body = "#D0E4F2", # "slategray1" # slategray1,
                              font_name = "arial",
                              body_font_size = 12,
                              header_font_size = 14) {
  ft %>%
    theme_zebra(
      odd_header = odd_header,
      odd_body = odd_body,
      even_header = odd_header,
      even_body = even_body
    ) %>%
    font(fontname = font_name, part = "all") %>%
    fontsize(size = body_font_size, part = "body") %>%
    color(color = "white", part = "header") %>%
    fontsize(size = header_font_size, part = "header") %>%
    bold(part = "header")
}


#' @describeIn autoslider_format
#'
#' Blue color theme
#'
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
blue_format <- function(ft, ...) {
  ft %>% autoslider_format(
    odd_header = "#0B41CD",
    odd_body = "#1482FA",
    even_body = "#BDE3FF",
    ...
  )
}

#' @describeIn autoslider_format
#'
#' Orange color theme
#'
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
orange_format <- function(ft, ...) {
  ft %>% autoslider_format(
    odd_header = "#ED4A0D",
    odd_body = "#FF7D29",
    even_body = "#FFBD69",
    ...
  )
}

#' @describeIn autoslider_format
#'
#' Red color theme
#'
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
red_format <- function(ft, ...) {
  ft %>% autoslider_format(
    odd_header = "#C40000",
    odd_body = "#FF1F26",
    even_body = "#FF8782",
    ...
  )
}


#' @describeIn autoslider_format
#'
#' Purple color theme
#'
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
purple_format <- function(ft, ...) {
  ft %>% autoslider_format(
    odd_header = "#BC36F0",
    odd_body = "#E085FC",
    even_body = "#F2D4FF",
    ...
  )
}

#' @describeIn autoslider_format
#'
#' `AutoslideR` dose formats
#'
#' @param ft flextable object
#' @param header_vals Header
#'
#' @export
autoslider_dose_format <- function(ft, header_vals = names(ft)) {
  ft %>%
    theme_booktabs() %>%
    delete_rows(i = 1, part = "header") %>%
    add_header_row(top = TRUE, values = header_vals, colwidths = rep.int(1, length(header_vals))) %>%
    bold(part = "header") %>%
    border_remove()
}
