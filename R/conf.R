
.load_conf <- function(x, check, verbose,...){

	if(!file.exists(x)){
		message("Configuration file does not exist, loading skipped. Expecting a file at:", x)
		return()
	}
	conf <- read_sheet(x, allowEscape = TRUE, header = FALSE, verbose = verbose)
	colnames(conf) = c("name", "value")
	lst = as.list(conf$value)
	names(lst) = conf$name

	lst = parse_conf(lst)

	## -- check the ones with file paths
	if(check)
		chk_conf(lst)
	options(lst)
	set_opts(.dots = lst)
	#opts()$set(lst)
	## -- populate these in the global environment
	invisible(get_opts(names(lst)))
}

#' @title
#' Loading configuration files.
#' @description
#' Read a tab delimted file and load them as options using \link{set_opts}
#' @description load a configuration file into the environment
#' @param x path to a configuration file
#' @param check in case of a configuration file, whether to check if files defined in parameters exists..
#' @param verbose be chatty ?
#' @param ... Not used
#'
#' @details params ending in: "path$|dir$|exe$" are checked in case of check=TRUE.
#'
#' @seealso \link{get_opts} \link{set_opts} \link{print.opts} \link{read_sheet}
#' @export
load_conf <- function(x, check = TRUE, verbose = TRUE, ...){
	## .load_conf: works on a single file
	lst <- lapply(x, .load_conf, check = check, verbose = verbose, ...)

	## only one conf file is read
	if(length(x) == 1)
		lst = lst[[1]]

	invisible(lst)
}

## process conf line by line
## use whisker to evaluate the string, given available data

#' parse_conf
#' @param lst a list of configuration options to parse
#'
#'
#' @import whisker
parse_conf <- function(lst){
	## --- sequentially evaluae each configuration
	for(i in 1:length(lst)){
		lst[[i]] = whisker.render(lst[[i]], lst)
	}
	return(lst)
}


chk_conf <- function(x){
	path_pattern = c("path$|dir$|exe$")
	pths = grep(path_pattern, names(x))
	mis_pths = !file.exists(as.character(x)[pths])
	if(sum(mis_pths) > 0){
		msg = "\n\nSeems like these paths do not exist, this may cause issues later:\n"
		df = data.frame(name = names(x)[mis_pths],
										value = as.character(x)[mis_pths])
		warning(msg, paste(kable(df, row.names = FALSE), collapse = "\n"))
	}
}




