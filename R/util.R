format_xx <- function(str) {
  tern::format_xx(str)
}

#' Assert function to check the cutoff
#'
#' @param data dataframe
#' @param cutoff cutoff threshold
#'
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
  return(cutoff)
}

#' Replace NAs to NA
#'
#' @param table_df Table dataframe
#'
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
  return(table_df)
}

#' Concatenate arguments into a string
#'
#' @param ... arguments passed to program
#'
#' @export
dec_paste <- function(...) {
  arguments <- list(
    ...
  )

  if (any(is.na(arguments))) {
    return(NA)
  } else {
    do.call("paste", arguments)
  }
}

#' Convert list of numbers to vectors
#'
#' @param num_list list of numbers
#'
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
#'
#' @export
trim_perc1 <- function(x, output) {
  paste0(x[1], " (", new_round(x[2] * 100, 1), ")")
}

#' Format of xx.xx (xx.x)
#'
#' @param x input array
#' @param output output handle
#'
#' @export
trim_perc <- function(x, output) {
  paste0(x[1], " (", new_round(x[2] * 100, 2), ")")
}

#' Format of (xx\%, xx\%)
#'
#' @param x input array
#' @param output output handle
#'
#' @export
perc_perc <- function(x, output) {
  paste0(round(x[1] * 100, 1), "% (", round(x[2] * 100, 1), "%)")
}

#' Format of xx.xx (xx.xx, xx.xx)
#'
#' @param x input array
#' @param output output handle
#'
#' @export
format_3d <- function(x, output) {
  paste0(round(x[1], 2), " (", round(x[2], 2), ", ", round(x[3], 2), ")")
}


#' survival time afun
#'
#' @param df data
#' @param .var variable of interest
#' @param is_event vector indicating event
#' @param control `control_surv_time()` by default
#'
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
    median_ci = with_label(c(
      unname(srv_tab["median"]),
      unname(srv_tab[paste0(srv_fit$conf.int, c("LCL", "UCL"))])
    ), new_label)
  )
}

