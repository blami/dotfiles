"Pack utilities

"Add one or more packs
func blami#pack#Add(...) abort
    for i in range(1, a:0)
        let name=get(a:, i)
        try
            exec 'packadd!' name
        catch
            echom 'pack' name 'not found'
        endtry
    endfor
endfunc
