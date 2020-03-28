"Utility functions for Go

"""Run go fmt on current buffer.
func! go#Format() abort
    let l:tmpname = tempname()."go"
    call util#ExecOnBufferFile(["go", "fmt", l:tmpname])
endfunc

func! go#Imports() abort
endfunc

"""Update current with contents of 
