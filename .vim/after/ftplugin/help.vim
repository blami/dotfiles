" Language:     Neovim help file
" Maintainer:   Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

setl noexpandtab

setlocal noexpandtab
if exists("+colorcolumn")
    set cc=+1
endif

autocmd! BufWinEnter <buffer> wincmd L"{{{"}}}
