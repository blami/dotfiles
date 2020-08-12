"Vim 8 native plugin manager

if exists('g:loaded_pack')
    finish
endif
let g:loaded_pack = 1

let s:cpo_save = &cpo
set cpo&vim


"TODO Add functionality to register packs, clone them to packdir and remove
"them.


let &cpo = s:cpo_save
unlet s:cpo_save
