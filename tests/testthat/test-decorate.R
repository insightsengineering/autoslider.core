set.seed(1)

sample_df <- data.frame(
  group = factor(rep(letters[1:3], each = 10)),
  value = rnorm(30)
)

group_means_df <- setNames(
  aggregate(value ~ group, sample_df, mean),
  c("group", "group_mean")
)
a <- ggplot(data = sample_df, mapping = aes(x = group, y = value)) +
  geom_point() +
  geom_point(
    mapping = aes(y = group_mean), data = group_means_df,
    colour = "red", size = 3
  )
aa <- list(a, a)


test_that("Test decoreate.grob not to throw", {
  p <- ggplotGrob(a)
  expect_no_error(decorate.grob(p, titles = "some title", footnotes = "some footnote"))
})


test_that("Test decoreate not to throw", {
  # test for decorate.autoslider_error
  e <- autoslider_error("error", list(program = "", suffix = ""), step = "test")
  expect_no_error(decorate.autoslider_error(e))

  # test for decorate.list
  expect_no_error(decorate.list(aa,
    titles = "some generic title",
    footnotes = "some generic footnotes"
  ))
})


test_that("Test print not to throw", {
  # print.decoratedGrob
  expect_no_error(print(aa[[2]]))

  # print.decoratedGrobSet
  expect_no_error(print(aa[2]))
  expect_no_error(print(aa))
})


test_that("Test decoreate throw", {
  expect_error(decorate.default(e), "default decorate function does not exist", ignore.case = TRUE)
})


test_that("Test ph_with_img not to throw", {
  p <- ggplotGrob(a)
  location_ <- officer::fortify_location(officer::ph_location_fullsize(), doc = read_pptx())
  width <- location_$width
  height <- location_$height
  fig_width <- 9
  fig_height <- 6
  figure_loc <- autoslider.core:::center_figure_loc(fig_width, fig_height, ppt_width = width, ppt_height = height)
  ppt <- read_pptx()
  ppt_master <- layout_summary(ppt)$master[1]
  ppt <- do_call(add_slide, x = ppt, master = ppt_master)
  expect_no_error(ph_with_img(ppt, p, fig_width, fig_height, figure_loc))
})
