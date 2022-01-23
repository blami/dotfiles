"trailspace.vim - trailing space utilities

"Turn trailing space highlighting on(1), off(0) or toggle current state.
func blami#trailspace#Toggle(...) abort
    let matchid=0
    for g in getmatches()
        if g['group'] == 'TrailSpace'
            let matchid=g['id']
            break
        endif
    endfor
    let arg=get(a:, 1, !matchid)
    if arg && matchid == 0
        call matchadd('TrailSpace', '\s\+$', 10)
    elseif !arg && matchid != 0
        call matchdelete(matchid)
    endif
endfunc

"Remove any trailing spaces from current buffer.
func blami#trailspace#Remove() abort
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfunc
