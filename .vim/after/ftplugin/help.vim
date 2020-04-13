"Language:     Vim help file
"Maintainer:   Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

setl shiftwidth=8 tabstop=8 softtabstop=8
setl noexpandtab

setlocal noexpandtab
if exists("+colorcolumn")
    set cc=+1
endif

autocmd! BufWinEnter <buffer> wincmd L"{{{"}}}
