load_toml <- function(toml, envir = envir){
  str_toml = parseToml(toml) %>% unlist()
  lst_toml = split(str_toml, names(str_toml))
  set_opts(.dots = lst_toml, .parse = TRUE, envir = envir)
}
