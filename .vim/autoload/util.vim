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

" Toggle line wrapping (both 'fo' and 'tw').
func! util#ToggleLineWrap()
    if matchstr(&fo, 't') != 't'
        let &l:tw = get(b:, 'orig_tw', 0)
        setl fo+=t
    else
        setl fo-=t
        if &tw != 0
            let b:orig_tw = &tw
            setl tw=0
        endif
    endif
endfunc

" Enable spell and cycle spelllangs present in g:spellangs.
func! util#ToggleSpellLang()
    if &spell == 0 | return | endif

    " Find spelllang index in g:spelllangs (-1 if not present)
    let i = index(g:spelllangs, &spelllang)
    " If index is unset set it to the first item, otherwise cycle
    if i < 0
        let i = 0
    else
        let i = i + 1 == len(g:spelllangs) ? 0 : i + 1
    endif
    " Set spelllang and spellfile
    exe "setl spelllang=".get(g:spelllangs, l:i)
    exe "setl spellfile="
                \ .$HOME."/.vim/spell/".&spelllang.".utf8.add,,"
                \ .$HOME."/.vim/spell/common.utf8.add"
endfunc
" }}}

" {{{ Callables
" Run built program (F5) by utilizing function registered by ftplugin.
func! util#Run()
    echomsg "No run routine has been set"
endfunc

" Execute given command in given directory and return a tuple of exit code and
" output
func! util#Exec(cmd, ...) abort
    let l:err = 0
    let l:out = ''

    return [l:err, l:out]
endfunc
" }}}

" {{{ Misc
" Restore cursor position in file.
func! util#RestoreCursorPosition()
    " TODO Store types in global variable
    let ignoreft = ["gitcommit", "hgcommit"]
    if index(ignoreft, &ft) >= 0
        return
    endif
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g'\""
    endif
endfunc

" Paste helper for terminal bracketed mode.
func! util#XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunc
" }}}
