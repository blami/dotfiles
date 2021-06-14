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

    "Paste mode
    if &paste                   | let currentleds.=''              | endif
    "Folding
    if &foldlevel==0 
        let currentleds.='ﲓ'.(&fdm=='manual'?'_':&fdm[0:0])
    endif
    "Autoformatting and LSP
    if get(b:, 'autofmt', 0)    | let currentleds.=''              | endif
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        let currentleds.=''
    endif

    return currentleds
endfunc
"}}}


"{{{ Statusline pages

"Add page. If id is 0, new id will be current length of page list.
func blami#statusline#PageAdd(id, value) abort
    if !exists('b:statuspage') | let b:statuspage = {} | endif
    if a:id == 0 | a:id = len(ids) | endif
    let b:statuspage[a:id] = a:value
endfunc

"Toggle current page ("+" next, "-" prev or "<ID>").
func blami#statusline#PageToggle(arg) abort
    if !exists('b:statuspage') || empty(b:statuspage) | return | endif
    "If current id is not set yet or isn't valid use the first item
    let ids = keys(b:statuspage)
    if !exists("b:statuspage_current") || index(ids, b:statuspage_current) == -1
        let b:statuspages_current = keys(b:statuspage)[0] | return
    endif

    if a:arg != '-' && a:arg != '+'
        if index(ids, a:arg) != -1
            let b:statuspage_current = a:arg
        endif
        return
    endif
    "Toggle to next or previous item (cycle if bound is reached)
    let i = index(ids, b:statuspage_current)
    if a:arg == '+' | let i += 1 | elseif a:arg == '-' | let i -= 1 | endif
    if i == len(ids) | let i = 0 | elseif i < 0 | let i = len(ids) - 1 | endif

    let b:statuspage_current = ids[i]
endfunc

"Return currently selected page.
func blami#statusline#Page() abort
    if !exists('b:statuspage') || empty(b:statuspage) | return '-' | endif
    if !exists('b:statuspage_current')
        let b:statuspage_current = keys(b:statuspage)[0]
    endif
    "Execute functions, print other types
    let page=b:statuspage[b:statuspage_current]
    if type(page) == v:t_func | return page() | else | return page | endif
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
            call blami#statusline#Refresh()
        endif
    endfor
endfunc

"Refresh &statusline in each window and apply UserN highlights only in active.
func! blami#statusline#Refresh() abort
    for i in range(1, winnr('$'))
        if has_key(getwinvar(i, ''), 'statusline')
            let statusline=getwinvar(i, 'statusline')
            call setwinvar(i, '&statusline', g:curwin==i?statusline:substitute(statusline,'%[1-9]\?\*','','g')) |
        endif
    endfor
endfunc
"}}}
