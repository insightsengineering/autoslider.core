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

