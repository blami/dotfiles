" Language:     Neovim help file
" Maintainer:   Ondrej Balaz

" Neovim/plugin ftplugins are disabled. See autocmd.vim.
"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

setlocal noexpandtab
if exists("+colorcolumn")
    set cc=+1
endif

autocmd! BufWinEnter <buffer> wincmd L"{{{"}}}
