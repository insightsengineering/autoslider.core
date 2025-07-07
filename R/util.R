format_xx <- function(str) {
  tern::format_xx(str)
}

#' Assert function to check the cutoff
#'
#' @param data dataframe
#' @param cutoff cutoff threshold
#' @return Set the cutoff value
#' @export
check_and_set_cutoff <- function(data, cutoff) {
  if (is.na(cutoff)) {
    cutoff <- 0
  } else { # check cutoff is the same with the filter
    suffix <- attr(data, "filters")
    cutoff_suffix <- str_extract(string = paste(suffix, collapse = "_"), pattern = "(\\d+)(?=PER)") %>%
      as.numeric()
    if (!is.na(cutoff_suffix)) {
      assert_that(are_equal(cutoff, cutoff_suffix))
    }
  }

  cutoff
}

#' Replace NAs to NA
#'
#' @param table_df Table dataframe
#' @return Input dataframe with both column replaced to NA
#' @export
na_replace <- function(table_df) {
  if (length(colnames(table_df)) == 2) {
    col1_na <- which(is.na(table_df[1]))
    if (length(col1_na) > 0) {
      for (i in 1:length(col1_na)) {
        table_df[col1_na[i], 1] <- table_df[col1_na[i], 2]
        table_df[col1_na[i], 2] <- NA
      }
    }
  }

  table_df
}

#' Concatenate arguments into a string
#'
#' @param ... arguments passed to program
#' @return No return value, called for side effects
#' @export
dec_paste <- function(...) {
  arguments <- list(
    ...
  )

  if (!any(is.na(arguments))) {
    do.call("paste", arguments)
  }
}

#' Convert list of numbers to vectors
#'
#' @param num_list list of numbers
#' @return No return value, called for side effects
#' @export
to_vector <- function(num_list) {
  sapply(num_list, function(x) {
    y <- unlist(x)
    if (is.null(y)) {
      y <- NA
    }
    y
  })
}

#' Founding method
#' @param x number need to be rounded
#' @param digits number of digits
#' @return rounded value
#' @export
new_round <- function(x, digits = 1) {
  posneg <- sign(x)
  z <- abs(x) * 10^digits
  z <- z + 0.5 + sqrt(.Machine$double.eps)
  z <- trunc(z)
  z <- z / 10^digits
  z * posneg
}

#' Format of xx.xx (xx.xx)
#'
#' @param x input array
#' @param output output handle
#' @return formatted values
#' @export
trim_perc1 <- function(x, output) {
  paste0(x[1], " (", new_round(x[2] * 100, 1), ")")
}

#' Format of xx.xx (xx.x)
#'
#' @param x input array
#' @param output output handle
#' @return formatted values
#' @export
trim_perc <- function(x, output) {
  paste0(x[1], " (", new_round(x[2] * 100, 2), ")")
}

#' Format of (xx\%, xx\%)
#'
#' @param x input array
#' @param output output handle
#' @return formatted values
#' @export
perc_perc <- function(x, output) {
  paste0(new_round(x[1] * 100, 0), "% (", new_round(x[2] * 100, 0), "%)")
}

#' Format of xx.xx (xx.xx, xx.xx)
#'
#' @param x input array
#' @param output output handle
#' @return formatted values
#' @export
format_3d <- function(x, output) {
  paste0(new_round(x[1], 2), " (", new_round(x[2], 2), ", ", new_round(x[3], 2), ")")
}


