# https://r-pkgs.org/data.html#data-extdata
# Data for tests: it’s ok to put small files directly in your test directory.
# But remember unit tests are for testing correctness, not performance, so keep the size small.
#
# Data for vignettes. If you want to show how to work with an already loaded dataset, put that data in data/.
# If you want to show how to load raw data, put that data in inst/extdata.
#


context("read_sheet")

test_that("We can read an excel sheet", {
  ## read a excel sheet
  sheet = read_sheet(system.file("extdata/example.xlsx", package = "params"))
  expect_true(is.data.frame(sheet))
})

test_that("We can read an csv sheet", {
  sheet = read_sheet(system.file("extdata/example.csv", package = "params"))
  expect_true(is.data.frame(sheet))
})

test_that("We can read an tsv sheet", {
  sheet = read_sheet(system.file("extdata/example.tsv", package = "params"))
  expect_true(is.data.frame(sheet))
})


test_that("We can write an conf sheet", {
  ## read a conf file
  sheet = read_sheet(system.file("extdata/example.conf", package = "params"))
  expect_true(is.data.frame(sheet))
})












# END
