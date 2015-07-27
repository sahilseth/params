
#' A simple wrapper around write.table with some sugar.
#' @param x a data.frame
#' @param file output file
#' @export
#' @importFrom utils write.table
write_sheet <- function(x, file){
	write.table(x = x, file = file, sep = "\t", row.names = FALSE, quote = FALSE)
}
