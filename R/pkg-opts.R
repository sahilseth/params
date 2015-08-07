


#' @export
new_opts <- function(opts = new.env()){

	get_opts <- function(x){
		params::get_opts(x, envir = opts)
	}

	#' @importFrom params set_opts
	#' @export
	set_opts <- function(..., .dots){
		params::set_opts(..., .dots = .dots, envir = opts)
	}

	#' @importFrom params set_opts
	#' @export
	load_conf <- function(...){
		params::load_conf(..., envir = opts)
	}

	list(get=get_opts, set=set_opts, load = load_conf)

}
