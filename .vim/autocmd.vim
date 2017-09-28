" ~/.vim/autocmd.vim - autocommands

" {{{ General
" Restore position in file (except some filetypes)
autocmd! BufReadPost * call util#RestoreFilePosition()
" }}}




" vim:set ft=vim fo-=t:
