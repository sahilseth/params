

#' @rdname params
#' @title Setting/loading and extracting various options into the environment
#'
#' @aliases get_opts set_opts print.opts params
#'
#' @description
#' \itemize{
#' \item set_opts(): set options into a custom envir
#' \item get_opts(): extract options
#' \item load_opts(): Read a tab delimted file using \link{read_sheet} and load them as options using \link{set_opts}
#' \item new_opts(): create a options manager to be included in a pacakge
#' \item print.opts(): print pkg options as a pretty table
#'}
#'
#' @param x \itemize{
#' \item get_opts: a character vector of names of options to extract.
#' \item load_opts: path to a configuration file
#' }
#'
#' @param ... set_opts(): a named set of variable/value pairs seperated by comma
#' @param .dots set_opts(): A named list, as a alternative to ...
#' @param envir environ used to store objects
#' @param check load_opts(): in case of a configuration file, whether to check if files defined in parameters exists..
#' @param verbose load_opts()be chatty ?

#' @details
#'
#' \subsection{Integrating \link{params} in a package:}{
#' ## create a options manager:
#' \code{
#' opts_mypkg = new_opts()
#' }
#'
#' The object \code{opts_mypkg} is a list of a few functions, which set, fetch and load
#' options in a isolated environment. Here are a few examples of how you might really use them:
#'
#' ## Set some options:
#' \code{opts_mypkg$set(version = '0.1', name = 'mypkg')}
#'
#' ## Fetch ALL options:
#' \code{opts_mypkg$get()}
#' OR
#' \code{opts_mypkg$get("version")}
#'
#' }
#'
#'
#' \subsection{Loading configuration files, \code{load_opts()} OR \code{opts_pkg$load()}:}{
#' There are cases when options and params are actually paths to scripts or other apps or folders etc.
#' In such cases it might be useful to quickly check if these paths exists on the sytem.
#' As such load_opts() automatically checks params ending with \code{path|dir|exe} (if check=TRUE).
#' }
#'
#' Below is a list example options, retrieved via
#'
#' \code{get_opts()}:
#'
#' \Sexpr[results=verbatim]{params::get_opts()}

#'
#' @seealso \link{read_sheet} \link{load_opts}
#'
#' @export
#'
#' @examples
#' ## set_opts
#' opts = set_opts(flow_run_path = "~/mypath")
#' #OR
#' opts = set_opts(.dots = list(flow_run_path = "~/mypath"))
#'
#' print(opts)
#'
#' ## get_opts()
#' get_opts()
#' get_opts("flow_run_path")
#'
#' ## create a options manager:
#' opts_mypkg = new_opts()
#' opts_mypkg$set(version = '0.1', name = 'mypkg')
#' opts_mypkg$get()
#'
new_opts <- function(envir = new.env()){

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
	load_opts <- function(...){
		params::load_opts(..., envir = opts)
	}

	list(get=get_opts, set=set_opts, load = load_opts)

}
