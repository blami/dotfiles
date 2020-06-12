"Utility functions for Go

"Run go fmt on current buffer.
func! go#Format() abort
    let l:tmpname = tempname().".go"
    call util#ExecReplaceBufferFile(["goimports", "-w"], l:tmpname)
    "call util#ExecReplaceBufferFile(["go", "fmt"], l:tmpname)
endfunc

"Run goimports on current buffer.
func! go#Imports() abort
    call util#ExecReplaceBuffer(["goimports"])
endfunc

"""Update current with contents of 
