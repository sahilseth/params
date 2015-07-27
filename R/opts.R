



opts = new.env()



#' @rdname params
#' @export
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


#' @rdname params
#' @export
set_opts = function(..., .dots, envir = opts){

	if(missing(.dots))
		.dots = list(...)
	## should be a named list
	stopifnot(is.list(.dots))
	stopifnot(!is.null(names(.dots)))

	list2env(.dots, envir = envir)
	invisible()
}


#' @rdname params
#' @importFrom knitr kable
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


#' @aliases get_opts set_opts print.opts
#' @title Setting/loading and extracting various options into the environment
#'
#' @description
#' \itemize{
#' \item set_opts(): set options into a custom envir
#' \item get_opts()/params(): extract options
#' \item print.opts(): print pkg options as a pretty table
#'}
#'
#' @param x a character vector of names of options to extract.
#' @param ... set_opts(): a named set of variable/value pairs seperated by comma
#' @param .dots set_opts(): A named list, as a alternative to ...
#' @param envir environ used to store objects
#'
#' @details
#' To use params in your package, follow this these steps: \url{https://github.com/sahilseth/params}
#'
#' @seealso \link{read_sheet} \link{load_conf}
#' @export
#' @examples
#' ## set _opts
#' opts = set_opts(flow_run_path = "~/mypath")
#' #OR
#' opts = set_opts(.dots = list(flow_run_path = "~/mypath"))
#' print(opts)
#' ## get_opts()
#' get_opts()
#' get_opts("flow_run_path")
#'
params = get_opts
