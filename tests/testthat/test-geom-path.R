test_that("keep_mid_true drops leading/trailing FALSE", {
  expect_equal(keep_mid_true(c(FALSE, FALSE)), c(FALSE, FALSE))
  expect_equal(keep_mid_true(c(FALSE, TRUE, FALSE, TRUE, FALSE)), c(FALSE, TRUE, TRUE, TRUE, FALSE))
  expect_equal(keep_mid_true(c(TRUE, TRUE, FALSE, TRUE, FALSE)), c(TRUE, TRUE, TRUE, TRUE, FALSE))
  expect_equal(keep_mid_true(c(FALSE, TRUE, FALSE, TRUE, TRUE)), c(FALSE, TRUE, TRUE, TRUE, TRUE))
})

test_that("geom_path() throws meaningful error on bad combination of varying aesthetics", {
  p <- ggplot(economics, aes(unemploy/pop, psavert, colour = pop)) + geom_path(linetype = 2)
  expect_snapshot_error(ggplotGrob(p))
})

test_that("repair_segment_arrow() repairs sensibly", {
  group <- c(1,1,1,1,2,2)

  ans <- repair_segment_arrow(arrow(ends = "last"), group)
  expect_equal(ans$ends, rep(2L, 4))
  expect_equal(as.numeric(ans$length), c(0, 0, 0.25, 0.25))

  ans <- repair_segment_arrow(arrow(ends = "first"), group)
  expect_equal(ans$ends, rep(1L, 4))
  expect_equal(as.numeric(ans$length), c(0.25, 0, 0, 0.25))

  ans <- repair_segment_arrow(arrow(ends = "both"), group)
  expect_equal(ans$ends, c(1L, 3L, 2L, 3L))
  expect_equal(as.numeric(ans$length), c(0.25, 0, 0.25, 0.25))
})

# Tests on stairstep() ------------------------------------------------------------

test_that("stairstep() does not error with too few observations", {
  df <- data_frame(x = 1, y = 1)
  expect_silent(stairstep(df))
})

test_that("stairstep() exists with error when an invalid `direction` is given", {
  df <- data_frame(x = 1:3, y = 1:3)
  expect_snapshot(stairstep(df, direction = "invalid"), error = TRUE)
})

test_that("stairstep() output is correct for direction = 'vh'", {
  df <- data_frame(x = 1:3, y = 1:3)
  stepped_expected <- data_frame(x = c(1L, 1L, 2L, 2L, 3L), y = c(1L, 2L, 2L, 3L, 3L))
  stepped <- stairstep(df, direction = "vh")
  expect_equal(stepped, stepped_expected)
})

test_that("stairstep() output is correct for direction = 'hv'", {
  df <- data_frame(x = 1:3, y = 1:3)
  stepped_expected <- data_frame(x = c(1L, 2L, 2L, 3L, 3L), y = c(1L, 1L, 2L, 2L, 3L))
  stepped <- stairstep(df, direction = "hv")
  expect_equal(stepped, stepped_expected)
})

test_that("stairstep() output is correct for direction = 'mid'", {
  df <- data_frame(x = 1:3, y = 1:3)
  stepped_expected <- data_frame(x = c(1, 1.5, 1.5, 2.5, 2.5, 3), y = c(1L, 1L, 2L, 2L, 3L, 3L))
  stepped <- stairstep(df, direction = "mid")
  expect_equal(stepped, stepped_expected)
})


# Visual tests ------------------------------------------------------------

test_that("geom_path draws correctly", {
  set.seed(1)

  nCategory <- 5
  nItem <- 6
  df <- data_frame(category = rep(LETTERS[1:nCategory], 1, each = nItem),
                   item = paste("Item#", rep(1:nItem, nCategory, each = 1), sep = ''),
                   value = rep(1:nItem, nCategory, each = 1) + runif(nCategory * nItem) * 0.8)

  df2 <- df[c(1, 2, 7, 8, 13, 14, 3:6, 9:12, 15:nrow(df)), ]

  expect_doppelganger("lines",
    ggplot(df) + geom_path(aes(x = value, y = category, group = item))
  )
  expect_doppelganger("lines, changed order, should have same appearance",
    ggplot(df2) + geom_path(aes(x = value, y = category, group = item))
  )
  expect_doppelganger("lines, colour",
    ggplot(df) + geom_path(aes(x = value, y = category, group = item, colour = item))
  )
  expect_doppelganger("lines, colour, changed order, should have same appearance",
    ggplot(df2) + geom_path(aes(x = value, y = category, group = item, colour = item))
  )
})

test_that("NA linetype is dropped with warning", {
  df <- data_frame(x = 1:2, y = 1:2, z = "a")

  expect_snapshot_warning(expect_doppelganger(
      "NA linetype",
      ggplot(df, aes(x, y)) + geom_path(linetype = NA)
  ))
})
