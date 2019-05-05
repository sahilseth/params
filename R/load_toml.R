#' @rdname params
#' @seealso \link{read_sheet}
#'
#' @importFrom RcppTOML parseToml
#' @export
load_toml <- function(toml, envir = envir){


  str_toml = unlist(parseToml(toml))
  lst_toml = split(str_toml, names(str_toml))
  set_opts(.dots = lst_toml, .parse = TRUE, envir = envir)


}
