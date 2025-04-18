test_that("binwidth is respected", {
  df <- data_frame(x = c(1, 1, 1, 2), y = c(1, 1, 1, 2))
  base <- ggplot(df, aes(x, y)) +
    stat_bin_2d(geom = "tile", binwidth = 0.25)

  out <- get_layer_data(base)
  expect_equal(nrow(out), 2)
  # Adjust tolerance to account for fuzzy breaks adjustment
  expect_equal(out$xmin, c(1, 1.75), tolerance = 1e-7)
  expect_equal(out$xmax, c(1.25, 2), tolerance = 1e-7)

  p <- ggplot(df, aes(x, y)) +
    stat_bin_2d(geom = "tile", binwidth = c(0.25, 0.5, 0.75))
  expect_snapshot_warning(ggplot_build(p))

  p <- ggplot(df, aes(x, y)) +
    stat_bin_2d(geom = "tile", boundary = c(0.25, 0.5, 0.75))
  expect_snapshot_warning(ggplot_build(p))
})

test_that("breaks override binwidth", {
  # Test explicitly setting the breaks for x, overriding
  # the binwidth.
  integer_breaks <- (0:4) - 0.5  # Will use for x
  half_breaks <- seq(0, 3.5, 0.5)  # Will test against this for y

  df <- data_frame(x = 0:3, y = 0:3)
  base <- ggplot(df, aes(x, y)) +
    stat_bin_2d(
      breaks = list(x = integer_breaks, y = NULL),
      binwidth = c(0.5, 0.5)
    )

  out <- get_layer_data(base)
  expect_equal(out$xbin, cut(df$x, bins(integer_breaks)$fuzzy, include.lowest = TRUE, labels = FALSE))
  expect_equal(out$ybin, cut(df$y, bins(half_breaks)$fuzzy, include.lowest = TRUE, labels = FALSE))
})

test_that("breaks are transformed by the scale", {
  df <- data_frame(x = c(1, 10, 100, 1000), y = 0:3)
  base <- ggplot(df, aes(x, y)) +
    stat_bin_2d(
      breaks = list(x = c(5, 50, 500), y = c(0.5, 1.5, 2.5)))

  out1 <- get_layer_data(base)
  out2 <- get_layer_data(base + scale_x_log10())
  expect_equal(out1$x, c(27.5, 275))
  expect_equal(out2$x, c(1.19897, 2.19897))
})
