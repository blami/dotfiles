"todo.vim - TODO highlighting

" \< and \> are word boundary marks
let s:patterns = [
    \ '\<NOTE\>\((\w\+)\)\?:',
    \ '\<TODO\>\((\w\+)\)\?:',
    \ '\<FIXME\>\((\w\+)\)\?:',
    \ '\<BUG\>\((\w\+)\)\?:',
    \ '\<XXX\>\((\w\+)\)\?:',
    \ ]


"NOTE this does not really support TODO only in comments

func blami#todo#Toggle(...) abort
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

"TODO Add function to add all matches to quicklist (perhaps via diagnostics?)