#' survival proportion afun
#'
#' @param x data vector
#' @param conf_level confidence level
#' @param method type of method for calculation
#' @param long flag
#'
#' @export
s_proportion_1 <- function(x, conf_level = 0.95,
                           method = c(
                             "waldcc", "wald", "clopper-pearson",
                             "wilson", "agresti-coull", "jeffreys"
                           ),
                           long = FALSE) {
  x <- as.logical(x)
  method <- match.arg(method)
  # assert_that(conf_level >= 0, conf_level <= 1, is.flag(long))
  rsp <- x
  n <- sum(rsp)
  p_hat <- mean(rsp)
  prop_ci <- switch(method,
    `clopper-pearson` = prop_clopper_pearson(rsp, conf_level),
    wilson = prop_wilson(rsp, conf_level),
    wald = prop_wald(rsp, conf_level),
    waldcc = prop_wald(rsp, conf_level, correct = TRUE),
    `agresti-coull` = prop_agresti_coull(rsp, conf_level),
    jeffreys = prop_jeffreys(rsp, conf_level)
  )
  y <- prop.test(sum(rsp), length(rsp), correct = TRUE, conf.level = conf_level)
  prop_ci <- as.numeric(y$conf.int)

  new_label <- paste0(
    "ORR (%, ",
    tern::d_proportion(conf_level, method, long = FALSE),
    ")"
  )

  # rcell(c(p_hat, prop_ci), format = list(rsp_ci_format))
  # prop_ci = with_label(c(p_hat * 100, prop_ci * 100), new_label)
  list(
    "n_prop" = formatters::with_label(c(n, p_hat), "ORR (%)"),
    "prop_ci" = formatters::with_label(
      x = 100 * prop_ci, label = d_proportion(conf_level, method, long = long)
    )
  )
  # return(prop_ci)
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
      # list(hr_ci = with_label("", paste0("Stratified HR (", conf_level*100, "% CI)")),
      #      pvalue = with_label("", paste0("p-value (", pval_method, ")"))
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
    # hr = with_label(sum_cox$conf.int[1, 1], "Hazard Ratio"),
    # hr_ci = with_label(unname(sum_cox$conf.int[1, 3:4]), f_conf_level(conf_level)),
    hr_ci = with_label(
      c(sum_cox$conf.int[1, 1], unname(sum_cox$conf.int[1, 3:4])),
      paste0("Stratified HR (", conf_level * 100, "% CI)")
    ),
    pvalue = with_label(unname(pval), paste0("p-value (", pval_method, ")"))
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
  return(str_extract(repos, "(https://|git@).*.git"))
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

split_chunk <- function(text, whitespace = "[\\t\\n\\x0b\\x0c\\r\\ ]") {
  wordsep_re <- sprintf("(%s+)", whitespace)
  strsplit(text, split = wordsep_re, perl = TRUE)
}

wrap_chunk <- function(chunks, width, wrapped_chunk = list(), current_line = "", width_left = width) {
  if (length(chunks) == 0) {
    return(append(wrapped_chunk, current_line))
  }
  next_chunk <- chunks[1]
  next_width <- nchar(next_chunk)
  if (width_left <= 0) {
    wrapped_chunk <- append(wrapped_chunk, current_line)
    return(wrap_chunk(chunks, width, wrapped_chunk, "", width))
  } else if (next_width <= width_left) {
    if (current_line == "") {
      current_line <- next_chunk
    } else {
      current_line <- paste(current_line, next_chunk)
    }
    return(wrap_chunk(chunks[-1], width, wrapped_chunk, current_line, width_left - next_width - 1))
  } else if (next_width > width) {
    next_chunk_sub <- substr(next_chunk, 1, width_left)
    if (current_line == "") {
      current_line <- next_chunk_sub
    } else {
      current_line <- paste(current_line, next_chunk_sub)
    }
    chunks[1] <- substr(next_chunk, width_left + 1, next_width)
    wrapped_chunk <- append(wrapped_chunk, current_line)
    return(wrap_chunk(chunks, width, wrapped_chunk, "", width))
  } else {
    wrapped_chunk <- append(wrapped_chunk, current_line)
    return(wrap_chunk(chunks, width, wrapped_chunk, "", width))
  }
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
  return(ret)
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
  return(ret)
}

#' @noRd
fs <- function(paper) {
  fontsize <- as.integer(substr(paper, 2, nchar(paper)))
  orientation <- substr(paper, 1, 1)
  return(list(fontsize = fontsize, orientation = orientation))
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
  if (tools::file_ext(file_path) != "") {
    return(file_path)
  } else {
    file_ext <- ifelse(is_rtable(output) || "dVTableTree" %in% class(output), "out", "pdf")
    return(sprintf("%s.%s", file_path, file_ext))
  }
}

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
#' @export
lyt_to_side_by_side <- function(lyt, anl, side_by_side = NULL) {
  result <- build_table(lyt = lyt, df = anl)

  if (!is.null(side_by_side)) {
    if (grepl("Asia", side_by_side)) {
      result <- cbind_rtables(
        result,
        build_table(
          lyt = lyt,
          df = anl %>% filter(COUNTRY %in% c("CHN", "HKG", "TWN", "KOR", "SGP", "THA", "MYS"))
        )
      )
    }

    if (grepl("China", side_by_side)) {
      result <- cbind_rtables(result, build_table(lyt = lyt, df = anl %>% filter(COUNTRY == "CHN")))
    }
  }
  return(result)
}

#' Build side by side layout by cbind
#' @param lyt layout object
#' @param anl analysis data object
#' @param side_by_side A logical value indicating whether to display the data side by side.
#' @param alt_counts_df alternative data frame for counts
#' @export
lyt_to_side_by_side_two_data <- function(lyt, anl, alt_counts_df, side_by_side = NULL) {
  result <- build_table(lyt = lyt, df = anl, alt_counts_df = alt_counts_df)

  if (!is.null(side_by_side)) {
    if (grepl("Asia", side_by_side)) {
      result <- cbind_rtables(
        result,
        build_table(
          lyt = lyt,
          df = anl %>% filter(COUNTRY %in% c("CHN", "HKG", "TWN", "KOR", "SGP", "THA", "MYS")),
          alt_counts_df = alt_counts_df %>% filter(COUNTRY %in% c("CHN", "HKG", "TWN", "KOR", "SGP", "THA", "MYS"))
        )
      )
    }

    if (grepl("China", side_by_side)) {
      result <- cbind_rtables(result, build_table(
        lyt = lyt, df = anl %>% filter(COUNTRY == "CHN"),
        alt_counts_df = alt_counts_df %>% filter(COUNTRY == "CHN")
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
        split_cols_by(var = arm, split_fun = add_overall_level("All Patients", first = FALSE)) %>%
        add_overall_col("All Patients")
    }
  } else {
    if (split_by_study) {
      warning("split_by_study argument will be ignored")
    }
    lyt <- lyt %>%
      split_cols_by(var = arm) %>%
      add_overall_col("All Patients")
  }
  return(lyt)
}


get_version_label_output <- function() {
  NULL
}
