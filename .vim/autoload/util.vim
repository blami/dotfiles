"General utility functions

"Cycle between line numbers, relative numbers and no numbers.
func! util#ToggleNumber() abort
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

"Enable spell and cycle spelllangs present in g:spellangs.
func! util#ToggleSpellLang() abort
    if &spell == 0 | return | endif

    "Find spelllang index in g:spelllangs (-1 if not present)
    let i = index(g:spelllangs, &spelllang)
    "If index is unset set it to the first item, otherwise cycle
    if i < 0
        let i = 0
    else
        let i = i + 1 == len(g:spelllangs) ? 0 : i + 1
    endif
    "Set spelllang and spellfile
    exe 'setl spelllang='.get(g:spelllangs, l:i)
    exe 'setl spellfile='
                \ .$HOME.'/.vim/spell/'.&spelllang.'.utf8.add,,'
                \ .$HOME.'/.vim/spell/common.utf8.add'
endfunc

function! util#ToggleList(bufname, pfx)
    "Get list of buffers
    redir => l:buflist
    silent! ls!
    redir END

    for l:bufnum in map(filter(split(l:buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(l:bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction

"Execute given cmd (a list) with a:000 passed to STDIN and return [rc, out]
"NOTE: cmd is a list, e.g. ["ls", "-la", "/foo/bar"]
func! util#Exec(cmd, ...) abort
    "Store original shell variables
    let l:shell = &shell
    let l:shellredir = &shellredir
    let l:shellcmdflag = &shellcmdflag
    let l:shellslash = &shellslash

    set noshellslash
    set shell=/bin/sh shellredir=>%s\ 2>&1 shellcmdflag=-c
    "TODO If Windows
    "let &shell=$COMSPEC
    "set shellcmdflag=/C

    try
        let l:cmd = join(map(copy(a:cmd), 'shellescape(v:val)'), ' ')
        let l:out = call('system', [l:cmd] + a:000)
        echo l:out
        let l:rc = v:shell_error
    finally
        "Recover shell variables
        let &shell = l:shell
        let &shellredir = l:shellredir
        let &shellcmdflag = l:shellcmdflag
        let &shellslash = l:shellslash
    endtry
    return [l:rc, l:out]
endfunc

"Execute cmd, pass buffer to its STDIN and on errors pass output to errfunc.
func! util#ExecBuffer(cmd) abort
endfunc

"Execute given cmd, pass buffer to its STDIN and replace buffer with its
"STDOUT. On errors pass output to errfunc.
func! util#ExecReplaceBuffer(cmd) abort
endfunc

"Execute given cmd on buffer file (of tmpfile name) and replace buffer with
"contents of tmpfile after cmd finishes. On errors pass output to errfunc.
func! util#ExecReplaceBufferFile(cmd, tmpfile) abort
    "Write buffer to a temporary file of given name, don't run autocommands
    "
    exe 'noautocmd silent write!' a:tmpfile

    "Store window
    let l:winview = winsaveview()

    " Run given command
    call add(a:cmd, a:tmpfile)
    let [l:rc, l:out] = call(function('util#Exec'), [a:cmd])
    if l:rc
        "TODO pass errors to caller
        echo "errors:" l:out
        call delete(a:tmpfile)
        return
    endif

    "Ignore events so Vim doesn't reload filetype plugins, etc.
    let l:eventignore = &eventignore
    let &eventignore = 'all'
    "Remove undo point caused by BufWritePre
    try | silent undojoin | catch | endtry
    "Update file
    let l:fileformat = &fileformat
    let l:fperm = getfperm(expand('%'))
    call rename(a:tmpfile, expand('%'))
    call setfperm(expand('%'), l:fperm)
    silent edit!
    let &eventignore = l:eventignore
    let &fileformat = l:fileformat
    let &syntax = &syntax

    "Restore window
    call winrestview(l:winview)
endfunc

"Generate comment based on current filetype.
func! util#Comment(str) abort
    return printf(&commentstring, a:str)
endfunc

"Restore cursor position in file.
func! util#RestoreCursorPosition() abort
    "TODO Store types in global variable
    let ignoreft = ['gitcommit', 'hgcommit']
    if index(ignoreft, &ft) >= 0
        return
    endif
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g'\""
    endif
endfunc

"Paste helper for terminal bracketed mode.
func! util#XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ''
endfunc
