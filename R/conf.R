

#' @export
.load_opts <- function(x, check, envir, verbose, .parse, ...){

	if(!file.exists(x)){
		message("Configuration file does not exist, loading skipped. Expecting a file at:", x)
		return()
	}
	conf <- read_sheet(x, allowEscape = TRUE, header = FALSE, verbose = verbose)
	colnames(conf) = c("name", "value")
	lst = as.list(conf$value)
	names(lst) = conf$name

	## for auto-completion its best to have
	lst2 = get_opts(envir = envir)
	lst = c(lst2, lst)

	if(.parse)
		lst = parse_opts(lst, envir = envir)

	## -- check the ones with file paths
	if(check)
		chk_conf(lst)
	#options(lst)
	set_opts(.dots = lst, envir = envir)
	#opts()$set(lst)
	## -- populate these in the global environment
	invisible(get_opts(names(lst)))
}

#' @rdname params
#' @seealso \link{read_sheet}
#' @export
load_opts <- function(x, check = TRUE, envir = opts, verbose = TRUE, .parse = TRUE, ...){

	if(missing(x))
		stop("Please supply path to a file to load as x")

	## .load_opts: works on a single file
	lst <- lapply(x, .load_opts, check = check, envir = envir, .parse = .parse, verbose = verbose,  ...)

	## only one conf file is read
	if(length(x) == 1)
		lst = lst[[1]]

	## return them as a list
	invisible(lst)
}

load_conf <- function(...){
	.Deprecated(load_opts)
	load_opts(...)
}

## process conf line by line
## use whisker to evaluate the string, given available data

#' parse_opts
#' @param lst a list of configuration options to parse
#'
#'
#' @import whisker
parse_opts <- function(lst, envir){

	## get values from previous envir
	## which are being called by name in newer options
	## example {{{mydir}}}
	get_vars <- function(x){
		unlist(regmatches(x, gregexpr('(?<=\\{\\{)[[:alnum:]_.]+(?=\\}\\})', x, perl=TRUE)))
	}

	vars = get_vars(unlist(lst))
	#x = get_opts(c("var", unlist(vars)), envir = envir) ## ensure, always a list
	x = as.list(get_opts(vars), envir = envir) ## ensure, always a list

	## if there are multiple elements with the same name
	## this ensures we take the last/latest element
	lst = c(x, lst)
	lst = rev(lst)
	lst = lst[!duplicated(names(lst))]

	## handling duplicates
	## if a option is set multiple times, we consider the last one.

	## --- sequentially evaluae each configuration
	for(i in 1:length(lst)){
		## resolve ONLY when neccesary
		if(length(get_vars(lst[[i]])) > 0)
			lst[[i]] = whisker.render(lst[[i]], lst, debug = TRUE)
	}
	return(lst)
}


chk_conf <- function(x){
	path_pattern = c("path$|dir$|exe$")
	pths = grep(path_pattern, names(x))
	mis_pths = !(file.exists(as.character(x)[pths]))
	if(sum(mis_pths) > 0){
		msg = "\n\nSeems like these paths do not exist, this may cause issues later:\n"
		df = data.frame(name = names(x)[mis_pths],
										value = as.character(x)[mis_pths])
		warning(msg, collapse = "\n")
		print(kable(df, row.names = FALSE))
	}
}








