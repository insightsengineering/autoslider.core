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
