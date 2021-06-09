"Language:     Vim quickfix/location list
"Maintainer:   Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"setl shiftwidth=8 tabstop=8 softtabstop=8
setl noexpandtab

"Look and feel
setl nonumber
setl signcolumn=
setl colorcolumn=
setl statusline=%t%{exists('w:quickfix_title')?'\ '.w:quickfix_title:''}\ %=%2*%c,%l/%LL%*\ %P 
