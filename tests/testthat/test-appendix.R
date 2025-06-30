library(testthat)
# library(rprojroot)

# Define the project root and test path


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
  result <- postprocessing_doc(pptx, save_file = TRUE, doc_o = "example.pdf", type = "lab_sec")

  out_path <- file.path(test_path, "example_lab_sec.pptx")

  expect_s3_class(result, "rpptx")
  expect_true(file.exists(out_path))
})
