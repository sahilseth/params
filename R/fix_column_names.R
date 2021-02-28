#' fix_names
#'
#' Replace special characters in column names of a data.frame
#'
#' @param x a vector of column names
#' @param char substitute special char with this.
#'
#' @export
#'
#' @seealso make.names
#'
fix_names <- function (x, char = "_"){

  x <- gsub("\\ ", "", as.character(x), fixed = TRUE)
  x <- gsub("_", char, as.character(x), fixed = TRUE)
  x <- gsub("-", char, as.character(x), fixed = TRUE)
  x <- gsub(" ", char, as.character(x), fixed = TRUE)
  x <- gsub(".", char, as.character(x), fixed = TRUE)

  return(x)
}


#' fix_column_names
#'
#' removes special chars from names
#'
#' @param x a character vector
#' @param char replace special characters with this symbol
#'
fix_column_names <- function(x, char = "_"){
  x = strsplit(x, split = "\n")
  x = unlist(x)# %>%
    #stringr::str_trim()

  x = fix_names(x, char)
  x = make.names(x)
  x = tolower(x)

  cat(paste(x, collapse = "\n"))
  invisible(x)
}



