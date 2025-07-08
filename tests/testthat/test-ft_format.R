library(yaml)
library(assertthat)
library(tern)

# Create the YAML content
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

# Create a temporary YAML file
filters <- tempfile(fileext = ".yaml")

# Write the YAML content to the temporary file
write(yaml_content, file = filters)

# Create the specs entry
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
- program: t_ae_sae_slide
  titles: AEs & Serious AEs
  footnotes: ""
  paper: L6
  suffix: SER
  args:
    arm: "TRT01A"
'

# Create a temporary specs entry file
spec_file <- tempfile(fileext = ".yaml")

# Write the specs entry to the temporary file
write(specs_entry, file = spec_file)

# This chunk runs first and prepares the environment for the whole document

# 1. Load ALL necessary packages
library(rtables) # For append_topleft()
library(dplyr) # For %>% and other functions
library(assertthat) # For assert_that() you had issues with before


library("dplyr")
# load all filters
filters::load_filters(filters, overwrite = TRUE)
# read data
data <- list(
  "adsl" = eg_adsl %>%
    mutate(
      FASFL = SAFFL, # add FASFL for illustrative purpose for t_pop_slide
      # DISTRTFL is needed for t_ds_slide but is missing in example data
      DISTRTFL = sample(c("Y", "N"), size = length(TRT01A), replace = TRUE, prob = c(.1, .9))
    ) %>%
    preprocess_t_ds(), # this preproccessing is required by one of the autoslider.core functions
  "adae" = eg_adae,
  "adtte" = eg_adtte,
  "adrs" = eg_adrs,
  "adlb" = eg_adlb
)


outputs <- spec_file %>%
  read_spec() %>%
  # we can also filter for specific programs:
  filter_spec(., program %in% c("t_ds_slide", "t_dm_slide", "t_ae_sae_slide")) %>%
  # these filtered specs are now piped into the generate_outputs function.
  # this function also requires the data
  generate_outputs(datasets = data) %>%
  # now we decorate based on the specs, i.e. add footnotes and titles
  decorate_outputs(
    version_label = NULL
  )





y <- to_flextable.dVTableTree(outputs$t_dm_slide_ITT, lpp = 200, cpp = 200)
# not sure what the intended effect is here
expect_silent(autoslider_dose_format(y[[1]]$ft))
expect_silent(black_format_tb(y[[1]]$ft))

# specifically called on a adverse event table for processing

y <- to_flextable.dVTableTree(outputs$t_ae_sae_slide_SER, lpp = 200, cpp = 200)

expect_silent(black_format_ae(y[[1]]$ft))
