"File:          autocmd.vim
"Description:   Autocommands
"               Loads _after_ plugins (see after/plugin/source.vim).

"Restore cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \       exe 'normal! g`"' |
    \ endif

"Statusline
autocmd CmdWinEnter * setl nonu scl=no cc= nolist stl=%t\ %=%2*%c,%l/%LL%*\ %P
"autocmd TermOpen * setl nonu scl=no cc= nolist stl=\[Terminal\]\ %2*%t%*\ %=%2*%c,%l/%LL%*\ %P
autocmd BufEnter * if &bt ==# 'nofile' | setl nonu scl=no cc= nolist stl=%t\ %=%2*%c,%l/%LL%*\ %P | endif
