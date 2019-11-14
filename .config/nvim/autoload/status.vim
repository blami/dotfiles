" ~/.vim/autoload/status.vim - status line rendering helpers

func! status#ShowMode()
    " Consult :help mode()
    let currentmode={
        \ 'n'      : 'N',
        \ 'no'     : 'N',
        \ 'v'      : 'V',
        \ 'V'      : 'V',
        \ '^V'     : 'V',
        \ 's'      : 'S',
        \ 'S'      : 'S',
        \ '^S'     : 'S',
        \ 'i'      : 'I',
        \ 'R'      : 'R',
        \ 'Rv'     : 'R',
        \ 'c'      : 'C',
        \ 'cv'     : 'C',
        \ 'ce'     : 'E',
        \ 'r'      : '>',
        \ 'rm'     : 'M',
        \ 'r?'     : '?',
        \ '!'      : '!',
        \ 't'      : '$'
        \}
    try
        return currentmode[mode()]
    catch /./
        return '*'
    endtry
endfunc

func! status#ShowPaste()
    if &paste
        return 'P'
    else
        return ' '
    endif
endfunc
