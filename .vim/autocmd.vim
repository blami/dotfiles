"File:          autocmd.vim
"Description:   Autocommands
"               Loads _after_ plugins (see after/plugin/source.vim).

"Restore cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \       exe 'normal! g`"' |
    \ endif

"Special buffers
autocmd CmdwinEnter * setl nonu scl=no cc= nolist
autocmd TerminalOpen * setl nonu scl=no cc= nolist

"TODO Highlighting
autocmd WinEnter,BufWinEnter * call todo#highlight()
