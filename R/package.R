#' autoslider.core Package
#'
"_PACKAGE"

#' @import flextable
#' @import officer
#' @import rtables
#' @import tern
#' @import rlistings
#' @importFrom assertthat assert_that noNA are_equal has_name is.string
#' @importFrom checkmate assert_class assert_numeric assert_flag assert_count assert_number
#' @importFrom cli cat_bullet
#' @importFrom dplyr mutate_at mutate rename filter select semi_join case_when all_of arrange left_join distinct inner_join
#' @importFrom filters apply_filter
#' @importFrom formatters var_relabel propose_column_widths var_labels obj_label matrix_form with_label
#' @importFrom formatters var_labels<- paginate_indices
#' @importFrom ggpubr as_ggplot
#' @importFrom glue glue
#' @importFrom googlesheets4 read_sheet
#' @importFrom graphics title
#' @importFrom grDevices dev.off svg
#' @importFrom grid grid.draw gpar grid.newpage unit.pmax
#' @importFrom gridExtra arrangeGrob
#' @importFrom lubridate is.Date
#' @importFrom magrittr %>%
#' @importFrom methods is formalArgs new
#' @importFrom officer fortify_location ph_location_label
#' @importFrom purrr reduce
#' @importFrom rlang abort `:=`
#' @importFrom readxl read_excel
#' @importFrom rvg dml
#' @importFrom stats setNames median na.omit pt sd
#' @importFrom stringr str_extract str_to_title
#' @importFrom survival Surv survfit coxph survdiff strata
#' @importFrom tern control_coxph format_xx d_proportion
#' @importFrom tidyr gather spread unite
#' @importFrom utils modifyList file.edit assignInNamespace
NULL


utils::globalVariables(c(
  ".", "AEBODSYS", "AEBODSYS2", "AESI01FL", "AESIGFL", "AETOXGR", "ANL01FL", "ATOXGR", "AVAL",
  "AVALC", "AVALC1", "AVALU", "CNSR", "DCSREAS", "DTHCAT", "DTRTxxFL", "EVNT1", "EVNTDESC", "NAMVAR",
  "REFNAME", "STDONS", "STUDYID", "TRT01A", "USUBJID", "adag", "as.formula", "condition", "id",
  "inner_join", "is_event", "is_not_event", "is_rsp", "null_report", "pchisq", "prop.test",
  "r_condition", "re", "rec_trt", "select_reporting_event", "sym", "target", "to_yaml_spec",
  "type", "update_yaml_spec", "var_labels_remove", "vars", "with_label",
  "ACTARM", "AEACN", "AECONTRT", "AEDECOD", "AEENDTC", "AEENDY", "AENDY", "AEOUT", "AEREL", "AESDTH",
  "AESEQ", "AESER", "AESEV", "AESTDTC", "AESTDY", "AEWITHFL", "AGE", "AGEU", "ALL_RESOLVED",
  "ANALYSIS", "ANRIND", "ASR", "ASTDY", "AVISIT", "AVISITN", "Action", "CMCAT", "CMDOSE", "CMDOSU",
  "CMSTDTC", "CONTENT", "CONTRT", "COUNTRY", "CPID", "CQ01NAM", "DISCONT", "DSDECOD", "DSM",
  "DSSCAT", "Date_First", "ECDOSE", "ECMOOD", "ECSTDTC", "EOSSTT", "EXDOSE", "EXDOSU", "EXENDTC",
  "EXENDY", "EXSTDTC", "EXSTDY", "HEIGHT", "ID", "LEVEL1_FORMAT", "NOT_RESOLVED", "ONTRTFL",
  "PARAM", "PARAMCD", "PARCAT2", "PCHG", "RACE", "Related", "SAFFL", "SEX", "SITEID", "SMQ01NAM",
  "SSADM", "STDWD", "SUBJID", "Serious", "TRTEDTM", "TRTEMFL", "TRTSDTM", "WD",
  "border_color", "summary_txt", "col_status", "newvalue", "ptord", "status", "value",
  "CMDECOD", "CMENDTC", "CMENRTPT", "CMTRT", "ongoing",
  "ADJ_REAS", "AENUM", "DOSMOD_YN", "ECCAT", "ECDOSU", "ECENDTC", "ECENDY", "ECOCCUR", "ECSPID",
  "ECSTDY", "ECTRT", "FACAT", "FAECADJ", "FAOBJ", "FAORRES", "FAREFID", "FATESTCD", "RFXENDTC",
  "RFXSTDTC", "VISIT", "END", "START", "act_dose", "dlteval", "dose_admin", "dsdecod", "plan_dose",
  "ADTM", "ADY", "ANRHI", "ANRLO", "DLD", "LBTEST", "LBTEST_U"
))

#' General notes
#'
#' @note
#'  * Default arm variables are set to `"TRT01A"` for safety output, and
#'  `"TRT01P"` for efficacy output
#'
gen_notes <- function() {
  NULL
}
