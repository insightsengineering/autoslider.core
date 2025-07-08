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
autoslider_dose_format <- function(ft, header_vals = names(ft$body$dataset)) {
  # The original implementation used delete_rows and add_header_row, which can be
  # brittle. Using set_header_labels is the idiomatic and more robust way
  # to simply change the text of the header row. This avoids the colwidths error.
  ft %>%
    theme_booktabs() %>%
    set_header_labels(values = header_vals) %>%
    bold(part = "header") %>%
    border_remove()
}

#' @describeIn autoslider_format
#'
#' Black color theme for AE listing
#' @author Nina Qi and Jasmina Uzunovic
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
black_format_ae <- function(ft, body_font_size = 8, header_font_size = 8, ...) {
  ft <- do_call(autoslider_dose_format, ft = ft, ...)
  ft %>%
    fontsize(size = body_font_size, part = "body") %>%
    fontsize(size = header_font_size, part = "header") %>%
    color(color = "blue", part = "header") %>%
    border_inner_h(part = "all", border = fp_border(color = "black")) %>%
    hline_top(part = "all", border = fp_border(color = "black", width = 2)) %>%
    hline_bottom(part = "all", border = fp_border(color = "black", width = 2)) %>%
    bg(i = ~ as.character(`Max\nGrade`) == "1", j = 6, bg = "lightskyblue1") %>%
    bg(i = ~ as.character(`Max\nGrade`) == "2", j = 6, bg = "steelblue1") %>%
    bg(i = ~ as.character(`Max\nGrade`) == "3", j = 6, bg = "lightsalmon") %>%
    bg(i = ~ as.character(`Max\nGrade`) == "4", j = 6, bg = "tomato") %>%
    bg(i = ~ as.character(`Max\nGrade`) == "5", j = 6, bg = "darkgrey") %>%
    bg(i = ~ `IMP1\nRelated?` == "Y", j = 7, bg = "lightsalmon") %>%
    bg(i = ~ `IMP2\nRelated?` == "Y", j = 8, bg = "lightsalmon") %>%
    bg(i = ~ grepl("INTERRUPT|REDUC|WITHDRAW", `IMP1\nAction\nTaken?`), j = 9, bg = "lightsalmon") %>%
    bg(i = ~ grepl("INTERRUPT|REDUC|WITHDRAW", `IMP2\nAction\nTaken?`), j = 10, bg = "lightsalmon")
}

#' @describeIn autoslider_format
#'
#' Black color theme
#' @author Nina Qi and Jasmina Uzunovic
#' @param ft flextable object
#' @param ... arguments passed to program
#'
#' @export
black_format_tb <- function(ft, body_font_size = 8, header_font_size = 8, ...) {
  ft %>%
    theme_booktabs() %>%
    fontsize(size = body_font_size, part = "body") %>%
    fontsize(size = header_font_size, part = "header") %>%
    bold(part = "header") %>%
    color(color = "blue", part = "header") %>%
    border_inner_h(part = "all", border = fp_border(color = "black")) %>%
    hline_top(part = "all", border = fp_border(color = "black", width = 2)) %>%
    hline_bottom(part = "all", border = fp_border(color = "black", width = 2))
}
