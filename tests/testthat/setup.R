# Extra libraries (suggested) for tests
library(dplyr)
library(assertthat)
library(rtables)
library(tern)
library(purrr)
require("ggplot2")
set.seed(12893)
# skip_if_too_deep
skip_if_too_deep <- function(depth) { # nolintr
  checkmate::assert_number(depth, lower = 0, upper = 5)

  testing_depth <- getOption("TESTING_DEPTH")
  if (is.null(testing_depth)) testing_depth <- Sys.getenv("TESTING_DEPTH")

  testing_depth <- tryCatch(
    as.numeric(testing_depth),
    error = function(error) 3,
    warning = function(warning) 3
  )

  if (length(testing_depth) != 1 || is.na(testing_depth)) testing_depth <- 3

  if (testing_depth < depth) {
    testthat::skip(paste("testing depth", testing_depth, "is below current testing specification", depth))
  }
}


expect_snapshot_ggplot <- function(title, fig, width = NA, height = NA) {
  testthat::skip_on_ci()
  testthat::skip_if_not_installed("svglite")

  name <- paste0(title, ".svg")
  path <- tempdir()
  withr::with_options(
    opts_partial_match_old,
    suppressMessages(ggplot2::ggsave(name, fig, path = path, width = width, height = height))
  )
  path <- file.path(path, name)

  testthat::announce_snapshot_file(name = name)
  testthat::expect_snapshot_file(path, name)
}

adsl <- eg_adsl %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination"))) %>%
  preprocess_t_dd() %>%
  mutate(DISTRTFL = sample(c("Y", "N"), size = length(TRT01A), replace = TRUE, prob = c(.1, .9))) %>%
  # preprocess_t_ds() %>%
  mutate(
    DTRFL = if_else(EOTSTT == "DISCONTINUED", "Y", "N"),
    TRTSDT = as.Date(TRTSDTM)
  )
adsl$FASFL <- adsl$SAFFL
adsl_two_arm <- adsl %>%
  dplyr::filter(TRT01A %in% c("A: Drug X", "B: Placebo")) %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))

adae <- eg_adae %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination")))
adae <- adae %>% mutate(
  dis_flags = ifelse(AEACN == "DRUG WITHDRAWN", TRUE, FALSE),
  red_flags = ifelse(AEACN == "DRUG REDUCED", TRUE, FALSE),
  int_flags = ifelse(AEACN == "DRUG INTERRUPTED", TRUE, FALSE),
  dis_flags = ifelse(AEACN == "DRUG WITHDRAWN", TRUE, FALSE),
  red_flags = ifelse(AEACN == "DRUG REDUCED", TRUE, FALSE),
  int_flags = ifelse(AEACN == "DRUG INTERRUPTED", TRUE, FALSE),
  ATOXGR = AETOXGR
)

# ADAE for AESEV grading
adae_aesev <- adae %>%
  mutate(AESEV = as.factor(case_when(
    AETOXGR %in% c("1", "2") ~ "MILD",
    AETOXGR == "3" ~ "MODERATE",
    AETOXGR %in% c("4", "5") ~ "SEVERE"
  )))

# ADAE with custom grouping
adae_custom <- adae %>%
  mutate(AEGRP = as.factor(case_when(
    AETOXGR %in% c("1", "2") ~ "Grade 1-2",
    AETOXGR %in% c("3", "4", "5") ~ "Grade 3-5"
  )))

# ADAE for ATOXGR grading
adae_atoxgr <- adae %>%
  mutate(ATOXGR = AETOXGR)

adae_two_arm <- adae %>%
  dplyr::filter(TRT01A %in% c("A: Drug X", "B: Placebo")) %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo")))

advs <- eg_advs %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination")))

adrs <- eg_adrs %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination"))) %>%
  dplyr::filter(PARAMCD == "INVET")

adtte <- eg_adtte %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination")))

adlb <- eg_adlb %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination")))

adeg <- eg_adeg %>%
  mutate(TRT01A = factor(TRT01A, levels = c("A: Drug X", "B: Placebo", "C: Combination")))

adex <- eg_adex
adex_tdosint <- adex %>%
  filter(PARAM == "Total dose administered") %>%
  mutate(
    AVAL = ASEQ / max(ASEQ) * 100,
    PARAMCD = "TDOSINT",
    PARAM = "Fake dose intensity"
  )
adex_tdurd <- adex %>%
  filter(PARAM == "Total dose administered") %>%
  mutate(
    AVAL = ASEQ,
    PARAMCD = "TDURD",
    PARAM = "Fake treatment duration"
  )
adex <- data.frame(Reduce("rbind", list(adex, adex_tdosint, adex_tdurd)))

testdata <- list(
  "adsl" = adsl,
  "adae" = adae,
  "adae_aesev" = adae_aesev,
  "adae_atoxgr" = adae_atoxgr,
  "adae_custom" = adae_custom,
  "adtte" = adtte,
  "adrs" = adrs,
  "advs" = advs,
  "adlb" = adlb,
  "adeg" = adeg,
  "adex" = adex
)

testdata_two_arm <- list(
  "adsl" = adsl_two_arm,
  "adae" = adae_two_arm
)


