


#' default opts
opts = new.env()

get_opt_env <- function(){
	return(opts)
}



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
#'
#' @importFrom tools assertCondition
#'
#' @export
set_opts = function(..., .dots, envir = opts){

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
		y = data.frame(name = rownames(y), value = unlist(y[,1]))
		print(kable(y, row.names = FALSE), ...)
		## following does not handle null values well
		# print(kable(t(as.data.frame(x, row.names = names(x)))))
	}
	else(print.default(x, ...))
}


#' @rdname params
#' @title Setting/loading and extracting various options into the environment
#'
#' @aliases get_opts set_opts print.opts
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
