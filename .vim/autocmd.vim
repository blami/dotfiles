" ~/.vim/autocmd.vim - global autocommands

" {{{ General
" Restore cursor position
autocmd! BufReadPost * call util#RestoreCursorPosition()
" Do not use default ftplugins
"autocmd! BufReadPre,BufNewFile * let b:did_ftplugin = 1
" Make backup file name contain full path (because it goes to .local/share/vim)
"autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g').'~'

" Restore cursor style after leaving
autocmd! VimLeave * set guicursor=a:block-blinkoff0
" }}}


" vim:set fo-=t:
