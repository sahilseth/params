

context("write_sheet")

sheet = read_sheet(system.file("extdata/example.xlsx", package = "params"))

test_that("We can write an excel sheet", {
  ## read a excel sheet
  write_sheet(sheet, "example2.xlsx")
})

test_that("We can write an CSV sheet", {
  ## read a excel sheet
  write_sheet(sheet, "example2.csv")
})

test_that("We can write an tsv sheet", {
  ## read a excel sheet
  write_sheet(sheet, "example2.tsv")
})














# END
