"Global autocommands


"Restore cursor position
autocmd BufReadPost * 
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \       exe 'normal! g`"' |
        \ endif 

"Modify special windows
autocmd CmdWinEnter *       setl nonumber signcolumn= colorcolumn= statusline=%t\ %=%2*%c,%l/%LL%*\ %P 
autocmd TermOpen *          setl nonumber signcolumn= colorcolumn= statusline=\[Terminal\]\ %2*%t%*\ %=%2*%c,%l/%LL%*\ %P

"Store current window number to g:curwin
"Run statusline helpers to hide UserN highlights in non-active windows
autocmd VimEnter,WinEnter,BufWinEnter *
            \ let g:curwin=winnr() |
            \ call blami#statusline#Enter()
autocmd WinLeave *
            \ call blami#statusline#Leave()


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
