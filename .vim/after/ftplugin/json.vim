" Language: JSON
" Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

" Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl fo-=t

" File Matching
setl suffixesadd=.json
