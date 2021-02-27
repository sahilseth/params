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

  x <- gsub("_", char, as.character(x), fixed = TRUE)
  x <- gsub("-", char, as.character(x), fixed = TRUE)
  x <- gsub(" ", char, as.character(x), fixed = TRUE)
  x <- gsub(".", char, as.character(x), fixed = TRUE)

  return(x)
}


fix_column_names <- function(x, char = "_"){
  x %<>% strsplit(split = "\n") %>% unlist() %>%
    stringr::str_trim()

  x = fix_names(x, char) %>% make.names() %>% tolower()

  paste(x, collapse = "\n") %>% cat()
  invisible(x)
}



