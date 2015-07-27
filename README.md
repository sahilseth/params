
[![Build Status](https://travis-ci.org/sahilseth/params.png)](https://travis-ci.org/sahilseth/params)


A package level alternative for `options` and `getOptions`, to prevent cluterring the space. 

- ability to store all default options as a tab delimited table
- automatically check if file.path exists for options relating to files.
- fetch multiple options as list
- print options as a pretty table


### Installation


```r
install.packages("params")
devtools::install_github("sahilseth/params")
```


#### Simple options


```r
library(params)
set_opts(list(verbose = TRUE, 
	my_dir = "~/mypath",
	regex = "(.*)-[ATGC]{1}"))
get_opts("my_dir") ## extract options
```

```
    my_dir 
"~/mypath" 
```


#### example conf file


```r
conf = system.file("conf/params.conf", package = "params")
```

#### load the config file

```r
load_conf(conf)
```

```
Reading file, using 'V1' as id_column to remove empty rows.
```

```
Warning in chk_conf(lst): 

Seems like these paths do not exist, this may cause issues later:
name          value            
------------  -----------------
my_tool_exe   /usr/bin/ls      
my_dir        path/to/a/folder 
```

#### load the config file in silence

```r
opts = load_conf(conf, check = FALSE, verbose = FALSE)
print(opts) ## print opts as a pretty table
```

```

                                 
--------------  -----------------
my_path         ~/flowr          
my_tool_exe     /usr/bin/ls      
my_dir          path/to/a/folder 
my_conf_path    ~/flowr/conf     
default_regex   (.*)             
```

#### Show all options
- notice how `my_conf_path` autocompleted {{{my_path}}}, getting its value from previous lines


```r
get_opts() 
```

```

                                 
--------------  -----------------
default_regex   (.*)             
my_conf_path    ~/flowr/conf     
my_dir          path/to/a/folder 
my_path         ~/flowr          
my_tool_exe     /usr/bin/ls      
regex           (.*)-[ATGC]{1}   
verbose         TRUE             
```


**Here is what the original file looks like**:

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


#### Using params in your own package

params creates a environment object and stores all parameters in that object. If there are multiple packages loaded, which are using params, they 
may override each other's options, clutering the space the same way as options(). Alternatively, one may create a `env` for a package.


If you would like to use params in your R packages, use the following lines


```r
## Create a R file in your package, and put the following lines in it

#' @export
mypkg_opts = new.env()

#' @importFrom params get_opts
get_opts <- function(x){
	params::get_opts(x, envir = mypkg_opts)
}

#' @importFrom params set_opts
set_opts <- function(..., .dots){
	params::set_opts(..., .dots, envir = mypkg_opts)
}
```


Also, you would need to add `params` to the depends field in the `DESCRIPTION` file.


