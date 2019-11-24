" ~/.config/nvim/autocmd.vim - Neovim autocommands

" {{{ General
" Restore cursor position
autocmd! BufReadPost * call util#RestoreCursorPosition()
" Do not use default ftplugins
autocmd! BufReadPre,BufNewFile * let b:did_ftplugin = 1

" Restore cursor style after leaving
autocmd! VimLeave * set guicursor=a:block-blinkoff0
" }}}


" vim:set fo-=t:
