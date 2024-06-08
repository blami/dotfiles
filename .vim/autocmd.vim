"File:          autocmd.vim
"Description:   Common autocommands
"               Loads _after_ plugins (see vimrc).

"TODO: Look at autogroups with au! (see https://stackoverflow.com/questions/42842688/how-to-correctly-reload-vimrc-file-so-it-will-be-equal-to-restart-of-vim)

"Restore cursor position
autocmd! BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe 'normal! g`"' |
            \ endif

"Special buffers
autocmd! CmdwinEnter * setl nonu scl=no cc= nolist
autocmd! TerminalOpen * setl nonu scl=no cc= nolist

"TODO Highlighting
autocmd! WinEnter,BufWinEnter * call todo#highlight(1)

"Configuration reload
if v:version >= 802
    autocmd! SourcePost vimrc
            \ if !has('vim_starting') |
            \   call g:VimrcInclude('all') |
            \ endif
endif

"Signal handlers
"autocmd! SigUSR1 * call ...
