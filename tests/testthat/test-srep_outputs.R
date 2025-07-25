test_that("Listing print correctly", {
  testthat::skip_if_not_installed("filters")
  testthat::skip_if_not_installed("rsvg")

  # skip_if_too_deep(1)
  filters::load_filters(file.path(
    system.file(package = "autoslider.core"),
    "filters.yml"
  ), overwrite = TRUE)

  spec_file <- file.path(system.file(package = "autoslider.core"), "spec.yml")

  full_spec <- spec_file %>%
    read_spec()

  outputs <- full_spec %>%
    filter_spec(., program %in% c(
      "t_ds_slide",
      "t_dd_slide",
      "t_ae_slide",
      "t_ae_pt_slide",
      "t_ae_pt_soc_slide",
      "t_ae_pt_diff_slide",
      "t_ae_pt_diff_soc_slide",
      "g_vs_slide",
      "g_lab_slide",
      "g_eg_slide",
      "t_dm_slide",
      "gt_t_dm_slide",
      "t_ae_summ_slide",
      "l_ae_slide"
    )) %>%
    generate_outputs(datasets = testdata) %>%
    decorate_outputs(
      version_label = NULL,
      for_test = TRUE
    )

  output_dir <- tempdir()
  testthat::expect_no_error({
    outputs %>%
      generate_slides(outfile = paste0(output_dir, "/srep.pptx"), t_cpp = 250,
                      t_lpp = 50, fig_editable = TRUE)
  })

  testthat::expect_no_error({
    outputs %>%
      save_outputs(outfolder = output_dir)
  })
})
