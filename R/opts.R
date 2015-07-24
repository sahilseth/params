#' @export
opts = new.env()

#' @rdname opts
#'
#' @title Setting/loading and extracting various options into the environment
#' @description
#' load_conf:
#' This function extracts the options set by functions like set_opts/load_conf
#' @aliases get_opts set_opts print.opts
#'
#' @param x get_opts(): a character vector of names of options to extract.
#' set_opts(): a named list with all the options to be set.
#' @param envir environ used to store objects
#' @param ... not used
#'
#' @seealso \link{load_conf}
#' @export
#' @importFrom knitr kable
#' @examples
#' get_opts()
#' get_opts("flow_run_path")
get_opts = function(x, envir = opts){
	if(missing(x))
		x = ls(envir)
	out = mget(x, envir = envir, ifnotfound = list(NULL))
	if(length(x) == 1){
		out = unlist(out)
	}else{
		class(out) = c("opts", "list")
	}
	return(out)
}


#' @rdname opts
#'
#' @examples
#' ## set _opts
#' set_opts(list(flow_run_path = "~/mypath"))
#'
#' @export
set_opts = function(x, envir = opts){

	## should be a named list
	stopifnot(is.list(x))
	stopifnot(!is.null(names(x)))

	list2env(x, envir = envir)
	invisible()
}


#' @rdname opts
#' @description print pkg options as a pretty table
#'
#' @importFrom knitr kable
#'
#' @details In case of print.opts(), param ... is passed onto print.
#' @export
print.opts <- function(x, ...){
	if(length(x) > 1){
		#message("\nPrinting list of options as a pretty table.")
		y = cbind(lapply(x, function(f) {
			unlist(as.data.frame(Filter(Negate(is.null), f)))
		}))
		print(kable(y, col.names = c("")), ...)
		## following does not handle null values well
		# print(kable(t(as.data.frame(x, row.names = names(x)))))
	}
	else(print.default(x, ...))
}

