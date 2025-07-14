yaml_content <- '
ITT:
  title: Intent to Treat Population
  condition: ITTFL == "Y"
  target: adsl
  type: slref
SAS:
  title: Secondary Analysis Set
  condition: SASFL == "Y"
  target: adsl
  type: slref
SE:
  title: Safety Evaluable Population
  condition: SAFFL== "Y"
  target: adsl
  type: slref
SER:
  title: Serious Adverse Events
  condition: AESER == "Y"
  target: adae
  type: anl
LBCRP:
  title: CRP Values
  condition: PARAMCD == "CRP"
  target: adlb
  type: slref
LBNOBAS:
  title: Only Visits After Baseline
  condition: ABLFL != "Y" & !(AVISIT %in% c("SCREENING", "BASELINE"))
  target: adlb
  type: slref
'

filters <- tempfile(fileext = ".yaml")

write(yaml_content, file = filters)

specs_entry <- '
- program: t_ds_slide
  titles: Patient Disposition ({filter_titles("adsl")})
  footnotes: "t_ds footnotes"
  paper: L6
  suffix: ITT
- program: t_dm_slide
  titles: Patient Demographics and Baseline Characteristics
  footnotes: "t_dm_slide footnote"
  paper: L6
  suffix: ITT
  args:
    arm: "TRT01A"
    vars: ["SEX", "AGE", "RACE"]
- program: t_ae_slide
  titles: AEs & Serious AEs
  footnotes: ""
  paper: L6
  suffix: SER
  args:
    arm: "TRT01A"
'
spec_file <- tempfile(fileext = ".yaml")

write(specs_entry, file = spec_file)

filters::load_filters(filters, overwrite = TRUE)

data <- list(
  "adsl" = eg_adsl %>%
    mutate(
      FASFL = SAFFL,
      DISTRTFL = sample(c("Y", "N"), size = length(TRT01A), replace = TRUE, prob = c(.1, .9))
    ) %>%
    preprocess_t_ds(),
  "adae" = eg_adae,
  "adtte" = eg_adtte,
  "adrs" = eg_adrs,
  "adlb" = eg_adlb
)

outputs <- spec_file %>%
  read_spec() %>%
  filter_spec(., program %in% c("t_ds_slide", "t_dm_slide", "t_ae_slide")) %>%
  generate_outputs(datasets = data) %>%
  decorate_outputs(
    version_label = NULL
  )

test_that("demographic table formatting", {
  y <- to_flextable.dVTableTree(outputs$t_dm_slide_ITT, lpp = 200, cpp = 200)
  expect_silent(autoslider_dose_format(y[[1]]$ft))
  expect_silent(black_format_tb(y[[1]]$ft))
})
