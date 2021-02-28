#' @rdname read_sheet
#' @export
#' @importFrom utils write.table
#' @importFrom readr write_delim
#' @importFrom purrr map2
write_sheet <- function(x, file, ext, type = "", ...){
  if(missing(ext)){
    # ext <- tools::file_ext(file)
    filenm = tools::file_path_sans_ext(file, compression = T)
    filenm = paste0(filenm, ".")
    ext = gsub(filenm, "", file)
  }

  dir.create(dirname(file), recursive = TRUE, showWarnings=FALSE)

  if(ext %in% c("tsv", "txt", "conf", "def", "mat", "tsv.gz", "tsv.xz", "tsv.bz2")){
    write_delim(x = x, file = file, delim = "\t", quote_escape = "double", ...)

    # write.table(x = x, file = file, sep = "\t", row.names = FALSE, quote = FALSE, ...)

  }else if(ext %in% c("csv", "csv.gz", "csv.bz2", "csv.xz")){
    write_delim(x = x, file = file, delim = ",", quote_escape = "double", ...)

    #write.table(x = x, file = file, sep = ",", row.names = FALSE, quote = FALSE, ...)

  }else if(ext=="xlsx"){
    if (!requireNamespace('openxlsx', quietly = TRUE)) {
      stop("openxlsx needed for this function to work. Please install it.",
           call. = FALSE)
    }

    if(type == "table"){
      if(!is.list(x))
        stop("x is not a list!")

      message("write to excel...")
      wb <- openxlsx::createWorkbook()
      sheets <- lapply(names(x), openxlsx::addWorksheet, wb = wb, gridLines = F)
      tmp = purrr::map2(names(x), x, openxlsx::writeDataTable, wb = wb, bandedRows = F, tableStyle = "TableStyleLight1")
      openxlsx::saveWorkbook(wb, file, overwrite = T)
    }else{
      openxlsx::write.xlsx(x, file = file, colNames = TRUE, ...)
    }

  }else{
    stop("Sorry write_sheet does not recognize this file format: ", ext,
         " please use tsv, csv or xlsx")
  }

}



write_sheets <- function(lst, file){
  wb <- openxlsx::createWorkbook()
  sheets <- lapply(names(lst), openxlsx::addWorksheet, wb = wb, gridLines = F)
  tmp = map2(names(lst), lst, openxlsx::writeDataTable, wb = wb, bandedRows = F, tableStyle = "TableStyleLight1")
  openxlsx::saveWorkbook(wb, file, overwrite = T)

}





# END
