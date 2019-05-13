


#' default opts
opts = new.env()

get_opt_env <- function(){
  return(opts)
}



#' @rdname params
#' @export
get_opts = function(x, envir = opts, .use.names = FALSE){
  if(missing(x))
    x = ls(envir)
  out = mget(x, envir = envir, ifnotfound = list(NULL))

  if(length(x) == 1){
    # need to get a value, if length is 1, we expect a single char. string
    # in new R, this is causing concat of names:
    # wex.bed.targets.pad250.intervals.wex.bed.targets.pad250.intervals
    out = unlist(out, use.names = .use.names)

    # lets try a simple fix (assumming len is 1)
    # this needs more testing
    # this fails testing, adding check on length of output out
    if(length(out) == 1)
      names(out) = x

  }else{

    class(out) = c("opts", "list")

  }
  return(out)
}


#' @rdname params
#'
#' @importFrom tools assertCondition
#'
#' @export
set_opts = function(..., .dots, .parse = TRUE,
                    #.remove_period = T,
                    envir = opts){

  dots = list(...)

  msg = "any options can be defined, using name = value OR as a list supplied to .dots"

  if(!missing(.dots) & (length(dots) > 0))
    stop(msg)

  if(missing(.dots))
    .dots <- dots

  if(length(.dots) == 0)
    stop("seems no params were supplied using name=value OR as a named list")

  if(is.null(names(.dots)))
    stop("the elements of the list should be named OR supply params using name = value")

  stopifnot(is.list(.dots))

  if(.parse) ## auto-complete
    .dots = parse_opts(.dots, envir = envir)

  # if(.remove_period){
  #   nms = names(.dots)
  #   vars_to_be_renamed = grep("\\.", nms, value = T)
  #   if(length(vars_to_be_renamed) > 0){
  #     message("found . in some variable names, convering to _:\n",
  #             paste0(head(vars_to_be_renamed, 2), collapse = "\n"))
  #   }
  # }


  list2env(.dots, envir = envir)

  invisible(get_opts(names(.dots), envir = envir))
}


#' @rdname params
#' @export
print.opts <- function(x, ...){
  if(length(x) > 1){
    #message("\nPrinting list of options as a pretty table.")
    ## removing options which are NULL
    y = cbind(lapply(x, function(f) {
      Filter(Negate(is.null), f)
    }))
    y = try(data.frame(name = rownames(y), value = y, row.names = NULL, stringsAsFactors = FALSE), silent = TRUE)
    if(class(y) == "try-error"){
      message("some options not found, unable to create a pretty table, returning a simple list.")
      class(x) = "list"
      print(x)
    }else{
      print(kable(y, row.names = FALSE), ...)
    }
    ## following does not handle null values well
    # print(kable(t(as.data.frame(x, row.names = names(x)))))
  } else(print.default(x, ...))
}



