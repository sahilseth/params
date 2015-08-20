
[![Build Status](https://travis-ci.org/sahilseth/params.png)](https://travis-ci.org/sahilseth/params)
[![](http://www.r-pkg.org/badges/version/params)](http://cran.rstudio.com/web/packages/flowr/index.html)
![](http://cranlogs.r-pkg.org/badges/grand-total/params)


## Rationale
 > Setting/loading and extracting various options into the environment

> A package level alternative for `options` and `getOptions`, to prevent cluterring the space. 

- ability to store all default options as a tab delimited table
- automatically check if file.path exists for options relating to files.
- fetch multiple options as list
- print options as a pretty table


## Main functions

- set_opts(): set options into a custom envir
- get_opts(): extract options
- load_opts(): Read a tab/comma delimted file using read_sheet and load them as options using set_opts
- new_opts(): create a options manager to be included in a pacakge
- print.opts(): print pkg options as a pretty table



## Setting up some options


```
library(params)
set_opts(
	name = "Sahil",
	verbose = TRUE, 
	my_dir = "~/mypath")
get_opts()	
```

get_opts, shows all available options:

```
name            value        
--------------  -------------
default_regex   (.*)         
my_conf_path    ~/flowr/conf 
my_dir          ~/mypath     
my_path         ~/flowr      
my_tool_exe     /usr/bin/ls  
name            Sahil        
verbose         TRUE  
```

### Get a specific value:

`get_opts("my_dir")`


## Load several options from a conf file

```
conf = system.file("conf/params.conf", package = "params")
```

### load the config file

- check if file.path exists if params end with exe, dir or path

```
load_opts(conf)
```

### auto-complete and checking
- use {{{myparam}}} to reference previous params

```
set_opts(first = "sahil",
	last = "seth",
	full = "{{{first}}} {{{last}}}")
get_opts('full')
"sahil seth"
```
- both set_opts and load_opts, support auto-complete



### Using params in your own package

params creates a environment object and stores all parameters in that object. Thus multiple using params packages may be loaded each with a separate set of params.

one liner to to be included in a package !

```
myopts = new_opts()
```

The above object provides three functions to load, set and fetch params:

- myopts$get()
- myopts$set()
- myopts$load()




**Here is a example conf file:**:

```
## ----------------------- p a r a m s     config ------------------------ ##
## the file by default, sits in the R pacakge
## --------------------------------------------------------------------- ##

## Following lines, as a tab delimited table, with two columns
## Always use load_conf(); after editing this file !

## options ending with path, exe or dir are checked for existence. file.exists
my_path	~/flowr
my_tool_exe	/usr/bin/ls
my_dir	path/to/a/folder


## you can define nested options
## these are parsed line by line

my_conf_path	{{{my_path}}}/conf

## --- all options are parsed as chracter
default_regex	(.*)
```

### Installation


```
install.packages("params")
devtools::install_github("sahilseth/params")
```


