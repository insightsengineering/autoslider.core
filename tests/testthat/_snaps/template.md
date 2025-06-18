# use_template test 2: saving when no path is specified

    Code
      use_template(template = "t_dm_slide", function_name = "tryout", open = FALSE)
    Message
      ✓ File './programs/R/tryout.R' has been created successfully

---

    Code
      use_template(template = "t_dm_slide", function_name = "tryout", overwrite = TRUE,
        open = FALSE)
    Message
      ✓ File './programs/R/tryout.R' has been created successfully

# use_template test 3: create folder when it does not exist

    Code
      use_template(template = "t_dm_slide", function_name = "folder_test", save_path = new_dir,
        open = FALSE)
    Message
      ✓ File 'random/folder_test.R' has been created successfully

      
# use_template test 5: create all templates 

    Code
      all_templates <- list_all_templates()
      for (template in all_templates){
    
        use_template(
          template = template, 
          function_name = paste0(template, "_test"),
          open = FALSE,
          overwrite = TRUE
        
        )
      }
      
    Message
      ✓ File './programs/R/g_eg_slide_test.R' has been created successfully
      ✓ File './programs/R/g_lb_slide_test.R' has been created successfully
      ✓ File './programs/R/g_mean_general_test.R' has been created successfully
      ✓ File './programs/R/g_vs_slide_test.R' has been created successfully
      ✓ File './programs/R/l_ae_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_pt_diff_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_pt_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_pt_soc_diff_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_pt_soc_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ae_summary_slide_test.R' has been created successfully
      ✓ File './programs/R/t_aesi_slide_test.R' has been created successfully
      ✓ File './programs/R/t_dm_slide_test.R' has been created successfully
      ✓ File './programs/R/t_dor_slide_test.R' has been created successfully
      ✓ File './programs/R/t_ds_slide_test.R' has been created successfully
      
    
    Output
      # ===== g_eg_slide_test.R =====
      
      g_eg_slide_test <- function(adsl, adeg, arm = "TRT01P", paramcd = "PARAM",
                             subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
        # tern 0.9.4 added facet_var in control_lineplot_vars
        variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd) %>% strip_NA()
        by_vars <- c("USUBJID", "STUDYID")
        assert_that(is.string(arm))
        assert_that(has_name(adeg, c(by_vars, variables) %>% unique()))
        assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))
        assert_that(is.string(subtitle))
        g_mean_general(
          adsl = adsl, data = adeg, variables = variables, by_vars = by_vars,
          subtitle = subtitle, ...
        )
      }
      
      
      # ===== g_lb_slide_test.R =====
      
      g_lb_slide_test <- function(adsl, adlb, arm = "TRT01P", paramcd = "PARAM", y = "AVAL",
                             subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
        # tern 0.9.4 added facet_var in control_lineplot_vars
        variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd, y = y) %>%
          strip_NA()
        by_vars <- c("USUBJID", "STUDYID")
        assert_that(is.string(arm))
        assert_that(is.string(paramcd))
        assert_that(is.string(y))
        assert_that(has_name(adlb, c(by_vars, variables) %>% unique()))
        assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))
        assert_that(is.string(subtitle))
        g_mean_general(
          adsl = adsl, data = adlb, variables = variables, by_vars = by_vars,
          subtitle = subtitle, ...
        )
      }
      
      
      # ===== g_mean_general_test.R =====
      
      g_mean_general_test <- function(adsl,
                                 data,
                                 variables = control_lineplot_vars(group_var = "TRT01P"),
                                 by_vars = c("USUBJID", "STUDYID"),
                                 subtitle = "Plot of Mean and 95% Confidence Limits by Visit.",
                                 ...) {
        assert_that(is.string(subtitle))
        variables <- variables %>% strip_NA() # tern 0.9.4 added facet_var in control_lineplot_vars
        assert_that(has_name(data, c(by_vars, variables)))
        assert_that(has_name(adsl, c(by_vars, variables["group_var"])))
        adsl_f <- adsl %>%
          df_explicit_na()
        data_f <- data %>%
          mutate(AVISIT = forcats::fct_reorder(AVISIT, AVISITN, min)) %>%
          dplyr::filter(
            AVISIT != "SCREENING"
          ) %>%
          droplevels() %>%
          df_explicit_na() %>%
          semi_join(adsl_f, by_vars)
        plot <- g_lineplot(
          df = data_f,
          alt_counts_df = adsl_f,
          variables = variables,
          title = "",
          subtitle = subtitle,
          ...
        )
        plot
      }
      
      
      # ===== g_vs_slide_test.R =====
      
      g_vs_slide_test <- function(adsl, advs, arm = "TRT01P", paramcd = "PARAM",
                             subtitle = "Plot of Mean and 95% Confidence Limits by Visit.", ...) {
        # tern 0.9.4 added facet_var in control_lineplot_vars
        variables <- control_lineplot_vars(group_var = arm, paramcd = paramcd) %>% strip_NA()
        by_vars <- c("USUBJID", "STUDYID")
        assert_that(is.string(arm))
        assert_that(has_name(advs, c(by_vars, variables) %>% unique()))
        assert_that(has_name(adsl, c(by_vars, arm) %>% unique()))
        g_mean_general(
          adsl = adsl, data = advs, variables = variables, by_vars = by_vars,
          subtitle = subtitle, ...
        )
      }
      
      
      # ===== l_ae_slide_test.R =====
      
      l_ae_slide_test <- function(adsl, adae) {
        assert_that(has_name(adae, c(
          "SITEID", "SUBJID", "AGE", "SEX", "RACE", "TRTSDTM", "AETOXGR",
          "AENDY", "ASTDY", "AESER", "AEREL", "AEOUT", "AECONTRT", "AEACN"
        )))
        # Preprocess data
        adsl_f <- adsl %>%
          df_explicit_na()
        adae_f <- adae %>%
          semi_join(., adsl_f, by = c("STUDYID", "USUBJID")) %>%
          df_explicit_na() %>%
          mutate(
            CPID = paste(SITEID, SUBJID, sep = "/"),
            ASR = paste(AGE, SEX, RACE, sep = "/"),
            Date_First = toupper(format(as.Date(TRTSDTM), "%d%b%Y")),
            Duration = AENDY - ASTDY + 1,
            Serious = ifelse(AESER == "Y", "Yes", ifelse(AESER == "N", "No", "")),
            Related = ifelse(AEREL == "Y", "Yes", ifelse(AEREL == "N", "No", "")),
            Outcome = case_when(
              AEOUT == "FATAL" ~ 1,
              AEOUT == "NOT RECOVERED/NOT RESOLVED" ~ 2,
              AEOUT == "RECOVERED/RESOLVED" ~ 3,
              AEOUT == "RECOVERED/RESOLVED WITH SEQUELAE" ~ 4,
              AEOUT == "RECOVERING/RESOLVING" ~ 5,
              AEOUT == "UNKNOWN" ~ 6
            ),
            Treated = ifelse(AECONTRT == "Y", "Yes", ifelse(AECONTRT == "N", "No", "")),
            Action = case_when(
              AEACN == "DOSE INCREASED" ~ 1,
              AEACN == "DOSE NOT CHANGED" ~ 2,
              AEACN == "DOSE REDUCED" | AEACN == "DOSE RATE REDUCED" ~ 3,
              AEACN == "DRUG INTERRUPTED" ~ 4,
              AEACN == "DRUG WITHDRAWN" ~ 5,
              AEACN == "NOT APPLICABLE" | AEACN == "NOT EVALUABLE" ~ 6,
              AEACN == "UNKNOWN" ~ 7
            )
          ) %>%
          select(
            CPID,
            # ASR,
            # TRT01A,
            AEDECOD,
            Date_First,
            # ASTDY,
            # Duration,
            Serious,
            # AESEV,
            Related,
            # Outcome,
            # Treated,
            AETOXGR,
            Action
          )
        formatters::var_labels(adae_f) <- c(
          CPID = "Center/Patient ID", # keep
          # ASR = "Age/Sex/Race",
          # TRT01A = "Treatment",                                      #keep
          AEDECOD = "Adverse\nEvent MedDRA\nPreferred Term", # keep
          Date_First = "Date of\nFirst Study\nDrug\nAdministration", # keep
          # ASTDY = "Study\nDay of\nOnset",
          # Duration = "AE\nDuration\nin Days",
          Serious = "Serious", # keep
          # AESEV = "Most\nExtreme\nIntensity",
          Related = "Caused by\nStudy\nDrug", # keep
          # Outcome = "Outcome\n(1)",
          # Treated = "Treatment\nfor AE",
          AETOXGR = "Analysis Toxicity Grade", # keep
          Action = "Action\nTaken\n(2)" # keep
        )
        # Set up listing
        lsting <- as_listing(
          adae_f,
          key_cols = c("CPID"),
          disp_cols = names(adae_f)
        )
        lsting
      }
      
      
      # ===== t_ae_pt_diff_slide_test.R =====
      
      t_ae_pt_diff_slide_test <- function(adsl, adae, arm = "TRT01A", cutoff = NA,
                                     split_by_study = FALSE, side_by_side = NULL) {
        cutoff <- check_and_set_cutoff(adae, cutoff)
        result <- t_ae_pt_core(adsl, adae, arm, cutoff,
          diff = TRUE, soc = "NULL",
          prune_by_total = FALSE, split_by_study, side_by_side
        )
        result@main_title <- "Adverse Events with Difference"
        if (!all(dim(result@rowspans) == c(0, 0))) {
          if (is.null(side_by_side)) {
            # adding "N" attribute
            arm <- col_paths(result)[[1]][1]
            n_r <- data.frame(
              ARM = toupper(names(result@col_info)),
              N = col_counts(result) %>% as.numeric()
            ) %>%
              `colnames<-`(c(paste(arm), "N")) %>%
              arrange(get(arm))
            attr(result, "N") <- n_r
          }
        }
        result
      }
      t_ae_pt_core <- function(adsl, adae, arm, cutoff, diff = FALSE, soc = "NULL",
                               prune_by_total = FALSE,
                               split_by_study, side_by_side) {
        assert_that(has_name(adae, "AEDECOD"))
        assert_that(has_name(adae, "ATOXGR"))
        assert_that(has_name(adae, "AEBODSYS"))
        assert_that(has_name(adae, "ANL01FL"))
        assert_that((diff + prune_by_total) < 2)
        assert_that(cutoff <= 100 & cutoff >= 0)
        if (!is.null(side_by_side)) {
          assert_that(has_name(adsl, "RACE"))
          assert_that(has_name(adsl, "COUNTRY"))
        }
        slref_arm <- sort(unique(adsl[[arm]]))
        anl_arm <- sort(unique(adae[[arm]]))
        assert_that(identical(slref_arm, anl_arm),
          msg = "The adsl and the analysis datasets should have the same treatment arm levels"
        )
        if (is.null(side_by_side)) {
          adsl1 <- adsl %>%
            select("STUDYID", "USUBJID", all_of(arm))
        } else if (side_by_side != TRUE) {
          adsl1 <- adsl %>%
            select("STUDYID", "USUBJID", "RACE", "COUNTRY", all_of(arm))
          adsl1$lvl <- "Global"
        } else {
          adsl1 <- adsl %>%
            select("STUDYID", "USUBJID", all_of(arm))
          adsl1$lvl <- "Global"
        }
        anl <- adae %>%
          mutate_at(
            c("AEDECOD", "AEBODSYS"),
            ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
          ) %>%
          semi_join(., adsl1, by = c("STUDYID", "USUBJID")) %>%
          mutate(
            ATOXGR = sas_na(ATOXGR) %>% as.factor(),
            ATOXGR2 = case_when(
              ATOXGR %in% c(1, 2) ~ "1 - 2",
              ATOXGR %in% c(3, 4) ~ "3 - 4",
              ATOXGR %in% c(5) ~ "5",
            ) %>% as.factor()
          )
        if (!is.null(side_by_side)) {
          anl$lvl <- "Global"
        }
        if (soc == "soc") {
          anl <- anl %>%
            mutate(
              AEBODSYS = sas_na(AEBODSYS) %>% as.factor()
            )
        }
        anl <- anl %>%
          formatters::var_relabel(
            AEBODSYS = "MedDRA System Organ Class",
            AEDECOD = "MedDRA Preferred Term"
          ) %>%
          filter(ANL01FL == "Y")
        if (nrow(anl) == 0) {
          return(null_report())
        } else {
          lyt <- build_table_header(adsl1, arm, split_by_study = split_by_study, side_by_side = side_by_side)
          # lyt <- basic_table() %>%
          #   split_cols_by(var = arm, split_fun = add_overall_level("All Patients", first = FALSE)) %>%
          #   add_colcounts()
          if (soc == "soc") {
            lyt <- lyt %>%
              split_rows_by(
                "AEBODSYS",
                child_labels = "visible",
                nested = FALSE,
                indent_mod = -1L,
                split_fun = drop_split_levels
              ) %>%
              append_varlabels(anl, "AEBODSYS")
          }
          lyt <- lyt %>%
            count_occurrences(
              vars = "AEDECOD",
              .indent_mods = c(count_fraction = 1L)
              # , .formats = list(trim_perc1)
            ) %>%
            append_topleft(paste("  ", formatters::var_labels(anl["AEDECOD"]), "N (%)"))
          if (soc == "soc") {
            sort_path <- c("AEBODSYS", "*", "AEDECOD")
          } else {
            sort_path <- c("AEDECOD")
          }
          # this is an add hoc test check
          myh_col_indices <- function(table_row, col_names) {
            NULL
          }
          # environment(myh_col_indices) <- asNamespace("tern")
          # assignInNamespace("h_col_indices", myh_col_indices, ns = "tern")
          # result <- build_table(lyt = lyt, df = anl, alt_counts_df = adsl1)
          result <- lyt_to_side_by_side_two_data(lyt, anl, adsl1, side_by_side)
          result <- result %>%
            sort_at_path(
              path = sort_path,
              scorefun = score_occurrences
            )
          # criteria_fun <- function(tr) is(tr, "ContentRow")
          # result <- trim_rows(result, criteria = criteria_fun)
          if (diff) {
            row_condition <- has_fractions_difference(
              atleast = cutoff / 100,
              # col_names = levels(adsl1$TRT01A)
              col_indices = 1:2
            )
            if (length(levels(adsl1[[arm]])) > 2) {
              stop("More than two arms, not implemented yet")
            }
          } else if (prune_by_total) {
            if (is.null(side_by_side)) {
              row_condition <- has_fraction_in_any_col(
                atleast = cutoff / 100,
                col_indices = ncol(result)
              )
            } else if (!is.null(side_by_side)) {
              stop("I am not implemented yet")
            } else {
              row_condition <- has_fraction_in_any_col(
                atleast = cutoff / 100,
                col_indices = ncol(result)
              )
            }
          } else {
            row_condition <- has_fraction_in_any_col(
              atleast = cutoff / 100,
              col_names = levels(adsl1[[arm]])
            )
          }
          result1 <- prune_table(result, keep_rows(row_condition))
          # Viewer(result1)
          if (is.null(result1)) {
            return(null_report())
          } else {
            return(result1)
          }
        }
      }
      
      
      # ===== t_ae_pt_slide_test.R =====
      
      t_ae_pt_slide_test <- function(adsl, adae, arm = "TRT01A", cutoff = NA, prune_by_total = FALSE,
                                split_by_study = FALSE,
                                side_by_side = NULL) {
        cutoff <- check_and_set_cutoff(adae, cutoff)
        result <- t_ae_pt_core(adsl, adae, arm, cutoff,
          diff = FALSE, soc = "NULL",
          prune_by_total = prune_by_total,
          split_by_study,
          side_by_side
        )
        result@main_title <- "Adverse Events table"
        if (is.null(side_by_side)) {
          # adding "N" attribute
          arm <- col_paths(result)[[1]][1]
          n_r <- data.frame(
            ARM = toupper(names(result@col_info)),
            N = col_counts(result) %>% as.numeric()
          ) %>%
            `colnames<-`(c(paste(arm), "N")) %>%
            arrange(get(arm))
          attr(result, "N") <- n_r
        }
        result
      }
      
      
      # ===== t_ae_pt_soc_diff_slide_test.R =====
      
      t_ae_pt_soc_diff_slide_test <- function(adsl, adae, arm = "TRT01A", cutoff = NA,
                                         split_by_study = FALSE, side_by_side = NULL) {
        cutoff <- check_and_set_cutoff(adae, cutoff)
        result <- t_ae_pt_core(adsl, adae, arm, cutoff,
          diff = TRUE, soc = "soc",
          prune_by_total = FALSE,
          split_by_study, side_by_side
        )
        result@main_title <- "Adverse Events with Difference"
        if (is.null(side_by_side)) {
          # adding "N" attribute
          arm <- col_paths(result)[[1]][1]
          n_r <- data.frame(
            ARM = toupper(names(result@col_info)),
            N = col_counts(result) %>% as.numeric()
          ) %>%
            `colnames<-`(c(paste(arm), "N")) %>%
            arrange(get(arm))
          attr(result, "N") <- n_r
        }
        result
      }
      
      
      # ===== t_ae_pt_soc_slide_test.R =====
      
      t_ae_pt_soc_slide_test <- function(adsl, adae, arm, cutoff = NA,
                                    prune_by_total = FALSE,
                                    split_by_study = FALSE,
                                    side_by_side = NULL) {
        cutoff <- check_and_set_cutoff(adae, cutoff)
        result <- t_ae_pt_core(adsl, adae, arm, cutoff,
          diff = FALSE, soc = "soc",
          prune_by_total = prune_by_total,
          split_by_study, side_by_side
        )
        result@main_title <- "Adverse Events table"
        if (is.null(side_by_side)) {
          # adding "N" attribute
          arm <- col_paths(result)[[1]][1]
          n_r <- data.frame(
            ARM = toupper(names(result@col_info)),
            N = col_counts(result) %>% as.numeric()
          ) %>%
            `colnames<-`(c(paste(arm), "N")) %>%
            arrange(get(arm))
          attr(result, "N") <- n_r
        }
        result
      }
      
      
      # ===== t_aesi_slide_test.R =====
      
      t_aesi_slide_test <- function(adsl, adae, aesi, arm = "ACTARM", grad_var = "AETOXGR") {
        assert_that(has_name(adsl, arm))
        assert_that(has_name(adae, "AEACN"))
        assert_that(has_name(adae, "AEOUT"))
        assert_that(has_name(adae, "AECONTRT"))
        assert_that(has_name(adae, "AESER"))
        assert_that(has_name(adae, "AEREL"))
        assert_that(has_name(adae, grad_var))
        assert_that(has_name(adae, "AECONTRT"))
        aesi_sym <- rlang::sym(aesi)
        adae2 <- filter(adae, is.na(!!aesi_sym))
        adsl <- df_explicit_na(adsl)
        adae2 <- df_explicit_na(adae2)
        # Merge ADAE with ADSL and ensure character variables are converted to factors and empty
        # strings and NAs are explicit missing levels.
        adae2 <- adsl %>%
          inner_join(adae2, by = c("USUBJID", "TRT01A", "TRT01P", "ARM", "ARMCD", "ACTARM", "ACTARMCD")) %>%
          df_explicit_na()
        not_resolved <- adae2 %>%
          filter(!(AEOUT %in% c("RECOVERED/RESOLVED", "FATAL", "RECOVERED/RESOLVED WITH SEQUELAE"))) %>%
          distinct(USUBJID) %>%
          mutate(NOT_RESOLVED = "Y")
        adae2 <- adae2 %>%
          left_join(not_resolved, by = c("USUBJID")) %>%
          mutate(
            ALL_RESOLVED = formatters::with_label(
              is.na(NOT_RESOLVED),
              "Total number of patients with all non-fatal AESIs resolved"
            ),
            NOT_RESOLVED = formatters::with_label(
              !is.na(NOT_RESOLVED),
              "Total number of patients with at least one unresolved or ongoing non-fatal AESI"
            )
          )
        adae2 <- adae2 %>%
          mutate(
            AEDECOD = as.character(AEDECOD),
            WD = formatters::with_label(
              AEACN == "DRUG WITHDRAWN", "Total number of patients with study drug withdrawn due to AESI"
            ),
            DSM = formatters::with_label(
              AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
              "Total number of patients with dose modified/interrupted due to AESI"
            ),
            CONTRT = formatters::with_label(AECONTRT == "Y", "Total number of patients with treatment received for AESI"),
            SER = formatters::with_label(AESER == "Y", "Total number of patients with at least one serious AESI"),
            REL = formatters::with_label(AEREL == "Y", "Total number of patients with at least one related AESI"),
            ALL_RESOLVED_WD = formatters::with_label(
              WD == TRUE & ALL_RESOLVED == TRUE,
              "No. of patients with study drug withdrawn due to resolved AESI"
            ),
            ALL_RESOLVED_DSM = formatters::with_label(
              DSM == TRUE & ALL_RESOLVED == TRUE,
              "No. of patients with dose modified/interrupted due to resolved AESI"
            ),
            ALL_RESOLVED_CONTRT = formatters::with_label(
              CONTRT == TRUE & ALL_RESOLVED == TRUE,
              "No. of patients with treatment received for resolved AESI"
            ),
            NOT_RESOLVED_WD = formatters::with_label(
              WD == TRUE & NOT_RESOLVED == TRUE,
              "No. of patients with study drug withdrawn due to unresolved or ongoing AESI"
            ),
            NOT_RESOLVED_DSM = formatters::with_label(
              DSM == TRUE & NOT_RESOLVED == TRUE,
              "No. of patients with dose modified/interrupted due to unresolved or ongoing AESI"
            ),
            NOT_RESOLVED_CONTRT = formatters::with_label(
              CONTRT == TRUE & NOT_RESOLVED == TRUE,
              "No. of patients with treatment received for unresolved or ongoing AESI"
            ),
            SERWD = formatters::with_label(
              AESER == "Y" & AEACN == "DRUG WITHDRAWN",
              "No. of patients with study drug withdrawn due to serious AESI"
            ),
            SERCONTRT = formatters::with_label(
              AECONTRT == "Y" & AESER == "Y",
              "No. of patients with dose modified/interrupted due to serious AESI"
            ),
            SERDSM = formatters::with_label(
              AESER == "Y" & AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
              "No. of patients with treatment received for serious AESI"
            ),
            RELWD = formatters::with_label(
              AEREL == "Y" & AEACN == "DRUG WITHDRAWN",
              "No. of patients with study drug withdrawn due to related AESI"
            ),
            RELDSM = formatters::with_label(
              AEREL == "Y" & AEACN %in% c("DRUG INTERRUPTED", "DOSE INCREASED", "DOSE REDUCED"),
              "No. of patients with dose modified/interrupted due to related AESI"
            ),
            RELCONTRT = formatters::with_label(
              AECONTRT == "Y" & AEREL == "Y",
              "No. of patients with treatment received for related AESI"
            ),
            RELSER = formatters::with_label(AESER == "Y" & AEREL == "Y", "No. of patients with serious, related AESI")
          )
        if (grad_var %in% c("AETOXGR", "ATOXGR")) {
          adae2 <- adae2 %>%
            mutate(
              {{ grad_var }} := forcats::fct_recode(get(grad_var),
                "Grade 1" = "1",
                "Grade 2" = "2",
                "Grade 3" = "3",
                "Grade 4" = "4",
                "Grade 5 (fatal outcome)" = "5"
              )
            )
        } else if (grad_var %in% c("AESEV", "ASEV")) {
          adae2 <- adae2 %>%
            mutate(
              {{ grad_var }} := forcats::fct_recode(stringr::str_to_title(get(grad_var), locale = "en"))
            )
        }
        aesi_vars <- c("WD", "DSM", "CONTRT", "ALL_RESOLVED", "NOT_RESOLVED", "SER", "REL")
        lyt_adae <- basic_table(show_colcounts = TRUE) %>%
          split_cols_by(arm) %>%
          count_patients_with_event(
            vars = "USUBJID",
            filters = c("ANL01FL" = "Y"),
            denom = "N_col",
            .labels = c(count_fraction = "Total number of patients with at least one AESI")
          ) %>%
          count_values(
            "ANL01FL",
            values = "Y",
            .stats = "count",
            .labels = c(count = "Total number of AESIs"),
            table_names = "total_aes"
          ) %>%
          count_occurrences_by_grade(
            var = grad_var,
            var_labels = "Total number of patients with at least one AESI by worst grade",
            show_labels = "visible"
          ) %>%
          count_patients_with_flags("USUBJID", flag_variables = aesi_vars, denom = "N_col")
        result <- build_table(lyt_adae, df = adae2, alt_counts_df = adsl)
        result
      }
      
      
      # ===== t_ae_slide_test.R =====
      
      t_ae_slide_test <- function(adsl, adae, arm = "TRT01A",
                             split_by_study = FALSE, side_by_side = NULL) {
        assert_that(has_name(adae, "AEDECOD"))
        assert_that(has_name(adae, "ATOXGR"))
        assert_that(has_name(adae, "AEBODSYS"))
        slref_arm <- sort(unique(adsl[[arm]]))
        anl_arm <- sort(unique(adae[[arm]]))
        assert_that(identical(slref_arm, anl_arm),
          msg = "The adsl and the analysis datasets should have the same treatment arm levels"
        )
        anl <- adae %>%
          mutate_at(
            c("AEDECOD", "AEBODSYS"),
            ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
          ) %>%
          semi_join(., adsl, by = c("STUDYID", "USUBJID")) %>%
          mutate(
            AETOXGR = sas_na(AETOXGR) %>% as.factor()
          ) %>%
          formatters::var_relabel(
            AEBODSYS = "MedDRA System Organ Class",
            AEDECOD = "MedDRA Preferred Term"
          )
        if (!is.null(side_by_side)) {
          anl$lvl <- "Global"
        }
        if (nrow(anl) == 0) {
          return(null_report())
        } else {
          lyt <- build_table_header(adsl, arm,
            split_by_study = split_by_study,
            side_by_side = side_by_side
          )
          lyt <- lyt %>%
            split_rows_by(
              "AEBODSYS",
              child_labels = "hidden",
              nested = FALSE,
              indent_mod = 0L,
              split_fun = drop_split_levels,
              label_pos = "topleft",
              split_label = obj_label(anl$AEBODSYS)
            ) %>%
            summarize_num_patients(
              var = "USUBJID",
              .stats = c("unique"),
              .labels = c(
                unique = "Total number of patients"
              ),
              .formats = list(trim_perc1)
            ) %>%
            count_occurrences(
              vars = "AEBODSYS",
              .indent_mods = -1L
              # , .formats = list(trim_perc1)
            ) %>%
            count_occurrences(
              vars = "AEDECOD",
              .indent_mods = 1L
              # , .formats = list(trim_perc1)
            ) %>%
            # append_varlabels(anl, "AEDECOD", indent = TRUE)
            append_topleft(paste("  ", formatters::var_labels(anl["AEDECOD"]), "N (%)"))
          result <- lyt_to_side_by_side_two_data(lyt, anl, adsl, side_by_side)
          result1 <- result %>%
            prune_table() %>%
            sort_at_path(
              path = c("AEBODSYS"),
              scorefun = cont_n_allcols
            ) %>%
            sort_at_path(
              path = c("AEBODSYS", "*", "AEDECOD"),
              scorefun = score_occurrences
            )
          t_aesi_trim_rows <- function(tt) {
            rows <- collect_leaves(tt, TRUE, TRUE)
            tbl <- tt[!grepl("unique", names(rows)), , keep_topleft = TRUE]
            tbl
          }
          result1 <- result1 %>%
            t_aesi_trim_rows()
          result1@main_title <- "AE event table"
          return(result1)
        }
      }
      
      
      # ===== t_ae_summary_slide_test.R =====
      
      t_ae_summ_slide <- function(adsl, adae, arm = "TRT01A",
                                  dose_adjust_flags = NA,
                                  dose_adjust_labels = NA,
                                  gr34_highest_grade_only = TRUE) {
        # The gr3-4 only count the patients whose highest ae grade is 3 or 4
        assert_that(has_name(adae, "TRT01A"))
        assert_that(has_name(adae, "AEDECOD"))
        assert_that(has_name(adae, "AEBODSYS"))
        assert_that(has_name(adae, "ATOXGR"))
        assert_that(has_name(adae, "AEREL"))
        assert_that(has_name(adae, "ANL01FL"))
        assert_that(has_name(adae, "SAFFL"))
        assert_that(has_name(adae, "TRTEMFL"))
        assert_that(has_name(adae, "AESER"))
        assert_that(length(dose_adjust_flags) == length(dose_adjust_labels))
        assert_that(assertthat::is.flag(gr34_highest_grade_only))
        if (sum(is.na(dose_adjust_flags)) == 0 & sum(is.na(dose_adjust_labels)) == 0) {
          for (txt in dose_adjust_flags) {
            assert_that(all(unlist(adae[txt]) %in% c(TRUE, FALSE)))
            assert_that(has_name(adae, txt))
          }
        }
        adsl1 <- adsl %>%
          select("STUDYID", "USUBJID", "TRT01A")
        pts_gr5 <- adae %>% filter(ATOXGR %in% c(5))
        anl <- adae %>%
          mutate_at(
            c("AEDECOD", "AEBODSYS"),
            ~ explicit_na(sas_na(.)) # Replace blank arm with <Missing>
          ) %>%
          mutate(
            ATOXGR = sas_na(ATOXGR) %>% as.factor(),
            ATOXGR2 = case_when(
              ATOXGR %in% c(1, 2) ~ "1 - 2",
              ATOXGR %in% c(3, 4) ~ "3 - 4",
              ATOXGR %in% c(5) ~ "5",
            ) %>% as.factor(),
            TRT01A = sas_na(TRT01A) %>% as.factor()
          ) %>%
          semi_join(., adsl1, by = c("STUDYID", "USUBJID")) %>%
          filter(ANL01FL == "Y" & TRTEMFL == "Y" & SAFFL == "Y") %>%
          formatters::var_relabel(
            ATOXGR2 = "AE Grade 3 groups",
            ATOXGR = "AE Grade",
            TRT01A = "Actual Treatment 01"
          ) %>%
          # ---------- ADAE: Treatment related flags ---------
          mutate(
            TMPFL1_REL0 = AEREL == "Y"
          ) %>%
          formatters::var_relabel(
            TMPFL1_REL0 = "Any treatment"
          ) %>%
          # ---------- ADAE: Grade 5 and related flags ---------
          mutate(
            TMPFL1_G5 = ATOXGR %in% c(5),
            TMPFL1_G5_REL = ATOXGR %in% c(5) & AEREL == "Y"
          ) %>%
          formatters::var_relabel(
            TMPFL1_G5 = "Grade 5 AE",
            TMPFL1_G5_REL = "Treatment-related Grade 5 AE"
          ) %>%
          # ---------- ADAE: SAE and related flags ---------
          mutate(
            TMPFL1_SER = AESER == "Y",
            TMPFL1_SER_REL = AESER == "Y" & AEREL == "Y"
          ) %>%
          formatters::var_relabel(
            TMPFL1_SER = "Serious AE",
            TMPFL1_SER_REL = "Treatment-related Serious AE"
          )
        # ---------- ADAE: Grade 3/4 and related flags ---------
        if (gr34_highest_grade_only == TRUE) {
          anl <- anl %>%
            mutate(
              TMPFL1_G34 = ATOXGR %in% c(3, 4) & !(USUBJID %in% pts_gr5$USUBJID), # Only count the highest grade is 3 or 4
              TMPFL1_G34_REL = ATOXGR %in% c(3, 4) & AEREL == "Y" & !(USUBJID %in% pts_gr5$USUBJID)
            ) %>%
            formatters::var_relabel(
              TMPFL1_G34 = "Grade 3-4 AE",
              TMPFL1_G34_REL = "Treatment-related Grade 3-4 AE"
            )
        } else {
          anl <- anl %>%
            mutate(
              TMPFL1_G34 = ATOXGR %in% c(3, 4),
              TMPFL1_G34_REL = ATOXGR %in% c(3, 4) & AEREL == "Y"
            ) %>%
            formatters::var_relabel(
              TMPFL1_G34 = "Grade 3-4 AE",
              TMPFL1_G34_REL = "Treatment-related Grade 3-4 AE"
            )
        }
        if (nrow(anl) == 0) {
          return(null_report())
        } else {
          lyt <- basic_table() %>%
            split_cols_by(arm, split_fun = add_overall_level("All Patients", first = FALSE)) %>%
            add_colcounts() %>%
            count_patients_with_event(
              vars = "USUBJID",
              filters = c("SAFFL" = "Y"),
              denom = "N_col",
              .stats = "count_fraction",
              .labels = c(count_fraction = "All grade AEs, any cause"),
              table_names = "U",
              # .formats = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_REL0 = "Related"),
              denom = "N_col",
              .indent_mods = 1L,
              var_labels = "TMPFL1 Related"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_G34 = "Grade 3-4 AEs"),
              denom = "N_col",
              .indent_mods = 0L,
              var_labels = "Grade 3-4 AEs"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_G34_REL = "Related"),
              denom = "N_col",
              .indent_mods = 1L,
              var_labels = "TMPFL1_G34 Related"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_G5 = "Grade 5 AE"),
              denom = "N_col",
              .indent_mods = 0L,
              var_labels = "Grade 5 AE"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_G5_REL = "Related"),
              denom = "N_col",
              .indent_mods = 1L,
              var_labels = "TMPFL1_G5 Related"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_SER = "SAEs"),
              denom = "N_col",
              .indent_mods = 0L,
              var_labels = "SAEs"
              # .format = list(trim_perc1)
            ) %>%
            count_patients_with_flags(
              "USUBJID",
              flag_variables = c(TMPFL1_SER_REL = "Related"),
              denom = "N_col",
              .indent_mods = 1L,
              var_labels = "TMPFL1_SEA Related"
              # .format = list(trim_perc1)
            )
          if (sum(is.na(dose_adjust_flags)) == 0 & sum(is.na(dose_adjust_labels)) == 0) {
            for (i in 1:length(dose_adjust_flags)) {
              text <- paste0(
                '     lyt <- lyt %>%
             count_patients_with_flags(
               "USUBJID",
               flag_variables = c(', dose_adjust_flags[i], "='", dose_adjust_labels[i],
                "'),
                denom = 'N_col',
                var_labels = paste('dose adjust',i),
               .indent_mods = 0L)"
              )
              eval(parse(text = text))
            }
          }
          result <- build_table(
            lyt,
            df = anl,
            alt_counts_df = adsl
          )
          result@main_title <- "AE summary table"
        }
        return(result)
      }
      
      
      # ===== t_dd_slide_test.R =====
      
      t_dd_slide_test <- function(adsl,
                             arm = "TRT01A",
                             split_by_study = FALSE,
                             side_by_side = NULL) {
        assert_that(has_name(adsl, "DTHCAT"))
        assert_that(has_name(adsl, "DTHFL"))
        anl <- adsl
        if (!is.null(side_by_side)) {
          anl$lvl <- "Global"
        }
        if (nrow(anl) == 0) {
          return(null_report())
        } else {
          lyt <- build_table_header(adsl, arm, split_by_study = split_by_study, side_by_side = side_by_side)
          lyt <- lyt %>%
            count_values(
              "DTHFL",
              values = "Y",
              denom = c("N_col"),
              .labels = c(count_fraction = "All Deaths")
            ) %>%
            analyze_vars(
              vars = "DTHCAT", .stats = "count_fraction",
              na_str = "<Missing>",
              var_labels = " ",
              na.rm = TRUE
            ) %>%
            # count_patients_with_flags(
            #   "USUBJID",
            #   flag_variables = formatters::var_labels(anl[,c("DTHCAT1", "DTHCAT2", "DTHCAT3")]),
            #   .indent_mods = 1L,
            #   .format = list(trim_perc1),
            #   denom = "n"
            # ) %>%
            append_topleft("N (%)")
          result <- lyt_to_side_by_side(lyt, anl, side_by_side)
          result@main_title <- "Death table"
          result
        }
      }
      
      
      # ===== t_dm_slide_test.R =====
      
      t_dm_slide_test <- function(adsl,
                             arm = "TRT01P",
                             vars = c("AGE", "SEX", "RACE"),
                             stats = c("median", "range", "count_fraction"),
                             split_by_study = FALSE,
                             side_by_side = NULL) {
        if (is.null(side_by_side)) {
          extra <- NULL
        } else {
          extra <- c("COUNTRY")
        }
        for (v in c(vars, extra)) {
          assert_that(has_name(adsl, v))
        }
        adsl1 <- adsl %>%
          select(all_of(c("STUDYID", "USUBJID", arm, vars, extra)))
        if (!is.null(side_by_side)) {
          adsl1$lvl <- "Global"
        }
        lyt <- build_table_header(adsl1, arm,
          split_by_study = split_by_study,
          side_by_side = side_by_side
        )
        lyt <- lyt %>%
          analyze_vars(
            na.rm = TRUE,
            .stats = stats,
            denom = "n",
            vars = vars,
            .formats = c(mean_sd = "xx.xx (xx.xx)", median = "xx.xx"),
            var_labels = formatters::var_labels(adsl1)[vars]
          )
        result <- lyt_to_side_by_side(lyt, adsl1, side_by_side)
        if (is.null(side_by_side)) {
          # adding "N" attribute
          arm <- col_paths(result)[[1]][1]
          n_r <- data.frame(
            ARM = toupper(names(result@col_info)),
            N = col_counts(result) %>% as.numeric()
          ) %>%
            `colnames<-`(c(paste(arm), "N")) %>%
            dplyr::arrange(get(arm))
          attr(result, "N") <- n_r
        }
        result@main_title <- "Demographic slide"
        result
      }
      
      
      # ===== t_dor_slide_test.R =====
      
      t_dor_slide_test <- function(adsl, adtte, arm = "TRT01P", refgroup = NULL) {
        assert_that(has_name(adsl, arm))
        assert_that(has_name(adtte, "CNSR"))
        assert_that(has_name(adtte, "EVNTDESC"))
        assert_that(has_name(adtte, "AVALU"))
        assert_that(has_name(adtte, "AVAL"))
        assert_that(all(!is.na(adtte[["AVALU"]])))
        slref_arm <- sort(unique(adsl[[arm]]))
        anl_arm <- sort(unique(adtte[[arm]]))
        assert_that(identical(slref_arm, anl_arm),
          msg = "The adsl and the analysis datasets should have the same treatment arm levels"
        )
        time_unit <- unique(adtte[["AVALU"]])
        assert_that(length(time_unit) == 1)
        if (toupper(time_unit) == "DAYS") {
          adtte <- adtte %>%
            dplyr::mutate(AVAL = day2month(AVAL))
        } else if (toupper(time_unit) == "YEARS") {
          adtte <- adtte %>%
            dplyr::mutate(AVAL = AVAL * 12)
        }
        adtte_f <- adtte %>%
          dplyr::mutate(
            is_event = CNSR == 0,
            is_not_event = CNSR == 1,
            EVNT1 = factor(
              case_when(
                is_event == TRUE ~ "Responders with subsequent event (%)",
                is_event == FALSE ~ "Responders without subsequent event (%)"
              )
            ),
            EVNTDESC = factor(EVNTDESC)
          ) %>%
          semi_join(., adsl, by = c("STUDYID", "USUBJID")) %>%
          select(STUDYID, USUBJID, {{ arm }}, AVAL, is_event, is_not_event, EVNT1, EVNTDESC) %>%
          df_explicit_na(char_as_factor = FALSE)
        lyt_02 <- basic_table() %>%
          split_cols_by(
            var = arm,
            ref_group = refgroup
          ) %>%
          add_colcounts() %>%
          count_values(
            vars = "USUBJID",
            values = unique(adtte$USUBJID),
            .labels = c(count = "Responders"),
            .stats = "count"
          ) %>%
          analyze_vars(
            vars = "is_event",
            .stats = "count_fraction",
            .labels = c(count_fraction = "With subsequent event (%)"),
            .indent_mods = c(count_fraction = 1L),
            show_labels = "hidden",
          ) %>%
          analyze(
            vars = "AVAL",
            afun = s_surv_time_1,
            extra_args = list(is_event = "is_event"),
            table_names = "est_prop",
            format = format_xx("xx.x (xx.x, xx.x)"),
            show_labels = "hidden",
            indent_mod = 1
          )
        result <- build_table(lyt_02, df = adtte_f, alt_counts_df = adsl)
        result@main_title <- "DOR slide"
        result
      }
      
      
      # ===== t_ds_slide_test.R =====
      
      t_ds_slide_test <- function(adsl, arm = "TRT01P",
                             split_by_study = FALSE,
                             side_by_side = NULL) {
        assert_that(has_name(adsl, arm))
        assert_that(has_name(adsl, "SAFFL"))
        assert_that(has_name(adsl, "STDONS"),
          msg = "`STDONS` variable is needed for this output, please use `preprocess_t_ds` function to derive."
        )
        assert_that(has_name(adsl, "DCSREAS"))
        assert_that(length(levels(adsl$STDONS)) <= 3)
        adsl1 <- adsl %>%
          mutate(
            STDONS = factor(explicit_na(sas_na(STDONS)),
              levels = c("Alive: On Treatment", "Alive: In Follow-up", "<Missing>"),
              labels = c("On Treatment", "In Follow-up", "<Missing>")
            ),
            DCSREAS = str_to_title(factor(sas_na(DCSREAS))),
            DCSflag = ifelse(is.na(DCSREAS), "N", "Y"),
            STDONSflag = ifelse(STDONS == "<Missing>", "N", "Y")
          ) %>%
          mutate_at(c("STDONS", "DCSREAS"), ~ as.factor(explicit_na(.))) %>%
          formatters::var_relabel(
            STDONS = "On-study Status",
            DCSflag = "Discontinued the study"
          )
        if (!is.null(side_by_side)) {
          adsl1$lvl <- "Global"
        }
        lyt <- build_table_header(adsl1, arm, split_by_study = split_by_study, side_by_side = side_by_side)
        lyt <- lyt %>%
          count_values("SAFFL",
            values = "Y",
            .labels = c(count_fraction = "Received Treatment")
          ) %>%
          split_rows_by(
            "STDONSflag",
            split_fun = keep_split_levels("Y"),
          ) %>%
          summarize_row_groups(label_fstr = "On-study Status") %>%
          analyze_vars(
            "STDONS",
            .stats = "count_fraction",
            denom = "N_col",
            na.rm = TRUE,
            # var_labels =  formatters::var_labels(adsl1)["STDONS"]
          ) %>%
          split_rows_by(
            "DCSflag",
            split_fun = keep_split_levels("Y"),
          ) %>%
          summarize_row_groups(label_fstr = "Discontinued the study") %>%
          analyze_vars(
            "DCSREAS",
            .stats = "count_fraction",
            denom = "N_col"
          )
        result <- lyt_to_side_by_side(lyt, adsl1, side_by_side)
        result@main_title <- "Discontinue table"
        return(result)
      }
      
