"Global autocommands
"NOTE This depends on g:confdir set in vimrc

"Restore cursor position
autocmd! BufReadPost * call util#RestoreCursorPosition()

"Refresh help tags
if isdirectory(g:confdir."/doc")
    autocmd! VimEnter * :helptags ~/.vim/doc
end

"Do not use default ftplugins
"autocmd! BufReadPre,BufNewFile * let b:did_ftplugin = 1


"vim:set fo-=t:
