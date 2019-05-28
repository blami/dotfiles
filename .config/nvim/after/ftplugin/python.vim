" Language: Python
" Maintainer: Ondrej Balaz

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" PEP8 Indentation
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8
setl cinkeys-=0#
setl indentkeys-=0#

setl suffixesadd=.py
setl wildignore+=*.pyc

setl comments=b:#,fb:-
setl commentstring=#\ %s
