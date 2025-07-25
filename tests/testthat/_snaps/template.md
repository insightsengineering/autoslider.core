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