#' survival time afun
#'
#' @param df data
#' @param .var variable of interest
#' @param is_event vector indicating event
#' @param control `control_surv_time()` by default
#' @return A function suitable for use in rtables::analyze() with element selection,
#' reformatting, and relabeling performed automatically.
#' @export
s_surv_time_1 <- function(df, .var, is_event, control = control_surv_time()) {
  # assert_that(is_df_with_variables(df, list(tte = .var, is_event = is_event)),
  #            is.string(.var), is_numeric_vector(df[[.var]]), is_logical_vector(df[[is_event]]))

  conf_type <- control$conf_type
  conf_level <- control$conf_level
  quantiles <- control$quantiles
  formula <- as.formula(paste0(
    "Surv(", .var, ", ", is_event,
    ") ~ 1"
  ))
  srv_fit <- survfit(
    formula = formula, data = df, conf.int = conf_level,
    conf.type = conf_type
  )
  srv_tab <- summary(srv_fit, extend = TRUE)$table
  # srv_qt_tab <- quantile(srv_fit, probs = quantiles)$quantile
  # range_censor <- range_noinf(df[[.var]][!df[[is_event]]],
  #                            na.rm = TRUE)
  # range_event <- range_noinf(df[[.var]][df[[is_event]]], na.rm = TRUE)
  # range <- range_noinf(df[[.var]], na.rm = TRUE)
  new_label <- paste0("Median (Months, ", conf_level * 100, "% CI)")

  list(
    median_ci = formatters::with_label(c(
      unname(srv_tab["median"]),
      unname(srv_tab[paste0(srv_fit$conf.int, c("LCL", "UCL"))])
    ), new_label)
  )
}


s_coxph_pairwise_1 <- function(df, .ref_group, .in_ref_col, .var, is_event, strat = NULL,
                               control = control_coxph()) {
  # assert_that(is_df_with_variables(df, list(tte = .var, is_event = is_event)),
  #             is.string(.var), is_numeric_vector(df[[.var]]), is_logical_vector(df[[is_event]]))
  pval_method <- control$pval_method
  ties <- control$ties
  conf_level <- control$conf_level

  strat_type <- ifelse(is.null(strat), "Unstratified", "Stratified")
  if (.in_ref_col) {
    return(
      in_rows(
        rcell(""),
        rcell(""),
        .labels = c(paste0(strat_type, " HR (", conf_level * 100, "% CI)"), paste0("p-value (", pval_method, ")"))
      )
      # list(hr_ci = formatters::with_label("", paste0("Stratified HR (", conf_level*100, "% CI)")),
      #      pvalue = formatters::with_label("", paste0("p-value (", pval_method, ")"))
      #      )
    )
  }
  data <- rbind(.ref_group, df)
  group <- factor(rep(c("ref", "x"), c(nrow(.ref_group), nrow(df))),
    levels = c("ref", "x")
  )
  df_cox <- data.frame(
    tte = data[[.var]], is_event = data[[is_event]],
    arm = group
  )
  if (is.null(strat)) {
    formula_cox <- Surv(tte, is_event) ~ arm
  } else {
    formula_cox <- as.formula(paste0(
      "Surv(tte, is_event) ~ arm + strata(",
      paste(strat, collapse = ","), ")"
    ))
    df_cox <- cbind(df_cox, data[strat])
  }
  cox_fit <- coxph(formula = formula_cox, data = df_cox, ties = ties)
  sum_cox <- summary(cox_fit, conf.int = conf_level, extend = TRUE)
  pval <- switch(pval_method,
    wald = sum_cox$waldtest["pvalue"],
    `log-rank` = sum_cox$sctest["pvalue"],
    likelihood = sum_cox$logtest["pvalue"]
  )
  list(
    # hr = formatters::with_label(sum_cox$conf.int[1, 1], "Hazard Ratio"),
    # hr_ci = formatters::with_label(unname(sum_cox$conf.int[1, 3:4]), f_conf_level(conf_level)),
    hr_ci = formatters::with_label(
      c(sum_cox$conf.int[1, 1], unname(sum_cox$conf.int[1, 3:4])),
      paste0("Stratified HR (", conf_level * 100, "% CI)")
    ),
    pvalue = formatters::with_label(unname(pval), paste0("p-value (", pval_method, ")"))
  )

  in_rows(
    rcell(c(sum_cox$conf.int[1, 1], unname(sum_cox$conf.int[1, 3:4])), format = format_3d),
    rcell(unname(pval), format = "x.xxxx | (<0.0001)"),
    .labels = c(paste0("Stratified HR (", conf_level * 100, "% CI)"), paste0("p-value (", pval_method, ")"))
  )
}

