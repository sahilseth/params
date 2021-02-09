#' @rdname params
#' @seealso \link{read_sheet}
#'
#' @importFrom RcppTOML parseToml
#' @export
load_toml <- function(toml, .remove_period = T, envir = envir, verbose = T){

  # get a flattened vector
  str_toml = unlist(parseToml(toml))
  # convert into a named list
  lst_toml = split(str_toml, names(str_toml))

  # convert . into _, and keep both variables (more busy, but less confusing)
  if(.remove_period){
    if(verbose)
      message("removing period, but keeping both variables for legacy purposes")
    lst_toml = .remove_period_from_nms(lst_toml, verbose)
  }
  # finally set these into the env
  set_opts(.dots = lst_toml, .parse = TRUE, envir = envir)
}
