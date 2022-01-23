"ftplugin.vim - various ftplugin utilities

"Switch between two files based on filename regexes.
"NOTE This always matches only the basename, never full path!
"TODO Also this will not work well with filenames that contain \N; heresy!
func! blami#ftplugin#SwitchFile(regex1, replace1, regex2, replace2) abort
"Try to match current file against regex1 if matches open replace1 if not try 
    let curfile = expand('%:t')

    let matches = matchlist(curfile, a:regex1)
    let newfile = a:replace1
    if !len(matches)
        let matches = matchlist(curfile, a:regex2)
        if !len(matches)
            "Unable to match neither 1 nor 2; bail out
            "TODO
            echomsg 'Unable to toggle between files'
            return
        endif
        let newfile = a:replace2
    endif

    "Replace \N in newfile with appropriate matches (break out if no more \Ns)
    let i = 0 | while i < len(matches)
        let newfile = substitute(newfile, '\\'.i, matches[i], 'g')
        if match(newfile, '\\[0-9]\+') == -1 | break | endif
        let i += 1
    endwhile
    exec 'edit '.newfile
endfunc
