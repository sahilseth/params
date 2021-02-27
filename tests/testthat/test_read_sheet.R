

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
