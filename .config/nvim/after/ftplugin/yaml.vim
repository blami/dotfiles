"Language: YAML
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl formatoptions-=t
setl list

"File Matching
setl suffixesadd=.yml,.yaml
