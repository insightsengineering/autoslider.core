spec_file <- "specs.yml"
filters <- "filters.yml"
out_file <- "outputs/dm.pptx"
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



# create outputs based on the specs and the functions
outputs <- spec_file %>%
  read_spec() %>%
  # we can also filter for specific programs, if we don't want to create them all
  filter_spec(., program %in% c(
    "t_ds_slide",
    "t_dm_slide"
  )) %>%
  # these filtered specs are now piped into the generate_outputs function.
  # this function also requires the data
  generate_outputs(datasets = data) %>%
  # now we decorate based on the specs, i.e. add footnotes and titles
  decorate_outputs(
    version_label = NULL
  )

