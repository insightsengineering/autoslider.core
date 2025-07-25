test_path <- tempdir()

# test `list_all_templates` -----
test_that("list_all_templates test 1: returns all available templates", {
  expected <- c(
    "l_ae_slide", "g_mean_general", "g_eg_slide", "g_lb_slide", "g_vs_slide",
    "t_ae_pt_diff_slide", "t_ae_pt_slide", "t_ae_pt_soc_diff_slide",
    "t_ae_pt_soc_slide", "t_aesi_slide", "t_ae_slide", "t_ae_summary_slide",
    "t_dd_slide", "t_dm_slide", "t_dor_slide", "t_ds_slide"
  )

  actual <- basename(list_all_templates())
  expect_setequal(actual, expected)
})


test_that("use_template test 2: saving when no path is specified", {
  file_location <- file.path("programs/R", "tryout.R")
  file.remove(file_location)

  expect_snapshot(use_template(
    template = "t_dm_slide",
    function_name = "tryout",
    open = FALSE
  ))

  # Test overwrite logic
  expect_error(
    use_template(
      template = "t_dm_slide",
      function_name = "tryout",
      overwrite = FALSE,
      open = FALSE
    )
  )



  expect_snapshot(use_template(
    template = "t_dm_slide",
    function_name = "tryout",
    overwrite = TRUE,
    open = FALSE
  ))
  file_location <- file.path("programs/R", "tryout.R")
  file.remove(file_location)
})

test_that("use_template test 3: create folder when it does not exist", {
  new_dir <- file.path("random")
  expected_file <- file.path(new_dir, "folder_test.R")

  if (dir.exists(new_dir)) unlink(new_dir, recursive = TRUE)

  expect_false(dir.exists(new_dir))


  expect_true(use_template(
    template = "t_dm_slide",
    function_name = "folder_test",
    save_path = new_dir,
    open = FALSE
  ))

  expect_true(dir.exists(new_dir))

  file.remove(expected_file)
})


# test `use_template` error handling -----
test_that("use_template test 4: expected errors", {
  expect_error(
    use_template(
      template = "ttt", # invalid template
      function_name = "tryout",
      save_path = test_path,
      open = FALSE
    )
  )
  expect_error(
    use_template(
      template = "ttt", # invalid template
      function_name = "tryout",
      save_path = test_path,
      open = FALSE
    )
  )
})

test_that("use_template test 5: when template is contained in autoslideR", {
  expect_true(
    use_template(
      template = "t_dm_slide",
      function_name = "tryout",
      overwrite = TRUE,
      open = FALSE,
      package = "autoslideR"
    )
  )
})

# test `use_template` error handling -----
test_that("use_template test 6: invalid template", {
  expect_error(
    use_template(
      template = "ttt",
      function_name = "tryout",
      save_path = test_path,
      open = FALSE,
      package = "autoslideR"
    )
  )
})


test_that("use_template test 7: all templates", {
  all_templates <- basename(list_all_templates())
  for (template in all_templates) {
    expect_true(
      use_template(
        template = template, # invalid template
        function_name = paste0(template, "_test"),
        open = FALSE,
        overwrite = TRUE
      )
    )
  }
})


test_that("use_template test 5: all templates", {
  all_templates <- basename(list_all_templates())
  for (template in all_templates) {
    expect_true(
      use_template(
        template = template, # invalid template
        function_name = paste0(template, "_test"),
        open = FALSE,
        overwrite = TRUE
      )
    )
  }
})
