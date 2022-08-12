## Test environments
* local OS X install, 4.0
* ubuntu 16.04 R 3.5, 3.6, 4.0, devel
* win-builder R 4.0
* macos R 4.0


## Downstream dependencies

- flowr: CRAN's version of flowr, installs and loads fine with this latest version 
of params.

<!---notes to self:

## checklist for self
- check revdep_check()
- version in DESCRIPTION (3)
- update NEWS

# check urls:
devtools::check(manual = TRUE, remote = TRUE, incoming = TRUE)
  
# submit to cran
devtools::submit_cran()
--->

