" ~/.vim/autoload/bufstatus.vim - buffer specific status in statusline

" Buffer status provides basic functionality to manage a dictionary of
" functions (pages) that return status strings relevant to buffer.

" {{{ Buffer status
" Add page to buffer status.
func bufstatus#AddPage(id, func)
    if !exists('b:bufstatus') | let b:bufstatus = {} | endif
    if type(a:func) == v:t_func
       let b:bufstatus[a:id] = a:func
    endif
endfunc

" Toggle buffer status current page ('+' next, '-' prev or '<ID>').
func bufstatus#TogglePage(arg)
    if !exists('b:bufstatus') || empty(b:bufstatus) | return | endif
    " If current id is not set yet or isn't valid use the first item
    let ids = keys(b:bufstatus)
    if !exists('b:bufstatus_cur') || index(ids, b:bufstatus_cur) == -1
        let b:bufstatus_cur = keys(b:bufstatus)[0] | return
    endif

    if a:arg != '-' && a:arg != '+'
        if index(ids, a:arg) != -1
            let b:bufstatus_cur = a:arg
        endif
        return
    endif
    " Toggle to next or previous item (cycle if bound is reached)
    let i = index(ids, b:bufstatus_cur)
    if a:arg == '+' | let i += 1 | elseif a:arg == '-' | let i -= 1 | endif
    if i == len(ids) | let i = 0 | elseif i < 0 | let i = len(ids) - 1 | endif

    let b:bufstatus_cur = ids[i]
endfunc

" Return currently selected page output.
func bufstatus#StatusPage()
    if !exists('b:bufstatus') || empty(b:bufstatus) | return '-' | endif
    if !exists('b:bufstatus_cur')
        let b:bufstatus_cur = keys(b:bufstatus)[0]
    endif

    " Check whether selected index is really function
    if type(b:bufstatus[b:bufstatus_cur]) == v:t_func
        return b:bufstatus[b:bufstatus_cur]()
    endif
    return '-'
endfunc
" }}}


" {{{ Common status page functions
" }}}
