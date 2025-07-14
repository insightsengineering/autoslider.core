test_path <- tempdir()

test_that("initialize_to_page test 1: when to_page is null", {
  doc <- officer::read_pptx()
  doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")

  to_page <- initialize_to_page(doc, NA)
  expect_equal(to_page, 1)
})

test_that("initialize_to_page test 2: given to_page value", {
  doc <- officer::read_pptx()
  doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")
  doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")

  to_page <- initialize_to_page(doc, 2)
  expect_equal(to_page, 2)
})

test_that("initialize_to_page test 3: if to_page is too large", {
  doc <- officer::read_pptx()
  doc <- officer::add_slide(doc, layout = "Title Slide", master = "Office Theme")

  expect_error(initialize_to_page(doc, 99))
})



test_that("postprocessing_doc test 1: save_file = TRUE", {
  temp_path <- file.path(test_path, "save.pptx")
  out_path <- file.path(test_path, "save_testoutput.pptx")

  # Create minimal pptx and save to temp path
  ppt <- officer::read_pptx()
  print(ppt, temp_path)

  doc <- officer::read_pptx(temp_path)
  result <- postprocessing_doc(doc, save_file = TRUE, doc_o = temp_path, type = "testoutput")

  expect_s3_class(result, "rpptx")
  expect_true(file.exists(out_path))

  file.remove(out_path)
})

test_that("postprocessing_doc test 2: save_file = FALSE", {
  pptx <- officer::read_pptx()
  result <- postprocessing_doc(pptx, save_file = FALSE, doc_o = "placeholder.pptx")
  out_path <- file.path(test_path, "placeholder.pptx")
  expect_s3_class(result, "rpptx")
  expect_false(file.exists(out_path))
})


test_that("postprocessing_doc test 3: doc_o is not a ppt", {
  pptx <- officer::read_pptx()
  expect_error(postprocessing_doc(pptx, save_file = TRUE, doc_o = "example.pdf", type = "lab_sec"))
})



test_that("initialize_doc_original test 1: returns existing doc_original", {
  doc <- officer::read_pptx()

  result <- initialize_doc_original(doc, "dummy_path.pptx")
  expect_identical(result, doc)
})

test_that("initialize_doc_original test 2: reads from file when doc_original is NULL", {
  doc_o <- tempfile(fileext = ".pptx")

  minimal_pptx <- officer::read_pptx() %>%
    officer::add_slide(layout = "Title and Content", master = "Office Theme")
  print(minimal_pptx, target = doc_o)

  result <- initialize_doc_original(NULL, doc_o)

  expect_s3_class(result, "rpptx")
})



test_that("append_title_slides test 1: save file", {
  temp_pptx_file <- tempfile(fileext = ".pptx")
  on.exit(unlink(temp_pptx_file), add = TRUE)

  officer::read_pptx() %>% print(target = temp_pptx_file)

  expected_output_file <- file.path(
    dirname(temp_pptx_file),
    paste0(tools::file_path_sans_ext(basename(temp_pptx_file)), "_title.pptx")
  )
  on.exit(unlink(expected_output_file), add = TRUE) # Clean up output file


  doc_result_saved <- append_title_slides(
    doc_o = temp_pptx_file,
    study_id = "Test Study",
    to_page = 1,
    save_file = TRUE
  )

  expect_s3_class(doc_result_saved, "rpptx")
  expect_true(file.exists(expected_output_file))
  expect_equal(length(doc_result_saved), 1) # One slide added
})

test_that("append_section_header_slides test 1: not save file", {
  temp_pptx_file <- tempfile(fileext = ".pptx")
  on.exit(unlink(temp_pptx_file), add = TRUE)

  officer::read_pptx() %>% print(target = temp_pptx_file)

  expected_output_file <- file.path(
    dirname(temp_pptx_file),
    paste0(tools::file_path_sans_ext(basename(temp_pptx_file)), "_section_header.pptx")
  )
  on.exit(unlink(expected_output_file), add = TRUE) # Clean up output file


  doc_result_not_saved <- append_section_header_slides(
    doc_o = temp_pptx_file,
    section_title = "Another Section",
    to_page = 1,
    save_file = FALSE
  )

  expect_s3_class(doc_result_not_saved, "rpptx")
  expect_false(file.exists(file.path(
    dirname(temp_pptx_file),
    paste0(
      tools::file_path_sans_ext(basename(temp_pptx_file)),
      "_section_header.pptx"
    )
  )))
  expect_equal(length(doc_result_not_saved), 1) # One slide added
})

test_that("append_all_slides correctly adds multiple slides based on page_list", {
  temp_pptx_file <- tempfile(fileext = ".pptx")
  on.exit(unlink(temp_pptx_file), add = TRUE)

  officer::read_pptx() %>% print(target = temp_pptx_file)

  expected_output_file <- file.path(
    dirname(temp_pptx_file),
    paste0(tools::file_path_sans_ext(basename(temp_pptx_file)), "_final.pptx")
  )
  on.exit(unlink(expected_output_file), add = TRUE) # Clean up output file

  my_page_list <- list(
    list(type = "title", to_page = 1, study_id = "Project Alpha"),
    list(type = "section", to_page = 2, section_title = "Phase 1 Data"),
    list(type = "title", to_page = 3, study_id = "Project Beta"),
    list(type = "section", to_page = 4, section_title = "Phase 2 Results")
  )

  doc_result_saved <- append_all_slides(
    doc_o = temp_pptx_file,
    page_list = my_page_list,
    save_file = TRUE
  )

  expect_s3_class(doc_result_saved, "rpptx")
  expect_true(file.exists(expected_output_file))
  expect_equal(length(doc_result_saved), length(my_page_list))


  doc_empty_list <- append_all_slides(
    doc_o = temp_pptx_file,
    page_list = list(),
    save_file = FALSE
  )
  expect_s3_class(doc_empty_list, "rpptx")
  expect_equal(length(doc_empty_list), 0) # Should have 0 slides if initial doc is empty
})

test_that("append_all_slides test 2: error if page_list exceeds max_pages + 1", {
  temp_pptx_file <- tempfile(fileext = ".pptx")
  on.exit(unlink(temp_pptx_file), add = TRUE)

  officer::read_pptx() %>% print(target = temp_pptx_file)

  invalid_page_list <- list(
    list(type = "title", to_page = 1, study_id = "Valid First Slide"),
    list(type = "section", to_page = 3, section_title = "Invalid Page Number")
  )

  expect_error(
    append_all_slides(
      doc_o = temp_pptx_file,
      page_list = invalid_page_list,
      save_file = FALSE
    )
  )
})
