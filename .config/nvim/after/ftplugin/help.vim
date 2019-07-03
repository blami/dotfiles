" Language:     Vim help file
" Maintainer:   Ondrej Balaz

setl noexpandtab

if exists("+colorcolumn")
    set cc=+1
endif

autocmd! BufWinEnter <buffer> wincmd L"{{{"}}}
