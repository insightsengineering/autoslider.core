#' Refactor active arm
#'
#' @param df Input dataframe
#' @param arm_var Arm variable
#' @param levels factor levels
#' @param labels factor labels
#' @return Dataframe with re-level and re-labelled arm variable.
#' @export
mutate_actarm <- function(df,
                          arm_var = "TRT01A",
                          levels = c(
                            "PLACEBO + PACLITAXEL + CISPLATIN",
                            "ATEZOLIZUMAB + TIRAGOLUMAB + PACLITAXEL + CISPLATIN"
                          ),
                          labels = c("Pbo+Pbo+PC", "Tira+Atezo+PC")) {
  df %>%
    mutate_at(arm_var, ~ factor(explicit_na(sas_na(.)),
      levels = levels,
      labels = labels
    ))
}

#' Preprocess t_dd function
#'
#' @param df Input dataframe
#' @param levels factor levels
#' @param labels factor labels
#' @return dataframe
#' @export
preprocess_t_dd <- function(df,
                            levels = c("PROGRESSIVE DISEASE", "ADVERSE EVENT", "OTHER", "<Missing>"),
                            labels = c("Progressive Disease", "Adverse Events", "Other", "<Missing>")) {
  noNA(levels)
  noNA(labels)
  assert_that(length(levels) >= 3)
  assert_that(length(labels) >= 3)

  df %>%
    mutate(
      DTHCAT1 = DTHCAT == levels[1],
      DTHCAT2 = DTHCAT == levels[2],
      DTHCAT3 = DTHCAT == levels[3],
      DTHCAT = factor(explicit_na(sas_na(DTHCAT)), levels = levels, labels = labels)
    ) %>%
    formatters::var_relabel(
      DTHCAT1 = labels[1],
      DTHCAT2 = labels[2],
      DTHCAT3 = labels[3]
    )
}


#' Preprocess t_ds function
#'
#' @param df Input dataframe
#' @param levels factor levels
#' @param labels factor labels
#' @return dataframe
#' @export
preprocess_t_ds <- function(df,
                            levels = c("Alive: On Treatment", "Alive: In Follow-up", "<Missing>"),
                            labels = c("Alive: On Treatment", "Alive: In Follow-up", "<Missing>")) {
  assert_that(has_name(df, "DISTRTFL"),
    msg = "`DISTRTFL` variable is needed for deriving `STDONS` variable,
              suggest to use `DTRTxxFL` to create `DISTRTFL`."
  )
  noNA(levels)
  noNA(labels)
  assert_that(length(levels) >= 3)
  assert_that(length(labels) >= 3)

  data_adsl <- df %>%
    # Calculate STDONS
    mutate(STDONS = case_when(
      toupper(EOSSTT) == "ONGOING" & DTHFL == "" & DISTRTFL == "N" ~ "Alive: On Treatment",
      toupper(EOSSTT) == "ONGOING" & DISTRTFL == "Y" ~ "Alive: In Follow-up",
      TRUE ~ ""
    )) %>%
    # Process variable
    mutate(STDONS = factor(explicit_na(sas_na(STDONS)), levels = levels, labels = labels))
}
