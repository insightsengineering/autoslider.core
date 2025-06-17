# use_template test 2: saving when no path is specified

    Code
      use_template(template = "t_dm_slide", function_name = "tryout", save_path = test_path,
        open = FALSE)
    Message
      ✓ File '/tmp/Rtmp5Yy346/tryout.R' has been created successfully

---

    Code
      use_template(template = "t_dm_slide", function_name = "tryout", save_path = test_path,
        overwrite = TRUE, open = FALSE)
    Message
      ✓ File '/tmp/Rtmp5Yy346/tryout.R' has been created successfully

# use_template test 3: create folder when it does not exist

    Code
      use_template(template = "t_dm_slide", function_name = "folder_test", save_path = new_dir,
        open = FALSE)
    Message
      ✓ File 'random/folder_test.R' has been created successfully

