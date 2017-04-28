" ~/.vim/autoload/bufstatus.vim - buffer specific status in statusline

" {{{ Buffer status
" Add given funcref that returns a page to bufstatus under given id.
func bufstatus#AddPage(id, funcref)
    if !exists('b:bufstatus') | let b:bufstatus = {} | endif
    let b:bufstatus[a:id] = a:funcref
endfunc

" Toggle buffer status pages. Argument can be '+' for next, '-' for previous or
" actual id of status page.
func bufstatus#TogglePage(arg)
    if !exists('b:bufstatus') || empty(b:bufstatus) | return | endif
    " If current id is not set yet or isn't valid use the first item
    let ids = keys(b:bufstatus)
    if !exists('b:bufstatus_cur') || index(ids, b:bufstatus_cur) == -1
        let b:bufstatus_cur = keys(b:bufstatus)[0] | return
    endif

    " Toggle to given id if exists otherwise error?
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

" Execute currently selected status function and return result.
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
