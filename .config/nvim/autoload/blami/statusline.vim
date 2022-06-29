"Statusline utilities

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

"Show LEDs (statuses for certain flags) in statusline.
func! blami#statusline#LEDs() abort
    let currentleds=''

    "Paste mode
    if &paste                   | let currentleds.=''              | endif
    "Folding
    if &foldlevel==0 
        let currentleds.='ﲓ'.(&fdm=='manual'?'_':&fdm[0:0])
    endif
    "Line wrapping
    if &wrap==1
        let currentleds.='$'
    endif
    "LSP
    "if get(b:, 'autofmt', 0)    | let currentleds.=''              | endif
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        let currentleds.=''
    endif

    return currentleds
endfunc

"Statusline per-buffer pages
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
"Leave helper that stores window statusline upon leaving so that Enter helper
"can restore highlighted statusline later when buffer is in active window.
func! blami#statusline#Leave() abort
    "Save statusline if it was not saved yet or if it differs from last saved
    if !has_key(getbufvar(bufnr(), ''), 'statusline')
                \ || getbufvar(bufnr(), 'statusline') != getbufvar(bufnr(), '&statusline')
        call setbufvar(bufnr(), 'statusline', getbufvar(bufnr(), '&statusline')) 
    endif
endfunc

"Enter helper that sets &statusline in each window, in non-active ones it 
"removes UserN highlights and in active restores highlighted b:statusline.
func! blami#statusline#Enter() abort
    "Loop over all window ids that do not belong to relative (float) windows
    for i in filter(nvim_list_wins(), {v -> !nvim_win_get_config(v:val).relative})
        let bufnr = winbufnr(i)
        if has_key(getbufvar(bufnr, ''), 'statusline')
            let statusline=getbufvar(bufnr, 'statusline')
            call setwinvar(i, '&statusline', g:curwin==i?statusline:substitute(statusline,'%[1-9]\?\*','','g'))
        endif
    endfor
endfunc
"}}}
