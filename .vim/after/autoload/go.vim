"Utility functions for Go

"""Run go fmt (or goimports) on current buffer.
func! go#Format() abort
    let l:tmpfile = tempname().".go"

    ""call writefile(


    "echo(util#Exec("go fmt")
endfunc

func! go#Imports() abort
endfunc
