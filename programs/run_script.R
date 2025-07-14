setwd("~/autoslider.core")

# define path to the yml files
spec_file <- "spec.yml"
filters <- "filters.yml"

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


source("programs/R/tryout.R")
# create outputs based on the specs and the functions
outputs <- spec_file %>%
  read_spec() %>%
  # we can also filter for specific programs, if we don't want to create them all
  filter_spec(., program %in% c(
    "tryout"
  )) %>%
  # these filtered specs are now piped into the generate_outputs function.
  # this function also requires the data
  generate_outputs(datasets = data) %>%
  # now we decorate based on the specs, i.e. add footnotes and titles
  decorate_outputs(
    version_label = NULL
  )
# ✔ 2/3 outputs matched the filter condition `program %in% c("t_ds_slide", "t_dm_slide")`.
# ❯ Running program `t_ds_slide` with suffix 'ITT'.
# Filter 'ITT' matched target ADSL.
# 400/400 records matched the filter condition `ITTFL == 'Y'`.
# ❯ Running program `t_dm_slide` with suffix 'ITT'.
# Filter 'ITT' matched target ADSL.
# 400/400 records matched the filter condition `ITTFL == 'Y'`.


outputs$tryout_SE

# Output to slides with template and color theme
outputs %>%
  generate_slides(
    outfile = "outputs/presentation.pptx",
    template = file.path(system.file(package = "autoslider.core"), "/theme/basic.pptx"),
    table_format = autoslider_format
  )
