" ~/.config/nvim/autocmd.vim - Neovim autocommands

" {{{ General
" Restore cursor position
autocmd! BufReadPost * call util#RestoreFilePosition()
" Restore cursor style after leaving
autocmd! VimLeave * set guicursor=a:block-blinkoff0
" }}}


" vim:set fo-=t:
