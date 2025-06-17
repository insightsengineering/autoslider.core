library(testthat)
library(rprojroot)

# Define the project root and test path
proj_root <- "~/autoslider.core"
test_path <- file.path(proj_root, "tests", "testthat")

# Create test path if it doesn't exist
if (!dir.exists(test_path)) dir.create(test_path, recursive = TRUE)

# test `list_all_templates` -----
test_that("list_all_templates test 1: returns all available templates", {
  expected <- c(
    "l_ae_slide", "g_mean_slides", "t_ae_pt_diff_slide", "t_ae_pt_slide",
    "t_ae_pt_soc_diff_slide", "t_ae_pt_soc_slide", "t_aesi_slide",
    "t_ae_slide", "t_ae_summary_slide", "t_dd_slide", "t_dm_slide",
    "t_dor_slide", "t_ds_slide"
  )

  actual <- list_all_templates()
  expect_setequal(actual, expected)
})



test_that("use_template test 2: saving when no path is specified", {
  file_location <- file.path("programs", "R", "tryout.R")


  use_template(
    template = "t_dm_slide",
    function_name = "tryout",
    open = FALSE
  )

  expect_snapshot_file(file_location)

  # Test overwrite logic
  expect_error(
    use_template(
      template = "t_dm_slide",
      function_name = "tryout",
      overwrite = FALSE,
      open = FALSE
    )
  )

  # Clean up
  # file.remove(file_location)

  use_template(
    template = "t_dm_slide",
    function_name = "tryout",
    overwrite = TRUE,
    open = FALSE
  )

  expect_snapshot_file(file_location)

  # Clean up
  file.remove(file_location)
})

test_that("use_template test 3: create folder when it does not exist", {
  new_dir <- file.path("random")
  expected_file <- file.path(new_dir, "folder_test.R")

  if (dir.exists(new_dir)) unlink(new_dir, recursive = TRUE)

  expect_false(dir.exists(new_dir))

  use_template(
    template = "t_dm_slide",
    function_name = "folder_test",
    save_path = new_dir,
    open = FALSE
  )

  expect_true(dir.exists(new_dir))
  expect_snapshot_file(expected_file)
})


# test `use_template` error handling -----
test_that("use_template test 4: expected errors", {
  expect_error(
    use_template(
      template = "ttt", # invalid template
      function_name = "tryout",
      open = FALSE
    )
  )
})