is_in_repository <- function() {
  system("git status", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0
}

get_remote_url <- function() {
  repos <- system("git remote -v", intern = TRUE)
  str_extract(repos, "(https://|git@).*.git")
}

get_last_gitcommit_sha <- function() {
  system("git rev-parse HEAD", intern = TRUE)
}

get_repo_head_name <- function() {
  system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
}

warn <- function(...) {
  warning(..., call. = FALSE, immediate. = TRUE)
}

git_footnote <- function(for_test = FALSE) {
  if (is_in_repository()) {
    remote_url <- get_remote_url()[1]
    if (grepl("^https", remote_url)) {
      https_url <- gsub("\\.git$", "", remote_url)
    } else {
      https_url <- gsub("^git@", "https://", gsub(":", "/", remote_url))
    }

    repo <- paste("GitHub repository:", https_url)
    commit <- paste(
      "Git hash:",
      get_last_gitcommit_sha()
    )
    ret <- paste(repo, commit, sep = "\n")
  } else {
    ret <- NULL
  }

  if (for_test == TRUE) {
    ret <- NULL
  }

  ret
}

datetime <- function() {
  # eICE like format, e.g. 23SEP2020 12:40
  toupper(format(Sys.time(), "%d%b%Y %H:%M"))
}

enumerate <- function(x, quote = "`") {
  n <- length(x)
  if (n == 1L) {
    paste0(quote, x, quote)
  } else {
    paste(
      paste(paste0(quote, x[-n], quote), collapse = ", "),
      paste("and", paste0(quote, x[n], quote))
    )
  }
}

map_lgl <- function(x, f, ...) {
  vapply(x, f, logical(1L), ..., USE.NAMES = FALSE)
}

map_num <- function(x, f, ...) {
  vapply(x, f, numeric(1L), ..., USE.NAMES = FALSE)
}

map_chr <- function(x, f, ...) {
  vapply(x, f, character(1L), ..., USE.NAMES = FALSE)
}


on_master_branch <- function() {
  get_repo_head_name() == "master"
}

create_new_reporting_event <- function(name) {
  dir.create(name)
  file.create(file.path(name, "metadata.yml"))
}

create_output_name <- function(program, suffix) {
  ifelse(is.na(suffix) | suffix == "", program, paste(program, suffix, sep = "_"))
}

default_paper_size <- function(program) {
  output_type <- substr(program, 1L, 1L)
  defaults <- c(l = "L8", t = "P8", g = "L11")
  if (output_type %in% names(defaults)) {
    unname(defaults[output_type])
  } else {
    "P8"
  }
}

vbar2newline <- function(x) {
  gsub("\\s*\\|\\s*", "\n", x)
}

munge_spaces <- function(text, wordboundary = "(\\t|\\n|\\x0b|\\x0c|\\r| )") {
  stringr::str_replace_all(text, wordboundary, " ")
}

# split_chunk <- function(text, whitespace = "[\\t\\n\\x0b\\x0c\\r\\ ]") {
#   wordsep_re <- sprintf("(%s+)", whitespace)
#   strsplit(text, split = wordsep_re, perl = TRUE)
# }
split_chunk <- function(text, whitespace = "\\s+") {
  # Split the string by one or more whitespace characters.
  chunks <- strsplit(text, split = whitespace, perl = TRUE)[[1]]
  # Remove any empty strings that result from leading/trailing whitespace.
  chunks[chunks != ""]
}

wrap_chunk <- function(chunks, width) {
  # This iterative version is more robust and easier to debug than a
  # recursive one, preventing potential stack overflow with very long text.
  if (length(chunks) == 0) {
    return(list())
  }

  lines <- list()
  current_line <- ""

  while (length(chunks) > 0) {
    word <- chunks[1]

    # Handle words that are longer than the total line width by breaking them up.
    if (nchar(word) > width) {
      # If there's content on the current line, bank it first.
      if (current_line != "") {
        lines <- append(lines, current_line)
      }
      # Add the first part of the long word as a new line.
      lines <- append(lines, substr(word, 1, width))
      # Put the remainder of the long word back at the front of the queue.
      chunks[1] <- substr(word, width + 1, nchar(word))
      current_line <- ""
      next
    }

    # Determine what the line would look like with the new word.
    potential_line <- if (current_line == "") word else paste(current_line, word, sep = " ")

    # If the new word fits, update the current line and remove the word from the queue.
    if (nchar(potential_line) <= width) {
      current_line <- potential_line
      chunks <- chunks[-1]
    } else {
      # If it doesn't fit, bank the current line and start a new one with the word.
      lines <- append(lines, current_line)
      current_line <- word
      chunks <- chunks[-1]
    }
  }

  # Add the last remaining line to the list.
  if (current_line != "") {
    lines <- append(lines, current_line)
  }

  return(lines)
}


text_wrap_cut <- function(text, width) {
  width <- as.integer(width)
  if (width <= 0) {
    return("")
  }
  munged_text <- munge_spaces(text)
  chunks <- split_chunk(munged_text)
  ret <- vapply(chunks, function(x) {
    s <- wrap_chunk(x, width = width)
    paste(unlist(s), collapse = "\n")
  }, FUN.VALUE = "")

  ret
}

text_wrap_cut_keepreturn <- function(text, width) {
  if (is.na(width)) {
    width <- 0
  }
  texts <- strsplit(text, "\n")
  ret <- vapply(texts, function(x) {
    r <- text_wrap_cut(x, width)
    paste0(r, collapse = "\n")
  }, FUN.VALUE = "")

  ret
}

#' @noRd
fs <- function(paper) {
  fontsize <- as.integer(substr(paper, 2, nchar(paper)))
  orientation <- substr(paper, 1, 1)
  list(fontsize = fontsize, orientation = orientation)
}

validate_paper_size <- function(paper) {
  assert_is_character_scalar(paper)
  if (!grepl("^[P|L][1-9][0-9]{0,1}$", paper)) {
    abort(
      "Page size must be starting with `L` or `P` to indicate the orientation of the page, ",
      "followed by an integer to indicate the fontsize"
    )
  }
  fontsize <- as.integer(substr(paper, 2, nchar(paper)))
  if (fontsize > 14) {
    abort("Fontsize should be less or equal than 14")
  }
}

get_output_file_ext <- function(output, file_path) {
  ret <- ""
  if (tools::file_ext(file_path) != "") {
    ret <- file_path
  } else {
    file_ext <- ifelse(is_rtable(output) || "dVTableTree" %in% class(output), "out", "pdf")
    ret <- sprintf("%s.%s", file_path, file_ext)
  }

  ret
}

# make config global so that test-util recognizes it
.autoslider_config <- new.env(parent = emptyenv())

warn_about_legacy_filtering <- function(output) {
  if (.autoslider_config$filter_warning_issued) {
    return(invisible())
  } else {
    .autoslider_config$filter_warning_issued <- TRUE
  }

  msg <- sprintf(
    paste(
      "Filtering based upon a character scalar is deprecated.",
      "Please use `output == '%s'` instead."
    ),
    output
  )
  warn(msg)
}

warn_about_legacy_paper_size <- function(old_paper_size,
                                         new_paper_size) {
  if (.autoslider_config$paper_size_warning_issued[old_paper_size]) {
    return(invisible())
  } else {
    .autoslider_config$paper_size_warning_issued[old_paper_size] <- TRUE
  }

  msg <- sprintf(
    "Paper size '%s' is deprecated. Please use '%s' instead.",
    old_paper_size,
    new_paper_size
  )
  warn(msg)
}



#' Build side by side layout by cbind
#'
#' @param lyt layout object
#' @param anl analysis data object
#' @param side_by_side A logical value indicating whether to display the data side by side.
#' @return An `rtables` layout
#' @export
lyt_to_side_by_side <- function(lyt, anl, side_by_side = NULL) {
  result <- build_table(lyt = lyt, df = anl)

  if (!is.null(side_by_side)) {
    if (grepl("Asia", side_by_side)) {
      tmp_anl <- anl %>% filter(COUNTRY %in% c("CHN", "HKG", "TWN", "KOR", "SGP", "THA", "MYS"))
      tmp_anl$lvl <- "Asia"
      result <- cbind_rtables(
        result,
        build_table(
          lyt = lyt,
          df = tmp_anl
        )
      )
    }

    if (grepl("China", side_by_side)) {
      tmp_anl <- anl %>% filter(COUNTRY == "CHN")
      tmp_anl$lvl <- "China"
      result <- cbind_rtables(result, build_table(lyt = lyt, df = tmp_anl))
    }
  }
  return(result)
}

#' Build side by side layout by cbind
#' @param lyt layout object
#' @param anl analysis data object
#' @param side_by_side A logical value indicating whether to display the data side by side.
#' @param alt_counts_df alternative data frame for counts
#' @return An `rtables` layout
#' @export
lyt_to_side_by_side_two_data <- function(lyt, anl, alt_counts_df, side_by_side = NULL) {
  result <- build_table(lyt = lyt, df = anl, alt_counts_df = alt_counts_df)

  if (!is.null(side_by_side)) {
    if (grepl("Asia", side_by_side)) {
      countries <- c("CHN", "HKG", "TWN", "KOR", "SGP", "THA", "MYS")
      tmp_anl <- anl %>% filter(COUNTRY %in% countries)
      tmp_anl$lvl <- "Asia"
      tmp_alt <- alt_counts_df %>% filter(COUNTRY %in% countries)
      tmp_alt$lvl <- "Asia"

      result <- cbind_rtables(
        result,
        build_table(
          lyt = lyt,
          df = tmp_anl,
          alt_counts_df = tmp_alt
        )
      )
    }

    if (grepl("China", side_by_side)) {
      tmp_anl <- anl %>% filter(COUNTRY == "CHN")
      tmp_anl$lvl <- "China"
      tmp_alt <- alt_counts_df %>% filter(COUNTRY == "CHN")
      tmp_alt$lvl <- "China"
      result <- cbind_rtables(result, build_table(
        lyt = lyt, df = tmp_anl,
        alt_counts_df = tmp_alt
      ))
    }
  }
  return(result)
}


do_call <- function(fun, ...) {
  args <- list(...)
  do.call(fun, args[intersect(names(args), formalArgs(fun))])
}


#' Build table header, a utility function to help with construct structured header for table layout
#' @param anl analysis data object
#' @param arm Arm variable for column split
#' @param split_by_study, if true, construct structured header with the study ID
#' @param side_by_side A logical value indicating whether to display the data side by side.
#' @return A `rtables` layout with desired header.
#' @export
build_table_header <- function(anl,
                               arm,
                               split_by_study,
                               side_by_side) {
  lyt <- basic_table()
  if (is.null(side_by_side)) {
    if (split_by_study) {
      assert_that(length(unique(anl$STUDYID)) > 1)
      lyt <- lyt %>%
        split_cols_by(var = "STUDYID") %>%
        split_cols_by(var = arm)
    } else {
      lyt <- lyt %>%
        split_cols_by(var = arm) %>%
        add_overall_col("All Patients")
    }
  } else {
    if (split_by_study) {
      warning("split_by_study argument will be ignored")
    }
    lyt <- lyt %>%
      split_cols_by(var = "lvl") %>%
      split_cols_by(var = arm) %>%
      add_overall_col("All Patients")
  }

  lyt
}


get_version_label_output <- function() {
  NULL
}


strip_NA <- function(input) {
  input[which(input != "NA")]
}
