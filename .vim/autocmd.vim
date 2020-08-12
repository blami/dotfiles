"Global autocommands

"Restore cursor position
autocmd! BufReadPost * call util#RestoreCursorPosition()

"Refresh help tags
autocmd! VimEnter * :helptags ~/.vim/doc

"Do not use default ftplugins
"autocmd! BufReadPre,BufNewFile * let b:did_ftplugin = 1


"vim:set fo-=t:
