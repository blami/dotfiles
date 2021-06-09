"Statusline utilities

"{{{ Statusline displays
"Show one-character mode in statusline.
func! blami#statusline#Mode() abort
    "Consult :help mode()
    let currentmode={
        \ 'n'       : 'N',
        \ 'no'      : 'N',
        \ 'nov'     : 'N',
        \ 'noV'     : 'N',
        \ 'no'    : 'N',
        \ 'niI'     : 'N',
        \ 'niR'     : 'N',
        \ 'niV'     : 'N',
        \ 'v'       : 'V',
        \ 'V'       : 'V',
        \ ''      : 'V',
        \ 's'       : 'S',
        \ 'S'       : 'S',
        \ ''      : 'S',
        \ 'i'       : 'I',
        \ 'R'       : 'R',
        \ 'Rv'      : 'R',
        \ 'c'       : 'C',
        \ 'cv'      : 'C',
        \ 'ce'      : 'E',
        \ 'r'       : '>',
        \ 'rm'      : 'M',
        \ 'r?'      : '?',
        \ '!'       : '!',
        \ 't'       : '$'
        \}
    try
        return currentmode[mode()]
    catch /./
        return '-'
    endtry
endfunc

"Show LEDs (status lights for certain flags) in statusline.
func! blami#statusline#LEDs() abort
    let currentleds=''

    if &paste                   | let currentleds.=''              | endif
    if get(b:, 'autofmt', 0)    | let currentleds.=''              | endif

    if &foldlevel==0 
        let currentleds.='פּ'.(&fdm=='manual'?'_':&fdm[0:0])
    endif

    return currentleds
endfunc
"}}}


"{{{ Autocommand helpers
"Save window's local &statusline for each window in w:statusline
"NOTE Filetype * seems to be the best place to do this
func! blami#statusline#Save() abort
    for i in range(1, winnr('$'))
        if !has_key(getwinvar(i, ''), 'statusline')
            "TODO maybe save only if it not matches global &statusline?
            call setwinvar(i, 'statusline', getwinvar(i, '&statusline'))
            call blami#statusline#Set()
        endif
    endfor
endfunc

"Set statusline to each window with UserN highlights only in active window
func! blami#statusline#Set() abort
    for i in range(1, winnr('$'))
        if has_key(getwinvar(i, ''), 'statusline')
            let statusline=getwinvar(i, 'statusline')
            call setwinvar(i, '&statusline', g:curwin==i?statusline:substitute(statusline,'%[1-9]\?\*','','g')) |
        endif
    endfor
endfunc
"}}}
