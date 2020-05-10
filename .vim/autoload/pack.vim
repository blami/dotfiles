"Vim 8 native plugin manager

if exists('g:loaded_pack')
    finish
endif
let g:loaded_pack = 1

let s:cpo_save = &cpo
set cpo&vim

"Directory to install package groups to
"let g:packpath_install = "$HOME/.vim/pack"
"let s:packs = {}

"let s:packpath = ""

func! s:define_commands()
    "command! -
endfunc

func! s:err(msg)
    echohl ErrorMsg
    echo a:msg
    echohl None
endfunc

"Initialize
func! pack#begin(path)
    if exists('s:packs')
        return s:err('pack#begin() was called before!')
    endif
    let s:path = a:path
    let s:packs = {}
    call s:define_commands()
endfunc

func! pack#end()
    if !exists('s:packs')
        return s:err('pack#end() called without calling pack#begin()!')
    endif
    "TODO
endfunc

"Add plugin to a given group
func! pack#register(group, repo, ...) abort
    if !has_key(s:packs, a:group)
        let s:packs[a:group] = []
    endif
    call add(s:packs[a:group], a:repo)
endfunc

"Install packs
func! pack#Install() abort
    for l:group in keys(s:packs)
        for l:repo in s:packs[l:group]
            "Check if dir exists and if not clone, otherwise pull
            echo git clone ll:repo
        endfor
    endfor
endfunc


"command! -nargs=+ -bar Pack call Pack#(<args>)

let &cpo = s:cpo_save
unlet s:cpo_save
