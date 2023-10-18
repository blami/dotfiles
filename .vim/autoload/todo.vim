"File:          todo.vim
"Description:   Utilities to highlight and work with TODO-like statements


"NOTE: \< \> are word boundary marks
let s:todo_patterns = [
    \ '\<NOTE\>\((\w\+)\)\?:',
    \ '\<TODO\>\((\w\+)\)\?:',
    \ '\<WARN\>\((\w\+)\)\?:',
    \ '\<FIXME\>\((\w\+)\)\?:',
    \ '\<BUG\>\((\w\+)\)\?:',
    \ '\<XXX\>\((\w\+)\)\?:',
    \ ]

func! todo#highlight(...) abort
    let l:matchid=0
    for l:g in getmatches()
        if l:g['group'] == 'CustomTodo'
            let l:matchid = l:g['id']
            break
        endif
    endfor
    let l:arg = get(a:, 1, !matchid)
    let l:todo_patterns = get(g:, 'todo_patterns', s:todo_patterns)
    if l:arg && l:matchid == 0
        call matchadd('CustomTodo', '\(' .. join(l:todo_patterns, '\|') .. '\)', 10)
    elseif !l:arg && l:matchid != 0
        call matchdelete(l:matchid)
    endif
endfunc

func! todo#quickfix() abort
    let l:todo_patterns = get(g:, 'todo_patterns', s:todo_patterns)
    let l:matches = []
    for l:p in l:todo_patterns
        exec 'silent g/' .. l:p .. '/call add(l:matches, [getpos(".")[1], match(getline("."), l:p)])'
    endfor
    let l:qf = getqflist()
    for l:m in l:matches
        let l:loc = {
                    \ 'bufnr': bufnr('%'),
                    \ 'lnum': l:m[0],
                    \ 'col': l:m[1],
                    \ 'text': getline(l:m[0])[l:m[1]:],
                    \ }
        call add(l:qf, l:loc)
    endfor
    call setqflist(l:qf)
    copen
endfunc
