test_that("Listing print correctly", {
  testthat::skip_if_not_installed("filters")
  testthat::skip_if_not_installed("ellmer")
  testthat::skip_on_ci()
  testthat::skip_on_cran()

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
      "t_dm_slide"
    )) %>%
    generate_outputs(datasets = testdata) %>%
    decorate_outputs(
      version_label = NULL,
      for_test = TRUE
    )
  prompt_list <- get_prompt_list(filename = file.path(
    system.file(package = "autoslider.core"),
    "prompt.yml"
  ))
  outputs <- get_ai_notes(outputs, prompt_list,
    platform = "deepseek",
    base_url = "https://api.deepseek.com",
    api_key = get_deepseek_key("DEEPSEEK_KEY"),
    model = "deepseek-chat"
  )
  # outputs <- get_ai_notes(outputs, prompt_list,
  #   platform = "galileo",
  #   base_url = "https://us.aigw.galileo.roche.com/v1",
  #   api_key = get_portkey_key("PORTKEY_API_KEY"),
  #   model = "us.anthropic.claude-3-7-sonnet-20250219-v1:0"
  # )
  output_dir <- tempdir()
  testthat::expect_output({
    outputs %>%
      generate_slides(outfile = paste0(output_dir, "ai_srep.pptx"), t_cpp = 250, t_lpp = 20)
  })

  testthat::expect_no_error({
    outputs %>%
      save_outputs(outfolder = output_dir)
  })
})


test_that("using ollama", {
  testthat::skip_if_not_installed("filters")
  testthat::skip_if_not_installed("ellmer")
  testthat::skip_on_ci()
  testthat::skip_on_cran()

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
      "t_dm_slide"
    )) %>%
    generate_outputs(datasets = testdata) %>%
    decorate_outputs(
      version_label = NULL,
      for_test = TRUE
    )
  prompt_list <- get_prompt_list(filename = file.path(
    system.file(package = "autoslider.core"),
    "prompt.yml"
  ))
  # outputs <- adding_ai_footnotes(outputs, prompt_list,
  #   platform = "deepseek",
  #   base_url = "https://api.deepseek.com",
  #   api_key = get_deepseek_key("~/autoslider.core/DEEPSEEK_KEY"),
  #   model = "deepseek-chat"
  # )
  outputs <- get_ai_notes(outputs, prompt_list,
    platform = "ollama",
    base_url = "http://host.docker.internal:11434",
    model = "deepseek-r1:1.5b"
  )
  output_dir <- tempdir()
  testthat::expect_output({
    outputs %>%
      generate_slides(outfile = paste0(output_dir, "ai_srep.pptx"), t_cpp = 250, t_lpp = 20)
  })

  testthat::expect_no_error({
    outputs %>%
      save_outputs(outfolder = output_dir)
  })
})
