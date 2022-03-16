"autocmd.vim - global autocommands

"Restore cursor position
autocmd BufReadPost * 
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \       exe 'normal! g`"' |
        \ endif

"Highlight TODO items (I prefer this to filetype specific highlights)
autocmd WinEnter,BufWinEnter * call blami#todo#Toggle(1)

"Statusline in special buffers
autocmd CmdWinEnter * setl nonu scl= cc= nolist stl=%t\ %=%2*%c,%l/%LL%*\ %P
autocmd TermOpen * setl nonu scl= cc= nolist stl=\[Terminal\]\ %2*%t%*\ %=%2*%c,%l/%LL%*\ %P
autocmd BufEnter * if &bt ==# 'nofile' | setl nonu scl= cc= nolist stl=%t\ %=%2*%c,%l/%LL%*\ %P | endif 

"Store current window number to g:curwin
"Run statusline helpers to hide UserN highlights in non-active windows
autocmd VimEnter,WinEnter,BufWinEnter *
            \ if nvim_win_get_config(0).relative=="" |
            \   let g:curwin=win_getid() |
            \   call blami#statusline#Enter() |
            \ endif
autocmd WinLeave *
            \ if nvim_win_get_config(0).relative=="" |
            \   call blami#statusline#Leave() |
            \ endif


"{{{ File format specific
"Do not show
"}}}
