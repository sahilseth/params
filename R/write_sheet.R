#' @rdname read_sheet
#' @export
#' @importFrom utils write.table
#'
write_sheet <- function(x, file, ext, ...){
  if(missing(ext))
    ext <- file_ext(file)

  dir.create(dirname(file), recursive = TRUE, showWarnings=FALSE)

  if(ext %in% c("tsv", "txt", "conf", "def", "mat")){
    write.table(x = x, file = file, sep = "\t", row.names = FALSE, quote = FALSE, ...)

  }else if(ext=="csv"){
    write.table(x = x, file = file, sep = ",", row.names = FALSE, quote = FALSE, ...)

  }else if(ext=="xlsx"){
    if (!requireNamespace('openxlsx', quietly = TRUE)) {
      stop("openxlsx needed for this function to work. Please install it.",
           call. = FALSE)
    }
    openxlsx::write.xlsx(x, file = file, colNames = TRUE, ...)

    if(type == "table"){
      if(!is.list(x))
        stop("x is not a list!")

      message("write to excel...")
      wb <- createWorkbook()
      sheets <- lapply(names(x), addWorksheet, wb = wb, gridLines = F)
      tmp = map2(names(x), lst, writeDataTable, wb = wb, bandedRows = F, tableStyle = "TableStyleLight1")
      saveWorkbook(wb, file, overwrite = T)
    }

  }else{
    stop("Sorry write_sheet does not recognize this file format: ", ext,
         " please use tsv, csv or xlsx")
  }

}



write_sheets <- function(lst, file){
  wb <- createWorkbook()
  sheets <- lapply(names(lst), addWorksheet, wb = wb, gridLines = F)
  tmp = map2(names(lst), lst, writeDataTable, wb = wb, bandedRows = F, tableStyle = "TableStyleLight1")
  saveWorkbook(wb, file, overwrite = T)

}





# END
