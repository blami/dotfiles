"TODO highlighting

"\< and \> are word boundary marks
let s:patterns = [
    \ '\<NOTE\>\((\w\+)\)\?:',
    \ '\<TODO\>\((\w\+)\)\?:',
    \ '\<WARN\>\((\w\+)\)\?:',
    \ '\<FIXME\>\((\w\+)\)\?:',
    \ '\<BUG\>\((\w\+)\)\?:',
    \ '\<XXX\>\((\w\+)\)\?:',
    \ ]

"Turn highlight of all TODO patterns above using CustomTodo highlight on(1), 
"off(0) or toggle current state.
func blami#todo#Highlight(...) abort
    let matchid=0
    for g in getmatches()
        if g['group'] == 'CustomTodo'
            let matchid=g['id']
            break
        endif
    endfor
    let arg=get(a:, 1, !matchid)
    if arg && matchid == 0
        call matchadd('CustomTodo', '\('.join(s:patterns, '\|').'\)', 10)
    elseif !arg && matchid != 0
        call matchdelete(matchid)
    endif
endfunc

"TODO: Add items to QuickList
