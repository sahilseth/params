p a r a m s    0.4.0
------------------------------------------------
- updated documentation for read_sheet
- write_sheet now handles multiple extensions

p a r a m s    0.3.0    2015/09/22
------------------------------------------------
- bug fix `load_opts`, so that only values in the 
 current file are check (not all options in the environment)
- bug fix `parse_opts`: only variables with {{ are parsed.

p a r a m s    0.2.5    2015/08/14
------------------------------------------------
- bug fix with new_opts, use new env object

p a r a m s    0.2.4    2015/08/14
------------------------------------------------
- incorporated kable
- parsing using whisker now optional for set_opts and load_opts

p a r a m s    0.2.3    2015/08/07
------------------------------------------------
- set_opts: enhanced error reporting
- print.opts: handles older versions of kable (a knitr function).
- renamed load_conf to load_opts, to make all function names consistent.

p a r a m s    0.2.2    2015/07/28
------------------------------------------------
- load_conf() has a new argument envir, this really helps
in integrating params within other packages
- set_opts(): produce a better error when .dots and ...
are both supplied, suggesting user should use either and
not both.
- new_opts(): Creates a new object for managing params
