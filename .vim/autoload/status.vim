"Utility functions for statusline

"Status pages are bufers that can hold additional information relevant to
"e.g. currently opened buffer.

"Add page to buffer status.
func status#AddPage(id, func) abort
    if !exists('b:statuspages') | let b:statuspages = {} | endif
    if type(a:func) == v:t_func
       let b:statuspages[a:id] = a:func
    endif
endfunc

"Toggle buffer status current page ("+" next, "-" prev or "<ID>").
func status#TogglePage(arg) abort
    if !exists('b:statuspages') || empty(b:statuspages) | return | endif
    "If current id is not set yet or isn"t valid use the first item
    let ids = keys(b:statuspages)
    if !exists("b:statuspages_cur") || index(ids, b:statuspages_cur) == -1
        let b:statuspages_cur = keys(b:statuspages)[0] | return
    endif

    if a:arg != '-' && a:arg != '+'
        if index(ids, a:arg) != -1
            let b:statuspages_cur = a:arg
        endif
        return
    endif
    "Toggle to next or previous item (cycle if bound is reached)
    let i = index(ids, b:statuspages_cur)
    if a:arg == '+' | let i += 1 | elseif a:arg == '-' | let i -= 1 | endif
    if i == len(ids) | let i = 0 | elseif i < 0 | let i = len(ids) - 1 | endif

    let b:statuspages_cur = ids[i]
endfunc

"Return currently selected page output.
func status#StatusPage() abort
    if !exists('b:statuspages') || empty(b:statuspages) | return '-' | endif
    if !exists('b:statuspages_cur')
        let b:statuspages_cur = keys(b:statuspages)[0]
    endif

    "Check whether selected index is really function
    if type(b:statuspages[b:statuspages_cur]) == v:t_func
        return b:statuspages[b:statuspages_cur]()
    endif
    return '-'
endfunc

"Show current mode in single-letter form.
func! status#ShowMode() abort
    "Consult :help mode()
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

"Show paste mode flag.
func! status#ShowPaste()
    if &paste
        return ''
    else
        return ' '
    endif
endfunc
