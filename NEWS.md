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
