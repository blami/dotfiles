" ~/.vim/autocmd.vim - autocommands

" {{{ General
" Restore position in file
autocmd! BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exec "normal! g`\"" |
            \ endif

" }}}




" vim:set ft=vim fo-=t:
