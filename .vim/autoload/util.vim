" ~/.vim/autoload/util.vim - utility functions

" {{{ Toggles
" Cycle between line numbers, relative numbers and no numbers.
func! util#ToggleNumber()
    if &l:number == 1 && &l:relativenumber == 0
        setl nonumber
        setl relativenumber
    elseif &l:number == 0 && &l:relativenumber == 0
        setl number
    else
        setl nonumber
        setl norelativenumber
    endif
endfunc

" Enable spell and cycle spelllangs present in g:spellangs.
func! util#ToggleSpellLang()
    if &spell == 0 | return | endif

    " Find spelllang index in g:spelllangs (-1 if not present)
    let l:i = index(g:spelllangs, &spelllang)
    " If index is unset set it to the first item, otherwise cycle
    if l:i < 0
        let l:i = 0
    else
        let l:i = l:i + 1 == len(g:spelllangs) ? 0 : l:i + 1
    endif
    " Set spelllang and spellfile
    exe 'setl spelllang='.get(g:spelllangs, l:i)
    exe 'setl spellfile='.$HOME.'/.vim/spell/custom-'.&spelllang.'.utf8.add'
                \ .','.g:spellfile_common
endfunc
" }}}
