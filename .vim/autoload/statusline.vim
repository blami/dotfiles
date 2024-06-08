"File:          statusline.vim
"Description:   Statusline utilities


"{{{ Statusline
"Print out opinionated statusline.
func! statusline#statusline() abort
    let l:s = ''
    if v:version < 802
        let g:statusline_winid = win_getid()
    endif
    let l:cur = g:statusline_winid == win_getid()                               "is current window?
    let l:w = winwidth(g:statusline_winid)                                      "is wider than 80 columns?
    let l:sbt = 0                                                               "is special buffer type

    "Get window, buffer numbers and buffer type
    let l:winnr = getwininfo(g:statusline_winid)[0]['winnr']
    let l:bufnr = getwininfo(g:statusline_winid)[0]['bufnr']
    let l:bt = getbufvar(l:bufnr, '&bt')

    "Get current mode
    let l:m = mode()[0]
    if l:m ==# ''| let m = 'v' | endif
    if l:m ==# ''| let m = 's' | endif
    if l:m ==# 'r' | let m = '?' | endif
    let l:m = toupper(l:m)

    "Get autocompletion method
    let l:autocompl = ''
    if getbufvar(l:bufnr, 'autocompl')
        let l:autocompl = 'A'
    elseif getbufvar(l:bufnr, '&omnifunc') != ''
        let l:autocompl = 'o'
    endif

    "Get fold method
    if &fdm ==# 'marker' | let l:fold = '{' | else | let l:fold = &fdm[0] | endif

    "                .----- autocompletion TODO,o-mnifunc
    "                |.---- autoformat on save f
    "                ||.--- fold method m-anual,i-ndent,e-xpr,{-marker,s-yntax,d-iff
    "                |||.-- wrap mode $
    "                ||||.- paste mode P
    "Get status leds -----
    let l:led = ['-','-','-','-','-']
    if l:autocompl != ''     | let l:led[0] = l:autocompl[0] | endif            "autocomplete
    if getbufvar(l:bufnr, 'autofmt')    | let l:led[1] = 'f' | endif            "autoformat on save (buffer)
    if !getwinvar(l:winnr, '&fdl')   | let l:led[2] = l:fold | endif            "fold method
    if getwinvar(l:winnr, '&wrap')      | let l:led[3] = '$' | endif            "wrap lines (window)
    if &paste                           | let l:led[4] = 'P' | endif            "paste mode (global)

    "Left side
    let l:s .= '%n'                                                            "buffer number
    if l:cur | let l:s .= ' %1*' . m . '%*' | endif                          "mode
    "Special buffers
    "1 N [Help] gui.txt[RO]                                           1,1/5 All
    if l:bt ==# 'help'
        let l:s .= ' [Help] %t%r'                                              "file name[RO]
        let l:sbt = 1
    "1 N [Terminal]                                                   1,1/5 All
    elseif l:bt ==# 'terminal'
        let l:s .= ' [Terminal] %t'                                            "[TERMINAL] [..]
        let l:sbt = 1
    "1 N [Quickfix List]                                              1,1/5 All
    "1 N [Location List] :grep foo /bar/*                             1,1/5 All
    "NOTE: See override in after/ftplugin/qf.vim
    elseif l:bt ==# 'quickfix'
        let l:s .= ' %t%{exists("w:quickfix_title")?" ".w:quickfix_title:""}'
        let l:sbt = 1
    "1 N [Command Line]                                               1,1/5 All
    elseif l:bt ==# 'nofile'
        let l:s .= ' %t'
        let l:sbt = 1
    "Normal buffers
    "1 N vimrc[+][RO] [vim] unix,utf-8 -               en ----- >#72 1,1/50 10%
    else
        let l:s .= ' %t%m%r'                                                   "file name[+][RO]
        let l:s .= ' %2*[%{&ft!=""?&ft:"-"}]%*'                                "file type
        if l:w >= 80 | let s .= ' %{&ff}%{&fenc!=""?",".&fenc." ":""}' | endif "format,encoding
        if (l:cur && l:w >= 80) | let l:s .= '%3*' . statusline#page() . '%*' | endif      "status pages TODO
    endif

    "Right side
    let l:s .= '%='
    "Special buffers (hide everything except ruler at the end)
    if l:sbt
        let s .= '%4*'
    "Normal buffers
    else
        let l:s .= '%{&spell!=0?strpart(&spelllang,0,2)." ":""}'              "spell lang
        let l:s .= join(l:led,'') . ' '                                       "leds
        let l:s .= '%4*%{&tw && matchstr(&fo,"t")!=""?">":""}'                 "comment(#) and text(>) width
        let l:s .= '%{&tw && matchstr(&fo,"c")!=""?"#":""}'
        let l:s .= '%{&tw && matchstr(&fo,"[tc]")!=""?&tw." ":""}'
    endif
    let l:s .= '%c,%l%* %P'                                                    "ruler

    "Remove all highlight groups if not active window
    return l:cur?l:s:substitute(l:s, '%[1-9]\?\*','','g')
endfunc

"{{{ Pages
func! statusline#page() abort
    return '-'
endfunc
"}}}
