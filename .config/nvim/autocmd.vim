"Global autocommands


"Restore cursor position
autocmd BufReadPost * 
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \       exe 'normal! g`"' |
        \ endif 

"Modify special windows
autocmd CmdWinEnter *       setl nonumber signcolumn= colorcolumn= statusline=%t\ %=%2*%c,%l/%LL%*\ %P 
autocmd TermOpen *          setl nonumber signcolumn= colorcolumn= statusline=\[Terminal\]\ %2*%t%*\ %=%2*%c,%l/%LL%*\ %P


"NOTE This has to be done after all messing with statusline
"Remember statusline of each window in w:statusline
autocmd Filetype,TermEnter * :call blami#statusline#Save()
"Store current window number to g:curwin
"Show statusline UserN highlights only in active window
autocmd VimEnter,WinEnter,BufWinEnter *
            \ let g:curwin=winnr() |
            \ call blami#statusline#Set()



"{{{ Plugins
"Never replace NERDTree buffer
autocmd BufEnter *
            \ if bufname('#') =~ 'NERD_tree_\d\+'
            \   && bufname('#') !~ 'NERD_tree_\d\+'
            \   && winnr('$') > 1 |
            \       let buf=bufnr() |
            \       buffer# |
            \       exec 'normal! \<C-W>w' |
            \       exec 'buffer'.buf |
            \ endif

"Download missing dictionaries to g:localdir
"TODO
autocmd SpellFileMissing * echoerr expand('<amatch>') "call spellX#func(expand('<amatch>'))

"Refresh my help tags (if doc/ exists)
if isdirectory(g:confdir.'/doc')
    autocmd VimEnter * :exec ':helptags '.g:confdir.'/doc'
endif




"}}}
