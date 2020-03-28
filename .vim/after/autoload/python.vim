"Utility functions for Python

"""Run black on current buffer.
func! python#Format() abort
    let l:tmpname = tempname()."py"
    call util#ExecOnBufferFile(["black", l:tmpname], l:tmpname, "")
endfunc
