"Language:     Vim help file
"Maintainer:   Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

setl shiftwidth=8 tabstop=8 softtabstop=8
setl noexpandtab

"Look and feel
setl nonumber
setl signcolumn=
setl colorcolumn=
setl statusline=\[Help\]\ %t\ %=%2*%c,%l/%LL%*\ %P 

"Open help window as right split on large terminals
autocmd! BufWinEnter <buffer> if &columns > 160 | wincmd L"{{{"}}} | endif
