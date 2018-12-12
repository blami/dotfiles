" Theme:        blami256
" Maintainer:   Ondrej Balaz <blami@blami.net>
" License:      MIT

unlet! g:colors_name

hi clear Normal
set bg&
" Remove all existing highlighting and set the defaults
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "blami256"
