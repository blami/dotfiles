"toggle.vim - various toggles of built-ins used mostly in keymap.vim

"Toggle quickfix/location lists.
func! blami#toggle#List(prefix) abort
    redir =>buflist
    silent! ls!
    redir END
    let lists={'c':'Quickfix List', 'l':'Location List'}

    for n in map(filter(
                \   split(buflist, '\n'), 'v:val =~ "'.lists[a:prefix].'"'
                \ ), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(n) != -1 | exec(a:prefix.'close') | return | endif
    endfor

    "Show error instead of empty window in case there are no items
    if (a:prefix == 'l' && len(getloclist(0)) == 0)
                \ || (a:prefix == 'c' && len(getqflist()) == 0)
        echohl ErrorMsg | echo lists[a:prefix].' is empty'
        return
    endif

    let winnr=winnr()
    exec(a:prefix.'open')
    if winnr() != winnr | wincmd p | endif
endfunc

"Toggle line numbers, relative numbers and nothing.
func! blami#toggle#Number() abort
    if &l:number == 1 && &l:relativenumber == 0
        setl nonumber relativenumber
    elseif &l:number == 0 && &l:relativenumber == 0
        setl number
    else
        setl nonumber norelativenumber
    endif
endfunc
