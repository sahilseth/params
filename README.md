
[![Build Status](https://travis-ci.org/sahilseth/params.svg)](https://travis-ci.org/sahilseth/params)
[![](http://www.r-pkg.org/badges/version/params)](http://cran.rstudio.com/web/packages/flowr/index.html)
![](http://cranlogs.r-pkg.org/badges/grand-total/params)

## Rationale
> Setting/loading and extracting various options from/into the R environment

> A package level alternative for `options` and `getOptions`, to prevent cluterring the space. 

## Main Features

- **load from files**: ability to store all default options as a tab delimited OR comma delimited files
- **check options**: if a option relates to a file path, automatically check if it exists
- **embeddable** set OR retrieve multiple options as list
- **clean**: print all or few options as a pretty table


## Main functions

- `set_opts()`: set options into a custom environment
- `get_opts()`: retrieve options from a custom environment
- `load_opts()`: Read a tab/comma delimited file using `read_sheet()` and load them using `set_opts()`
- `new_opts()`: create a options manager (to be used in a R package etc...)
- `print.opts()`: print options as a pretty table, used by `get_opts()`



## Examples: 

**Setting up some options**

```
library(params)
set_opts(
	name = "John",
	verbose = TRUE, 
	my_dir = "~/mypath")
get_opts()	
```

**Retrieving all options** using `get_opts()`

```
name            value        
--------------  -------------
default_regex   (.*)         
my_conf_path    ~/flowr/conf 
my_dir          ~/mypath     
my_path         ~/flowr      
my_tool_exe     /usr/bin/ls  
name            John        
verbose         TRUE  
```

**Retrieving a specific option**

`get_opts("my_dir")`


**Loading several options from a conf file**


```
conf = system.file("conf/params.conf", package = "params")
load_opts(conf)
```

**Nested options, re-use options as part of other options**

- This feature is based on logic-less templating using a [R implementation](https://github.com/edwindj/whisker) of [mustache](https://mustache.github.io).
- Say we define two options *first_name* and *last_name*; to create *full_name*, either we could again use the actual values or first and last names or define *full_name* as `{{{first_name}}} {{{last_name}}}`

```
set_opts(first = "John", last = "Doe",
	full = "{{{first}}} {{{last}}}")
get_opts('full')
"John Doe"
```

- both `set_opts` and `load_opts`, support auto-complete
- this is especially useful in case of paths, and is really inspired by BASH environment variable system


### Using params in your own package

Params creates a environment object and stores all parameters in that object. Thus multiple packages using params packages may be loaded each with a separate set of options.

**Setup**: One liner to to be included in a package !

```
myopts = new_opts()
```

The above object provides three functions to load, set and fetch params:

- myopts$get()
- myopts$set()
- myopts$load()


### Installation


```
## stable version from CRAN
install.packages("params") 

## latest, development version
devtools::install_github("sahilseth/params")
```


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



